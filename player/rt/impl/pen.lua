-- 画笔（笔迹/颜色/印章/笔层）（来自 motion_looks.lua）


local V = require("rt.values")
local C = require("rt.impl.common")
local M = {}

local clamp01, delta_of = C.clamp01, C.delta_of


local function rgb_to_hsl(r, g, b)
  local maxv = math.max(r, g, b)
  local minv = math.min(r, g, b)
  local h, s, l = 0, 0, (maxv + minv) / 2
  local d = maxv - minv
  if d > 0 then
    s = (l > 0.5) and (d / (2 - maxv - minv)) or (d / (maxv + minv))
    if maxv == r then h = (g - b) / d + (g < b and 6 or 0)
    elseif maxv == g then h = (b - r) / d + 2
    else h = (r - g) / d + 4 end
    h = h * 60
  end
  return h, s, l
end

local function hue2rgb(p, q, t)
  if t < 0 then t = t + 1 end
  if t > 1 then t = t - 1 end
  if t < 1 / 6 then return p + (q - p) * 6 * t end
  if t < 1 / 2 then return q end
  if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
  return p
end

local function hsl_to_rgb(h, s, l)
  h = ((h % 360) + 360) % 360 / 360
  if s <= 0 then return l, l, l end
  local q = (l < 0.5) and (l * (1 + s)) or (l + s - l * s)
  local p = 2 * l - q
  return hue2rgb(p, q, h + 1 / 3), hue2rgb(p, q, h), hue2rgb(p, q, h - 1 / 3)
end

local function hsl_to_hex(h, s, l)
  local r, g, b = hsl_to_rgb(h, s, l)
  return string.format("#%02x%02x%02x",
    math.floor(clamp01(r) * 255 + 0.5),
    math.floor(clamp01(g) * 255 + 0.5),
    math.floor(clamp01(b) * 255 + 0.5))
end

local function hsl_to_hsv(h, s, l)
  local v = l + s * math.min(l, 1 - l)
  local sv = 0
  if v > 0 then sv = 2 * (1 - l / v) end
  return h, sv, v
end

local function hsv_to_hsl(h, s, v)
  local l = v * (1 - s / 2)
  local sl = 0
  if l > 0 and l < 1 then sl = (v - l) / math.min(l, 1 - l) end
  return h, sl, l
end

-- 官方画笔颜色体系：HSV（hue 0..360, saturation/value 0..1）

local function rgb_to_hsv(r, g, b)
  local maxv = math.max(r, g, b)
  local minv = math.min(r, g, b)
  local d = maxv - minv
  local h = 0
  if d > 0 then
    if maxv == r then h = ((g - b) / d) % 6
    elseif maxv == g then h = (b - r) / d + 2
    else h = (r - g) / d + 4 end
    h = h * 60
  end
  local s = (maxv <= 0) and 0 or (d / maxv)
  return h, s, maxv
end

local function hsv_to_rgb(h, s, v)
  h = ((h % 360) + 360) % 360 / 60
  local c = v * s
  local x = c * (1 - math.abs((h % 2) - 1))
  local m = v - c
  local r, g, b
  local i = math.floor(h)
  if i == 0 then r, g, b = c, x, 0
  elseif i == 1 then r, g, b = x, c, 0
  elseif i == 2 then r, g, b = 0, c, x
  elseif i == 3 then r, g, b = 0, x, c
  elseif i == 4 then r, g, b = x, 0, c
  else r, g, b = c, 0, x end
  return r + m, g + m, b + m
end

local function hsv_to_hex(h, s, v)
  local r, g, b = hsv_to_rgb(h, s, v)
  return string.format("#%02x%02x%02x",
    math.floor(clamp01(r) * 255 + 0.5),
    math.floor(clamp01(g) * 255 + 0.5),
    math.floor(clamp01(b) * 255 + 0.5))
end

local function pen_sync_color(pen)
  pen.hsv = pen.hsv or pen.hsl or { 0, 0, 0 }
  -- 兼容旧测试/旧状态字段名；新语义以 hsv 为准。
  pen.hsl = pen.hsv
  pen.color = hsv_to_hex(pen.hsv[1] or 0, pen.hsv[2] or 0, pen.hsv[3] or 0)
end

-- 立即把当前笔迹落到 pen layer：官方 moveTargetTo/changeTargetPosition 是即时绘制的。
-- 若延迟到帧末 pen_update，clear_drawing（如轨道每帧清屏）会先重置 origin，HP 血条永远画不出。

