-- 官方计时器：160x100 背景、28px 数值、默认舞台右上 (stage_w-180, 12)。
-- 用 AtLua Label 渲染数值；背景使用官方 timerBackground.svg/png。
local M = {}
M.__index = M
local function At() local ok,a=pcall(require,"At.At"); return ok and a or nil end
function M.new(host) return setmetatable({host=host,label=nil,img=nil,last=0},M) end
local function stage_rect(host,g)
  local x1,y1=host:world_to_screen(-g.stage_w/2,g.stage_h/2,g)
  local x2,y2=host:world_to_screen(g.stage_w/2,-g.stage_h/2,g)
  return x1,y1,x2-x1,y2-y1,(x2-x1)/g.stage_w
end
function M:ensure(g)
  local A=At(); if not A then return nil end
  if not self.label then
    self.label=A.Label{text="0.00",fontSize=28,color="#63ff94",interactive=false}
    A.add(self.label)
  end
  if self.img==nil then
    local ok,img=pcall(love.graphics.newImage,"rt/assets/ui/timerBackground.png")
    self.img=ok and img or false
  end
  return A
end
function M:draw(g)
  if not g or not g.timer_visible then
    if self.label then self.label:setVisible(false) end
    return
  end
  local A=self:ensure(g); if not A then return end
  local sx,sy,sw,sh,fit=stage_rect(self.host,g)
  local pos=g.timer_pos or {x=g.stage_w-180,y=12}
  local tw,th=160*fit,100*fit
  local x=sx+math.max(0,math.min(g.stage_w-160,pos.x))*fit
  local y=sy+math.max(0,math.min(g.stage_h-100,pos.y))*fit
  if self.img then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.img,x,y,0,tw/self.img:getWidth(),th/self.img:getHeight())
  else
    love.graphics.setColor(0.06,0.09,0.08,0.9); love.graphics.rectangle("fill",x,y,tw,th,8*fit,8*fit)
  end
  self.label:setVisible(true)
  self.label:setRect(x,y+th/2-14*fit,tw,28*fit)
  self.label:setText(string.format("%.2f",tonumber(g.timer) or 0))
  self.label.fontSize=28*fit
  self.label.align="center"
  self.label:draw()
end
return M
