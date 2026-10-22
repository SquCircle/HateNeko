-- 设备键模拟：左下 WASD 十字、右下方向键十字；右侧 KEY 控制显示。
-- 只在 host.key_sim（测试/触屏包）启用。
local M = {}
M.__index = M

local function At()
  local ok, a = pcall(require, "At.At")
  return ok and a or nil
end

local LAYOUT = {
  { code = 87, text = "W" },
  { code = 65, text = "A" },
  { code = 83, text = "S" },
  { code = 68, text = "D" },
}
local ARROWS = {
  { code = 38, text = "↑" },
  { code = 37, text = "←" },
  { code = 40, text = "↓" },
  { code = 39, text = "→" },
}

function M.new(host)
  return setmetatable({
    host = host, screen_w = 0, screen_h = 0, built = false,
    pad_visible = true,
    buttons = {}, pads = {}, active = {},
    ctrl = nil,
  }, M)
end

local function release_active(self)
  if not self.host or not self.host.simulate_key_up then return end
  for code in pairs(self.active) do
    self.host:simulate_key_up(code)
  end
  self.active = {}
end

local function make_button(self, A, code, text)
  local b
  b = A.Button({
    text = text, fontSize = 18, w = 46, h = 46,
    radius = 10, color = "#202A38", alpha = 205,
    textColor = "#FFFFFF", shadow = false, ripple = false,
    onPress = function()
      if not self.pad_visible then return end
      self.active[code] = true
      if self.host.simulate_key_down then self.host:simulate_key_down(code) end
    end,
    onRelease = function()
      if self.active[code] then
        self.active[code] = nil
        if self.host.simulate_key_up then self.host:simulate_key_up(code) end
      end
    end,
  })
  A.add(b)
  self.buttons[#self.buttons + 1] = b
  self.pads[#self.pads + 1] = b
  return b
end

local function layout(self)
  local sw, sh = love.graphics.getDimensions()
  local pad, gap = 46, 6
  local span = pad * 3 + gap * 2
  local left = 14
  local right = sw - span - 14
  local bottom = sh - 14 - span
  local mid_y = bottom + pad + gap
  local function set(b, x, y)
    if b then b:setRect(x, y, pad, pad) end
  end
  -- WASD
  set(self.w, left + pad + gap, bottom)
  set(self.a, left, mid_y)
  set(self.s, left + pad + gap, bottom + 2 * (pad + gap))
  set(self.d, left + 2 * (pad + gap), mid_y)
  -- arrows
  set(self.up, right + pad + gap, bottom)
  set(self.left, right, mid_y)
  set(self.down, right + pad + gap, bottom + 2 * (pad + gap))
  set(self.right, right + 2 * (pad + gap), mid_y)
  -- toggle: replace old A key position
  if self.ctrl then self.ctrl:setRect(sw - 64, sh / 2 - 24, 48, 48) end
end

function M:ensure(A)
  if self.built then return end
  self.built = true
  self.w = make_button(self, A, 87, "W")
  self.a = make_button(self, A, 65, "A")
  self.s = make_button(self, A, 83, "S")
  self.d = make_button(self, A, 68, "D")
  self.up = make_button(self, A, 38, "↑")
  self.left = make_button(self, A, 37, "←")
  self.down = make_button(self, A, 40, "↓")
  self.right = make_button(self, A, 39, "→")
  self.ctrl = A.Button({
    text = "KEY", fontSize = 12, w = 48, h = 48, radius = 10,
    color = "#2A3444", textColor = "#FFFFFF", shadow = false, ripple = false,
    onClick = function()
      self.pad_visible = not self.pad_visible
      if not self.pad_visible then release_active(self) end
      for _, b in ipairs(self.pads) do b:setVisible(self.pad_visible) end
    end,
  })
  A.add(self.ctrl)
end

function M:draw(g)
  if not self.host or not self.host.key_sim then return end
  local A = At(); if not A then return end
  local sw, sh = love.graphics.getDimensions()
  self:ensure(A)
  if self.screen_w ~= sw or self.screen_h ~= sh then
    self.screen_w, self.screen_h = sw, sh
    layout(self)
  end
  -- 只在需要时设置一次可见性；隐藏后按钮不参与命中（Component 检查 visible）。
  for _, b in ipairs(self.pads) do
    if b.visible ~= self.pad_visible then b:setVisible(self.pad_visible) end
  end
  if self.ctrl and self.ctrl.visible ~= true then self.ctrl:setVisible(true) end
  if self.pad_visible then
    for _, b in ipairs(self.pads) do if b.draw then b:draw() end end
  end
  if self.ctrl and self.ctrl.draw then self.ctrl:draw() end
end

return M