function M.self_pen_down(self, args, th)
  if self.pen.down then return end
  self.pen.down = true
  self.pen.last_x, self.pen.last_y = self.x, self.y
  -- 官方 brush.set_pen_down 当帧 draw_line(origin)（crc_libs:1 byte 1146565）；
  -- 即使不移动也要落一个圆点。
  local g = th and th.sched and th.sched.game
  if g and g.host and g.host.pen_dot then
    g.host:pen_dot(self, g)
  end
end

function M.self_pen_up(self)
  self.pen.down = false
  -- 官方 brush.set_pen_up 清 origin（crc_libs:1 byte 1146779）；不漏到下一笔。
  self.pen.last_x, self.pen.last_y = nil, nil
end

function M.clear_drawing(self, args, th)
  -- 官方 callee: clear_pen_drawings —— 清空**整个笔层**（不是某个角色的）
  local g = th.sched.game
  if g.host and g.host.pen_clear then g.host:pen_clear(g) end
end

function M.self_set_pen_size(self, args)
  self.pen.size = math.max(1, math.min(1000, V.num(args.size or args.value)))
end

function M.self_change_pen_size(self, args)
  self.pen.size = math.max(1, math.min(1000, self.pen.size + delta_of(args, "steps", "value")))
end

function M.self_set_pen_color(self, args)
  local c = tostring(args.color or args.value or "#000000")
  local r, g, b = V.rgb(c)
  self.pen.hsv = { rgb_to_hsv(r, g, b) }
  self.pen.hsl = self.pen.hsv
  pen_sync_color(self.pen)
end

-- 官方块对外为 HSV：hue 0..360，saturation/brightness 0..100（内部转 0..1）。
-- alpha 是“透明度”：0=不透明，100=全透明 → brush alpha = (100-val)/100。

function M.self_set_pen_color_property(self, args)
  local scope = tostring(args.scope or args.property or "alpha")
  local val = V.num(args.val or args.value)
  if scope == "hue" then
    self.pen.hsv = self.pen.hsv or self.pen.hsl or { 0, 0, 0 }
    self.pen.hsv[1] = val % 360
    pen_sync_color(self.pen)
  elseif scope == "saturation" or scope == "brightness" then
    self.pen.hsv = self.pen.hsv or self.pen.hsl or { 0, 0, 0 }
    local h, s, v = self.pen.hsv[1], self.pen.hsv[2], self.pen.hsv[3]
    if scope == "saturation" then s = clamp01(val / 100) else v = clamp01(val / 100) end
    self.pen.hsv = { h, s, v }
    pen_sync_color(self.pen)
  elseif scope == "alpha" then
    self.pen.alpha = clamp01((100 - val) / 100)
  else
    M.self_set_pen_color(self, args)
  end
end

function M.self_change_pen_color_property(self, args)
  local scope = tostring(args.scope or args.property or "alpha")
  local y = delta_of(args, "steps", "val")
  if scope == "hue" then
    self.pen.hsv = self.pen.hsv or self.pen.hsl or { 0, 0, 0 }
    self.pen.hsv[1] = ((self.pen.hsv[1] + y) % 360 + 360) % 360
    pen_sync_color(self.pen)
  elseif scope == "saturation" or scope == "brightness" then
    self.pen.hsv = self.pen.hsv or self.pen.hsl or { 0, 0, 0 }
    local h, s, v = self.pen.hsv[1], self.pen.hsv[2], self.pen.hsv[3]
    if scope == "saturation" then s = clamp01(s + y / 100) else v = clamp01(v + y / 100) end
    self.pen.hsv = { h, s, v }
    pen_sync_color(self.pen)
  elseif scope == "alpha" then
    self.pen.alpha = clamp01((self.pen.alpha or 1) - y / 100)
  end
end
-- 注意：官方 `stamp` 是**文字印章**（(text,size,align)，见 rt/impl/ui.lua），
--       这里的图片图章是 `image_stamp`（callee 见官方枚举），别混淆。

function M.image_stamp(self, args, th)
  local g = th.sched.game
  if g.debug_nan and g.host and g.host.log then
    g.host:log(("  [image_stamp] 调用者=%s pos=(%.1f,%.1f) style=%s size=%sx%s 可见=%s")
      :format(tostring(self.name), self.x or 0, self.y or 0, tostring(self:style_id()):sub(1, 8),
        tostring(self.img_w), tostring(self.img_h), tostring(self.visible)))
  end
  if g.host and g.host.pen_stamp then g.host:pen_stamp(self, g) end
end

-- 调整角色图层：官方 setTopBottomLayer（main:1 byte 1609440+）
-- 场景 actor 列表为自下而上；layer index 0=bottom，#list=top。

function M.set_pen_layer(self, args, th)
  local g = th.sched.game
  if g.host and g.host.pen_layer_move then
    g.host:pen_layer_move(tostring(args.layer or args.value or ""), tostring(args.target_layer or ""), g)
  end
end

return M
