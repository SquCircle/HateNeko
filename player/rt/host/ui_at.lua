-- 界面积木的 AtLua 层：舞台对话框、输入框、选择框；对话/思考气泡用官方风格绘制。
local V = require("rt.values")

local M = {}
M.__index = M
local function At() local ok,a=pcall(require,"At.At"); return ok and a or nil end
local function ui() return require("rt.impl.ui") end

function M.new(host) return setmetatable({host=host, stage=nil, dialog=nil, translate=nil, bubble_font=nil}, M) end

local function stage_rect(host,g)
  local x1,y1=host:world_to_screen(-g.stage_w/2,g.stage_h/2,g)
  local x2,y2=host:world_to_screen(g.stage_w/2,-g.stage_h/2,g)
  return x1,y1,x2-x1,y2-y1,(x2-x1)/g.stage_w
end

-- 所有弹窗共用同一左右外边距和宽度；高度由内容决定，但框体形状/圆角一致。
-- 所有弹窗统一：舞台高的 1/2，底部对齐；文本从卡片顶部开始。
local function modal_geom(sx, sy, sw, sh, fit)
  local margin = 20 * fit
  local ph = math.max(1, sh * 0.5)
  return sx + margin, sy + sh - ph - margin, sw - margin * 2, ph
end

function M:clear_stage()
  local A=At(); if not A then return end
  for _,c in ipairs(self.stage or {}) do pcall(A.remove,c) end
  self.stage=nil; self.stage_label=nil
end
function M:clear_dialog()
  local A=At(); if not A then return end
  for _,c in ipairs(self.dialog or {}) do pcall(A.remove,c) end
  self.dialog=nil; self.dialog_key=nil; self.dialog_input=nil
end
function M:clear_translate()
  local A=At(); if not A then return end
  for _,c in ipairs(self.translate or {}) do pcall(A.remove,c) end
  self.translate=nil
end

function M:sync_geom(g)
  local sx,sy,sw,sh,fit=stage_rect(self.host,g)
  local key=("%.3f:%.3f:%.3f:%.3f"):format(sx,sy,sw,sh)
  if self.geom ~= key then
    self.geom = key
    self:clear_stage(); self:clear_dialog(); self:clear_translate()
    self.stage_text=nil; self.dialog_key=nil; self.translate_text=nil
    self.stage_pages=nil; self.stage_pages_key=nil; self.stage_page=1; self.stage_page_shown=nil
  end
end

-- 弹窗优先级：舞台对话框 > ask/choice 队列 > 翻译框。
function M:modal_kind(g)
  if not g then return nil end
  if g.stage_dialog and not (g.stage_dialog.owner and g.stage_dialog.owner.deleted) then return "stage" end
  if g.dialog_queue and g.dialog_queue[1] then return "dialog" end
  if g.translate_dialog then return "translate" end
  return nil
end

function M:modal_active(g)
  return self:modal_kind(g) ~= nil
end

-- 当前弹窗卡片矩形（窗口坐标）；用于区分"点弹窗"和"点卡片外"。
function M:modal_rect(g)
  if not self:modal_kind(g) then return nil end
  local sx,sy,sw,sh,fit=stage_rect(self.host,g)
  local px,py,pw,ph=modal_geom(sx,sy,sw,sh,fit)
  return px,py,pw,ph
end

local ellipsize -- 定义在下方，分页/截断需要引用

local function get_font(A, size)
  if A and A.font and A.font.get then
    local ok, f = pcall(A.font.get, size)
    if ok then return f end
  end
  return nil
end

