-- AtLua 变量/列表 UI
-- 使用 At.Panel / At.Label / At.Button 绘制；所有坐标均为窗口坐标，
-- 舞台坐标统一经 rt.host.monitor_layout 转换，避免 scale 重复相乘。
local V = require("rt.values")
local Layout = require("rt.host.monitor_layout")

local M = {}
M.__index = M

local function getAt()
  local ok, A = pcall(require, "At.At")
  return ok and A or nil
end

local function metas(g)
  local out = {}
  for _, m in pairs(g.var_meta or {}) do if m.visible ~= false then out[#out + 1] = m end end
  table.sort(out, function(a, b)
    local ax, ay = (a.position and a.position.x) or 0, (a.position and a.position.y) or 0
    local bx, by = (b.position and b.position.x) or 0, (b.position and b.position.y) or 0
    if ay ~= by then return ay < by end
    return ax < bx
  end)
  return out
end

local function list_metas(g)
  local out = {}
  for _, m in ipairs(metas(g)) do
    if m.type == "list" or m.type == "private_list" then out[#out + 1] = m end
  end
  -- 列表查看页的左右切换顺序 = bcmkn variablesDict 的 JSON 顺序（编译期 order）。
  table.sort(out, function(a, b)
    return (tonumber(a.order) or 0) < (tonumber(b.order) or 0)
  end)
  return out
end

local ellipsize -- 定义在下方，ListLines 需要引用这个 upvalue

-- 超长列表的虚拟绘制层：不再为每一项创建 Panel/Label，只画视口附近的行。
-- ScrollView 负责滚动/裁剪；这里按 scrollY 计算 first/last，draw 成本 O(可见行数)。
local ListLines = {}
ListLines.__index = ListLines

function ListLines.new(opts)
  local self = setmetatable({}, ListLines)
  for k, v in pairs(opts or {}) do self[k] = v end
  self.visible = true
  self.x, self.y = 0, 0
  self._disp = {}
  return self
end

function ListLines:measure(availW)
  self.w = math.max(1, tonumber(availW) or self.w or 1)
  local n = #(self.list or {})
  self.h = math.max(self.row_h or 30, n * (self.row_h or 30))
  return self.w, self.h
end

function ListLines:_line(i)
  local raw = V.list_display((self.list or {})[i])
  local c = self._disp[i]
  if c and c.raw == raw then return c.text end
  local text = ellipsize(self.value_font, raw, self.value_max)
  self._disp[i] = { raw = raw, text = text }
  return text
end

function ListLines:draw()
  local n = #(self.list or {})
  if n == 0 then return end
  local A = self.at
  local row_h = self.row_h or 30
  local view = self.view
  local scroll = view and view.scrollY or 0
  local view_h = view and view.h or self.h
  local first = math.max(1, math.floor(scroll / row_h) + 1)
  local last = math.min(n, math.ceil((scroll + math.max(1, view_h)) / row_h))
  if first > last then return end

  local prevFont = love.graphics.getFont()
  local prevR, prevG, prevB, prevA = love.graphics.getColor()
  local safe = A and A.Label and A.Label.safe_utf8 or function(x) return tostring(x) end
  local f = self.value_font or (A and A.font and A.font.get(self.font_size or 15))
  if f then love.graphics.setFont(f) end
  local x, y = A and A.pixel and A.pixel.round(self.x) or self.x,
                A and A.pixel and A.pixel.round(self.y) or self.y
  local text_dy = self.text_dy or 0

  for i = first, last do
    local yy = y + (i - 1) * row_h + text_dy
    if A and A.color then A.color.setColor(self.index_color or "#9FB3D3", 255) end
    love.graphics.print(safe(tostring(i).."."), x, yy)
    if A and A.color then A.color.setColor(self.value_color or "#E8ECF2", 255) end
    love.graphics.print(safe(self:_line(i)), x + (self.value_x or 0), yy)
  end

  love.graphics.setFont(prevFont)
  love.graphics.setColor(prevR, prevG, prevB, prevA)
end

M._ListLines = ListLines

function M.new(host)
  return setmetatable({ host = host, parts = {}, widgets = {}, modal = nil, at = nil, built = false,
    scroll_offset = 0, win_w = 0, win_h = 0 }, M)
end

function M:clear()
  if not self.at then return end
  for _, c in ipairs(self.parts) do pcall(self.at.remove, c) end
  if self.modal then
    for _, c in ipairs(self.modal.parts or {}) do pcall(self.at.remove, c) end
  end
  self.parts, self.widgets, self.modal = {}, {}, nil
end

function M:add(c)
  self.parts[#self.parts + 1] = c
  self.at.add(c)
  return c
end

-- 无 At 字体时的最后兜底；正常路径使用 text_metrics 的实测宽度。
local function base_width(name, value)
  local nw = #tostring(name) * 11
  if value then return nw + #tostring(value) * 11 + 60 end
  return nw + 40
end

-- 按最终像素字号量文本真实宽度（At 字体缓存）；没有字体时退回按字符估算。
-- 返回 width, font（font 可能为 nil）。
local function text_metrics(A, size, text)
  local f
  if A and A.font and A.font.get then
    local ok, got = pcall(A.font.get, size)
    if ok then f = got end
  end
  text = tostring(text or "")
  if f and f.getWidth then
    local ok, w = pcall(f.getWidth, f, text)
    if ok and type(w) == "number" then return w, f end
  end
  local s = (tonumber(size) or 16) / 16
  if s <= 0 then s = 1 end
  return #text * 11 * s, f
end

-- 按像素宽度截断并补省略号；按 UTF-8 字符遍历，避免切出半个汉字。
function ellipsize(f, text, max_w)
  text = tostring(text or "")
  max_w = tonumber(max_w) or 0
  if text == "" or max_w <= 0 then return "" end
  local function width(s)
    if f and f.getWidth then
      local ok, w = pcall(f.getWidth, f, s)
      if ok and type(w) == "number" then return w end
    end
    return #s * 11
  end
  if width(text) <= max_w + 0.5 then return text end
  local ell = "…"
  local ell_w = width(ell)
  if ell_w > max_w then return "" end
  local out = ""
  for ch in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
    local next_s = out .. ch
    if width(next_s) + ell_w > max_w then break end
    out = next_s
  end
  return out .. ell
end

-- 与 monitor_layout.stage_rect 相同的缩放口径（只用于提前按最终字号量文本）。
local function widget_scale(host, g, m)
  local fit = Layout.fit(host, g)
  if type(fit) ~= "number" or fit <= 0 then fit = 1 end
  local scale = tonumber(m.scale) or 1
  if scale < 1 then scale = 1 elseif scale > 2 then scale = 2 end
  return fit * scale
end

function M:build(g)
  local A = getAt()
  if not A then return end
  if self.at ~= A then self.at = A; self.built = false end
  local n = #metas(g)
  local ww, wh = 0, 0
  if love and love.graphics and love.graphics.getDimensions then ww, wh = love.graphics.getDimensions() end
  if self.built and self.game == g and self.n == n and self.win_w == ww and self.win_h == wh then return end
  self.game, self.n, self.built = g, n, true
  self.win_w, self.win_h = ww, wh
  self:clear()

  for _, m in ipairs(metas(g)) do
    local is_list = m.type == "list" or m.type == "private_list"
    local name = (m.entity_name and m.entity_name ~= "") and (m.entity_name .. " · " .. tostring(m.name)) or tostring(m.name or m.id)
    local value = is_list and "" or V.str(g:get_var(m.id))

    -- 先按最终字号量名称/值，再反推不含缩放的基础宽：
    -- 这样值框紧贴内容而不是按 #字符×11 粗略估算，长名称也不会把值框顶出面板。
    local s = widget_scale(self.host, g, m)
    local font_px = 16 * s
    local name_w_px, font_obj = text_metrics(A, font_px, name)
    local value_w_px = text_metrics(A, font_px, value)
    local base_w
    if is_list then
      if font_obj and s > 0 then
        -- 名称胶囊 = 文字 + 左右内边距；外层 = 胶囊 + 箭头 + 外边距。
        local pill_pad = 20 * s
        local arrow_px = text_metrics(A, font, "▽") or 0
        -- 名称胶囊与箭头之间的间距缩短；外层总宽同步缩短。
        base_w = (6*s + name_w_px + pill_pad * 2 + 2*s + arrow_px + 6*s) / s
      else
        base_w = base_width(name)
      end
    elseif font_obj and s > 0 then
      local pad_l, gap, pad_r, value_pad = 12 * s, 12 * s, 10 * s, 16 * s
      base_w = (pad_l + name_w_px + gap + value_w_px + value_pad * 2 + pad_r) / s
    else
      base_w = base_width(name, value)
    end
    local x, y, w, h, font = Layout.stage_rect(self.host, g, m, base_w, 64, 16)

    local bg = is_list and "#000000" or "#111820"
    local alpha = is_list and 80 or 235
    local border = "#3A485A"
    local root = A.Panel{ x=x, y=y, w=w, h=h, radius=12*s, background=bg, alpha=alpha,
      borderColor=border, borderWidth=1, autoRegister=false }
    self:add(root)

    if is_list then
      -- 名称胶囊只由文字宽度 + 左右内边距决定；外层宽度由胶囊布局兜底。
      local name_px = select(1, text_metrics(A, font, name))
      local pill_pad = 20*s
      local arrow_w = select(1, text_metrics(A, font, "▽"))
      local pill_w = math.min(w - (6*s + 2*s + arrow_w + 6*s), name_px + pill_pad * 2)
      if pill_w < 0 then pill_w = 0 end
      local pill = A.Panel{ x=x+6*s, y=y+6*s, w=pill_w, h=math.max(0, h-12*s), radius=8*s,
        background="#2A3444", alpha=245, autoRegister=false }
      self:add(pill)
      local arrow_x = x + w - 6*s - arrow_w
      if arrow_x < x + 4 then arrow_x = x + 4 end
      local name_max = math.max(0, pill_w - pill_pad * 2)
      local lab = A.Label{ x=pill.x+pill_pad, y=y+(h-font)/2, text=ellipsize(font_obj, name, name_max),
        fontSize=font, color="#E8ECF2", interactive=false }
      self:add(lab)
      local arrow = A.Label{ x=arrow_x, y=y+(h-font)/2, text="▽", fontSize=font, color="#9FB3D3", interactive=false }
      self:add(arrow)
      local btn = A.Button{ x=x, y=y, w=w, h=h, text="", fontSize=1, color="#000000", alpha=0,
        shadow=false, ripple=false, onClick=function() self:open_list(g, m) end }
      self:add(btn)
    else
      local value_pad = 16 * s
      local value_want = value_w_px + value_pad * 2
      local name_w, vx, vw = Layout.variable_columns(x, w, name_w_px, value_want, s)
      local name_disp = ellipsize(font_obj, name, name_w)
      local value_disp = ellipsize(font_obj, value, math.max(0, vw - value_pad * 2))
      local lab = A.Label{ x=x+12*s, y=y+(h-font)/2, text=name_disp, fontSize=font, color="#E8ECF2", interactive=false }
      self:add(lab)
      self.widgets[m.id] = { value_label = nil, name_label = lab, font = font_obj, max_w = vw - value_pad*2 }
      local box = A.Panel{ x=vx, y=y+8*s, w=vw, h=math.max(0, h-16*s), radius=8*s, background="#0B1118", alpha=255,
        borderColor="#3A485A", borderWidth=1, autoRegister=false }
      self:add(box)
      local vl = A.Label{ x=vx+value_pad, y=y+(h-font)/2, text=value_disp, fontSize=font, color="#FFFFFF", interactive=false }
      self:add(vl)
      if self.widgets[m.id] then self.widgets[m.id].value_label = vl end
    end
  end
end

function M:sync_values(g)
  for id, w in pairs(self.widgets or {}) do
    local m = (g.var_meta or {})[id]
    if m and w.value_label and m.type ~= "list" and m.type ~= "private_list" then
      local v = g:get_var(id)
      local text = V.str(v)
      local shown = ellipsize(w.font, text, w.max_w or 0)
      if tostring(w.value_label.text or "") ~= shown then
        w.value_label:setText(shown)
        -- 值变化后下一帧按新文字重排/重测宽度（不能只换文字）
        self.built = false
      end
    end
  end
end

function M:open_list(g, m)
  local A = getAt(); if not A then return end
  self.scroll_offset = 0
  if self.modal then
    for _, c in ipairs(self.modal.parts) do pcall(A.remove, c) end
  end
  local sw, sh = love.graphics.getDimensions()
  local fit, ox, oy = Layout.fit(self.host, g)
  local stage_w_px, stage_h_px = g.stage_w * fit, g.stage_h * fit
  local panel_w = math.min(420 * fit, stage_w_px * 0.9, sw * 0.9)
  local max_panel_h = math.min(520 * fit, stage_h_px * 0.9, sh * 0.9)
  local list = g:get_list(m.id)
  if type(list) ~= "table" then list = {} end
  local top = 52 * fit
  local row_h = 30 * fit
  local bottom_pad = 10 * fit
  local view_h = math.max(1, max_panel_h - top - bottom_pad)
  -- 列表面板高度固定，不随列表项数量变化（空列表也一样）。
  local panel_h = max_panel_h
  local px, py = ox + (stage_w_px - panel_w) / 2, oy + (stage_h_px - panel_h) / 2
  local mask = A.Panel{ x=0, y=0, w=sw, h=sh, background="#000000", alpha=120, autoRegister=false }
  local panel = A.Panel{ x=px, y=py, w=panel_w, h=panel_h, radius=12*fit, background="#111820", alpha=245,
    borderColor="#3A485A", borderWidth=1, autoRegister=false }
  local title = A.Label{ x=px+16*fit, y=py+14*fit, text=tostring(m.name or m.id), fontSize=18*fit,
    textColor="#FFFFFF", color="#FFFFFF", interactive=false }
  local close = A.Button{ x=px+panel_w-42*fit, y=py+8*fit, w=34*fit, h=30*fit, text="×", fontSize=20*fit,
    radius=8*fit, textColor="#FFFFFF", color="#2A3444", shadow=false, ripple=false,
    onClick=function() self:close_modal() end }
  local parts = { mask, panel }
  local content_x = px + 16*fit
  local content_w = panel_w - 32*fit
  local index_px, index_font = text_metrics(A, 15*fit, tostring(math.max(1, #list))..".")
  index_px = index_px or 0
  local value_font = select(2, text_metrics(A, 15*fit, "0")) or index_font
  local value_x = index_px + 10*fit
  local value_max = math.max(0, content_w - value_x)
  local view
  if #list > 0 then
    local content = ListLines.new{
      at = A, list = list, row_h = row_h, font_size = 15*fit,
      value_font = value_font, value_x = value_x, value_max = value_max,
      index_color = "#9FB3D3", value_color = "#E8ECF2",
      text_dy = math.max(0, (row_h - (value_font and value_font:getHeight() or 15*fit)) / 2),
    }
    content:measure(content_w)
    view = A.ScrollView{ x=content_x, y=py+top, w=content_w, h=view_h,
      content=content, scrollbar=true, background="#111820" }
    content.view = view
  end
  -- 左右切换：严格 JSON 顺序，不循环；首项禁用上一、末项禁用下一。
  local ids = list_metas(g)
  local idx = 1
  for i, x in ipairs(ids) do if x.id == m.id then idx = i end end
  -- 左右按钮放在面板外侧，竖长圆角矩形，半透明；不遮挡列表滚动条。
  local nav_w, nav_h = 26 * fit, 54 * fit
  local nav_y = py + (panel_h - nav_h) / 2
  local nav_gap = 8 * fit
  local stage_left, stage_right = ox, ox + stage_w_px
  local prev_x = px - nav_w - nav_gap
  local next_x = px + panel_w + nav_gap
  if prev_x < stage_left then prev_x = stage_left end
  if next_x + nav_w > stage_right then next_x = stage_right - nav_w end
  local prev = A.Button{ x=prev_x, y=nav_y, w=nav_w, h=nav_h, text="‹", fontSize=20*fit,
    radius=8*fit, color="#2A3444", textColor="#FFFFFF", shadow=false, ripple=false,
    alpha=(idx > 1) and 150 or 60,
    onClick=function() if idx > 1 then self:open_list(g, ids[idx-1]) end end }
  local nxt = A.Button{ x=next_x, y=nav_y, w=nav_w, h=nav_h, text="›", fontSize=20*fit,
    radius=8*fit, color="#2A3444", textColor="#FFFFFF", shadow=false, ripple=false,
    alpha=(idx < #ids) and 150 or 60,
    onClick=function() if idx < #ids then self:open_list(g, ids[idx+1]) end end }
  parts[#parts+1] = title
  if view then parts[#parts+1] = view end
  parts[#parts+1] = prev
  parts[#parts+1] = nxt
  parts[#parts+1] = close
  self.modal = { parts = parts, m = m, ids = ids, index = idx }
  for _, c in ipairs(parts) do A.add(c) end
end

function M:close_modal()
  if not self.modal or not self.at then return end
  for _, c in ipairs(self.modal.parts) do pcall(self.at.remove, c) end
  self.modal = nil
  self.scroll_offset = 0
end

function M:draw(g)
  if not g or (self.host and self.host.hide_variables) then return end
  self:build(g)
  self:sync_values(g)
  for _, c in ipairs(self.parts) do if c.draw then c:draw() end end
  if self.modal then for _, c in ipairs(self.modal.parts) do if c.draw then c:draw() end end end
end

-- H 的旧输入路径已移除；输入由 AtUI 统一派发。
function M:press() return false end
function M:move() end
function M:release() return false end
function M:wheel(dy)
  if self.modal then
    self.scroll_offset = math.max(0, (self.scroll_offset or 0) - (dy or 0))
  end
end

return M