local function wrap_lines(f, text, maxw)
  text = tostring(text or "")
  if text == "" then return { "" } end
  if f and f.getWrap then
    local ok, _, lines = pcall(f.getWrap, f, text, math.max(1, maxw))
    if ok and lines and #lines > 0 then return lines end
  end
  -- 没有字体时的兜底：按固定字符宽度硬换行
  local per = math.max(1, math.floor(maxw / 8))
  local out = {}
  for line in (text .. "\n"):gmatch("(.-)\n") do
    local n = 0
    local cur = ""
    for ch in line:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
      cur = cur .. ch; n = n + 1
      if n >= per then out[#out + 1] = cur; cur = ""; n = 0 end
    end
    out[#out + 1] = cur
  end
  if #out == 0 then out[1] = "" end
  return out
end

local function paginate_text(A, size, text, maxw, maxh)
  local f = get_font(A, size)
  local lh = (f and f:getHeight() or size) * 1.2
  local lines = wrap_lines(f, text, maxw)
  local per = math.max(1, math.floor(maxh / math.max(1, lh)))
  local pages = {}
  for i = 1, #lines, per do
    local chunk = {}
    for j = i, math.min(#lines, i + per - 1) do chunk[#chunk + 1] = lines[j] end
    pages[#pages + 1] = { text = table.concat(chunk, "\n") }
  end
  if #pages == 0 then pages[1] = { text = "" } end
  return pages, f, lh
end

local function fit_text(A, size, text, maxw, maxh)
  local f = get_font(A, size)
  local lh = (f and f:getHeight() or size) * 1.2
  local lines = wrap_lines(f, text, maxw)
  local per = math.max(1, math.floor(maxh / math.max(1, lh)))
  if #lines <= per then return table.concat(lines, "\n") end
  local out = {}
  for i = 1, per do out[#out + 1] = lines[i] end
  if f and ellipsize then
    out[#out] = ellipsize(f, tostring(out[#out] or "") .. "…", maxw)
  else
    out[#out] = tostring(out[#out] or "") .. "…"
  end
  return table.concat(out, "\n")
end

function M:build_translate(g)
  local A=At(); if not A then return end
  local d=g.translate_dialog
  if not d then self:clear_translate(); return end
  local key=("translate|%s|%s"):format(tostring(d.text), tostring(d.language))
  if self.translate and self.translate_text==key then return end
  self:clear_translate()
  local sx,sy,sw,sh,fit=stage_rect(self.host,g)
  local px,py,pw,ph = modal_geom(sx,sy,sw,sh,fit)
  local pad=16*fit
  local body_y=py+48*fit
  local action_h=40*fit
  local body_h=math.max(1, py+ph-pad-action_h-body_y)
  local mask=A.Panel{x=sx,y=sy,w=sw,h=sh,background="#000000",alpha=90,
    autoRegister=true,interactive=true,passthrough=false}
  local card=A.Panel{x=px,y=py,w=pw,h=ph,radius=12*fit,background="#111820",alpha=245,
    borderColor="#3A485A",borderWidth=1,autoRegister=false}
  local title=A.Label{x=px+pad,y=py+14*fit,text="翻译",fontSize=16*fit,color="#FFFFFF",interactive=false}
  local body=A.Label{x=px+pad,y=body_y,text=fit_text(A,14*fit,(d.text or "").."  →  "..(d.language or "en"),pw-pad*2,body_h),
    fontSize=14*fit,color="#DCE4F0",w=pw-pad*2,h=body_h,wrap=true,interactive=false}
  local ok=A.Button{x=px+pw-pad-72*fit,y=py+ph-pad-32*fit,w=72*fit,h=32*fit,text="确认",
    fontSize=13*fit,radius=8*fit,color="#2A3444",textColor="#FFFFFF",shadow=false,ripple=false,
    onClick=function() ui().confirm_translation(g) end}
  self.translate={mask,card,title,body,ok}; self.translate_text=key
  for _,c in ipairs(self.translate) do A.add(c) end
end

function M:build_stage(g)
  local A=At(); if not A then return end
  if g.stage_dialog and g.stage_dialog.owner and g.stage_dialog.owner.deleted then
    g.stage_dialog = nil
  end
  if not g.stage_dialog then
    self.stage_pages=nil; self.stage_pages_key=nil; self.stage_page=1; self.stage_page_shown=nil
    self:clear_stage(); return
  end
  local text=tostring(g.stage_dialog.text or "")
  local sx,sy,sw,sh,fit=stage_rect(self.host,g)
  local px,py,pw,ph = modal_geom(sx,sy,sw,sh,fit)
  local pad=16*fit
  local body_y=py+18*fit
  local action_h=42*fit
  local page_h=20*fit
  local body_h=math.max(1, py+ph-pad-action_h-page_h-body_y)
  local body_w=pw-pad*2
  local key=("stage|%s|%.3f|%.3f"):format(text, pw, body_h)
  if self.stage_pages_key ~= key then
    self.stage_pages, self.stage_font = paginate_text(A,16*fit,text,body_w,body_h)
    self.stage_page=1
    self.stage_pages_key=key
  end
  local pages=self.stage_pages or {{text=text}}
  local page=math.max(1, math.min(#pages, self.stage_page or 1))
  if self.stage and self.stage_pages_key==key and self.stage_page_shown==page then return end
  self:clear_stage()
  local mask=A.Panel{x=sx,y=sy,w=sw,h=sh,background="#000000",alpha=52,
    autoRegister=true,interactive=true,passthrough=false}
  local card=A.Panel{x=px,y=py,w=pw,h=ph,radius=12*fit,
    background="#111820",alpha=245,borderColor="#3A485A",borderWidth=1,autoRegister=false}
  local lab=A.Label{x=px+pad,y=body_y,text=pages[page].text,fontSize=16*fit,color="#E8ECF2",
    w=body_w,h=body_h,wrap=true,lineHeight=1.2,interactive=false}
  local last = page >= #pages
  local ok=A.Button{x=px+pw-pad-72*fit,y=py+ph-pad-32*fit,w=72*fit,h=32*fit,
    text=last and "确定" or "下一页",fontSize=13*fit,
    radius=8*fit,color="#2A3444",textColor="#FFFFFF",shadow=false,ripple=false,
    onClick=function()
      if self.stage_page and self.stage_page < #(self.stage_pages or {}) then
        self.stage_page=self.stage_page+1
        self.stage_page_shown=nil
      else
        local sd=g.stage_dialog
        g.stage_dialog=nil
        self.stage_pages=nil; self.stage_pages_key=nil; self.stage_page=1; self.stage_page_shown=nil
        if sd and sd.lock then sd.lock.stop() end
        self:clear_stage()
      end
    end}
  local pg=A.Label{x=px+pad,y=py+ph-pad-30*fit,text=("%d/%d"):format(page,#pages),
    fontSize=12*fit,color="#9FB3D3",interactive=false}
  self.stage={mask,card,lab,ok,pg}; self.stage_text=key; self.stage_page_shown=page; self.stage_label=lab
  for _,c in ipairs(self.stage) do A.add(c) end
end

function M:build_dialog(g)
  local A=At(); if not A then return end
  local d=g.dialog_queue and g.dialog_queue[1]
  local ck=""
  if d and d.choices then for i=1,4 do ck=ck..tostring(d.choices[i]).."\1" end end
  local key=d and (tostring(d.type)..":"..tostring(d.prompt)..":"..ck) or nil
  if not d then self:clear_dialog(); return end
  if self.dialog and self.dialog_key==key then return end
  self:clear_dialog()
  local sx,sy,sw,sh,fit=stage_rect(self.host,g)
  local px,py,pw,ph = modal_geom(sx,sy,sw,sh,fit)
  local pad=16*fit
  local mask=A.Panel{x=sx,y=sy,w=sw,h=sh,background="#000000",alpha=90,
    autoRegister=true,interactive=true,passthrough=false}
  local card=A.Panel{x=px,y=py,w=pw,h=ph,radius=12*fit,background="#111820",alpha=245,
    borderColor="#3A485A",borderWidth=1,autoRegister=false}
  local parts={mask,card}
  local title=A.Label{x=px+pad,y=py+14*fit,text=d.type=="choice" and "选择" or "输入",fontSize=16*fit,color="#FFFFFF",interactive=false}
  parts[#parts+1]=title
  local top=py+48*fit
  local bottom=py+ph-pad
  local input
  if d.type=="ask" then
    local input_h=36*fit
    local submit_h=32*fit
    local submit_y=bottom-submit_h
    local input_y=submit_y-12*fit-input_h
    local prompt_h=math.max(1, input_y-8*fit-top)
    local prompt=A.Label{x=px+pad,y=top,text=fit_text(A,14*fit,d.prompt or "",pw-pad*2,prompt_h),
      fontSize=14*fit,color="#DCE4F0",w=pw-pad*2,h=prompt_h,wrap=true,interactive=false}
    parts[#parts+1]=prompt
    input=A.TextInput{x=px+pad,y=input_y,w=pw-pad*2,h=input_h,fontSize=14*fit,
      color="#0B1118",borderColor="#3A485A",textColor="#FFFFFF",maxLength=0}
    parts[#parts+1]=input
    local ok=A.Button{x=px+pw-pad-64*fit,y=submit_y,w=64*fit,h=submit_h,text="提交",
      fontSize=13*fit,radius=8*fit,color="#2A3444",textColor="#FFFFFF",shadow=false,ripple=false,
      onClick=function() ui().submit_answer(input:getText(),g) end}
    parts[#parts+1]=ok
    input.onSubmit=function(text) ui().submit_answer(text,g) end
  else
    local btn_h=36*fit
    local gap=8*fit
    local grid_y=bottom-(2*btn_h+gap)
    local prompt_h=math.max(1, grid_y-8*fit-top)
    local prompt=A.Label{x=px+pad,y=top,text=fit_text(A,14*fit,d.prompt or "",pw-pad*2,prompt_h),
      fontSize=14*fit,color="#DCE4F0",w=pw-pad*2,h=prompt_h,wrap=true,interactive=false}
    parts[#parts+1]=prompt
    local n=0; for _ in pairs(d.choices or {}) do n=n+1 end
    n=math.min(n,4)
    local btn_w=(pw-pad*2-gap)/2
    for i=1,n do
      local c=d.choices[i]; if c==nil then break end
      local col=(i-1)%2
      local row=math.floor((i-1)/2)
      local b=A.Button{x=px+pad+col*(btn_w+gap),y=grid_y+row*(btn_h+gap),
        w=btn_w,h=btn_h,text=tostring(c),fontSize=13*fit,
        radius=8*fit,color="#2A3444",textColor="#FFFFFF",shadow=false,ripple=false,
        onClick=function() ui().submit_choice(nil,i,g) end}
      parts[#parts+1]=b
    end
  end
  self.dialog=parts; self.dialog_key=key; self.dialog_input=input
  for _,c in ipairs(parts) do A.add(c) end
  if input and self:modal_kind(g)=="dialog" then pcall(input.focus, input) end
end

local function utf8_count(text)
  local n, i = 0, 1
  while i <= #text do
    local b = text:byte(i); n = n + 1
    i = i + ((b < 0x80 and 1) or (b < 0xE0 and 2) or (b < 0xF0 and 3) or 4)
  end
  return n
end

local function utf8_prefix(text, n)
  local out, count, i = "", 0, 1
  while i <= #text and count < n do
    local b = text:byte(i)
    local len = (b < 0x80 and 1) or (b < 0xE0 and 2) or (b < 0xF0 and 3) or 4
    out = out .. text:sub(i, i + len - 1)
    i = i + len
    count = count + 1
  end
  return out
end

function ellipsize(f,text,maxw)
  text=tostring(text or ""); if maxw<=0 then return "" end
  if f:getWidth(text)<=maxw then return text end
  local out=""; for ch in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
    if f:getWidth(out..ch.."…")>maxw then break end; out=out..ch
  end
  return out.."…"
end

function M:update_stage_text(g)
  -- 分页文本在 build_stage 里已经写入；这里不能再写完整文本，否则会覆盖当前页。
end

function M:draw_bubbles(g)
  if not g.bubbles then return end
  local now=require("rt.core").now_ms and require("rt.core").now_ms() or 0
  local sx,sy,sw,sh,fit=stage_rect(self.host,g)
  local t=love.timer.getTime()
  for owner,b in pairs(g.bubbles) do
    if owner.deleted then g.bubbles[owner] = nil end
  end
  for owner,b in pairs(g.bubbles) do
    if b.duration and b.duration>0 then
      -- 使用真实时间；headless/LOVE 都用同一套毫秒。
      local born=b.born_ms
      if not born then b.born_ms=now; born=b.born_ms end
      if now-born>=b.duration then g.bubbles[owner]=nil end
    end
  end
  local f=self.host:make_font()
  if self.bubble_img == nil then
    local ok,img=pcall(love.graphics.newImage,"rt/assets/ui/bubble.png")
    self.bubble_img=ok and img or false
  end
  local size=16*fit
  local k=size/self.host.FONT_BASE
  for owner,b in pairs(g.bubbles or {}) do
    local ex,ey=self.host:world_to_screen(owner.x or 0,owner.y or 0,g)
    -- 气泡不做打字机：本作品在循环内反复设置气泡，逐字显示会被下一轮覆盖。
    local full = b.text or ""
    local text_max = math.max(16, sw - 16*fit - 20*fit)
    local full_w = f:getWidth(full) * k
    local text_w = math.min(full_w, text_max)
    local tail=12*fit
    local bw=math.max(56*fit, text_w + 20*fit)
    local wrap_w = math.max(1, (bw - 20*fit) / k)
    local _, lines = f:getWrap(full, wrap_w)
    if not lines or #lines == 0 then lines = { full } end
    local line_h = f:getHeight() * k
    local th = #lines * line_h
    local bh=math.max(44*fit,th+24*fit)
    -- 气泡主体和尾巴都必须完整落在舞台内；角色在舞台外时气泡贴边。
    if bw > sw-16*fit then bw=sw-16*fit end
    if bh > sh-16*fit-tail then bh=math.max(24*fit, sh-16*fit-tail) end
    local bx=math.max(sx+8*fit,math.min(sx+sw-bw-8*fit,ex-bw/2))
    local by=math.max(sy+8*fit,math.min(sy+sh-bh-tail-8*fit,ey-bh-42*fit))
    -- 官方气泡主体：裁掉原 SVG 左侧尾巴，只在底部中央画新的小三角。
    if self.bubble_img then
      love.graphics.setColor(1,1,1,1)
      local iw,ih=self.bubble_img:getWidth(),self.bubble_img:getHeight()
      local src=9
      local bodyw=iw-src
      local sy=bh/ih
      local l=math.min(18,bodyw/3)*sy
      local r=math.min(12,bodyw/3)*sy
      local cw=math.max(0,bw-l-r)
      love.graphics.draw(self.bubble_img,love.graphics.newQuad(src,0,math.max(1,l/sy),ih,iw,ih),
        bx,by,0,sy,sy)
      love.graphics.draw(self.bubble_img,love.graphics.newQuad(src+l/sy,0,bodyw-l/sy-r/sy,ih,iw,ih),
        bx+l,by,0,cw/math.max(1,bodyw-l/sy-r/sy),sy)
      love.graphics.draw(self.bubble_img,love.graphics.newQuad(iw-r/sy,0,math.max(1,r/sy),ih,iw,ih),
        bx+bw-r,by,0,sy,sy)
    else
      love.graphics.setColor(0.05,0.07,0.11,0.92)
      love.graphics.rectangle("fill",bx,by,bw,bh,10*fit,10*fit)
    end
    love.graphics.setColor(0.05,0.07,0.11,0.92)
    if b.type=="think" then
      love.graphics.circle("fill",bx+bw/2,by+bh+8*fit,4*fit)
      love.graphics.circle("fill",bx+bw/2-8*fit,by+bh+18*fit,2.5*fit)
    else
      -- 小三角位于气泡主体下侧中央。
      local tx=math.max(sx+8*fit,math.min(sx+sw-8*fit,bx+bw/2))
      love.graphics.polygon("fill",tx-8*fit,by+bh,tx+8*fit,by+bh,tx,by+bh+tail)
    end
    local ty = by + math.max(12*fit, (bh - th) / 2)
    for i = 1, #lines do
      self.host:text(lines[i], bx + 10*fit, ty + (i - 1) * line_h, size, nil, {0.9,0.93,0.97,1})
    end
  end
  love.graphics.setColor(1,1,1,1)
end

function M:draw(g)
  if not g then return end
  self:sync_geom(g)
  self:build_stage(g); self:update_stage_text(g); self:build_dialog(g); self:build_translate(g)
  local active=self:modal_kind(g)
  local function show(group,on)
    for _,c in ipairs(group or {}) do
      if c.setVisible then pcall(c.setVisible,c,on) else c.visible=on end
    end
  end
  show(self.stage,active=="stage")
  show(self.dialog,active=="dialog")
  show(self.translate,active=="translate")
  if active~="dialog" and self.dialog_input then
    local A=At()
    if A and A.registry and A.registry.getFocus()==self.dialog_input then A.registry.setFocus(nil) end
  end
  if active=="dialog" and self.dialog_input then pcall(self.dialog_input.focus, self.dialog_input) end
  local group = active=="stage" and self.stage or active=="dialog" and self.dialog or active=="translate" and self.translate
  for _,c in ipairs(group or {}) do if c.draw then c:draw() end end
  self:draw_bubbles(g)
end

return M
