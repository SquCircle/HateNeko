-- 外观（造型/大小/显示/特效/层序）（来自 motion_looks.lua）


local V = require("rt.values")
local C = require("rt.impl.common")
local M = {}

-- 常量/单位来自 common；旧 ABI 的 M.MAX_SCALE_PCT / M.round_to 仍可用
M.MAX_SCALE_PCT, M.MAX_STAMP_PX, M.ROUNDING = C.MAX_SCALE_PCT, C.MAX_STAMP_PX, C.ROUNDING
M.round_to, M.clamp_scale = C.round_to, C.clamp_scale
local delta_of, glide = C.delta_of, C.glide


function M.self_set_rotation_type(self, args)
  local raw = args.rotation_type
  if raw == nil then raw = args.type end
  if raw == nil then raw = args.value end
  local n = tonumber(raw)
  local t = tostring(raw or "all"):lower()
  if n ~= nil and n >= 0 and n <= 2 then
    self.rotation_type = n
  elseif t == "left_right" or t == "left-right" then self.rotation_type = 1
  elseif t == "dont" or t == "none" then self.rotation_type = 2
  else self.rotation_type = 0 end
  -- rotation_style 是旧字段（编译产物/旧测试）；与 rotation_type 保持同一份状态
  self.rotation_style = (self.rotation_type == 1) and "left_right"
    or (self.rotation_type == 2) and "none" or "all"
end

-- 供宿主使用：按旋转方式算出"实际绘制用的朝向/翻转"

function M.draw_rotation(e)
  local t = e.rotation_type
  if t == nil then t = e.rotation_style or 0 end
  if type(t) == "string" then
    local s = t:lower()
    if s == "left_right" or s == "left-right" then t = 1
    elseif s == "dont" or s == "none" then t = 2
    else t = 0 end
  end
  local d = e.dir or 0
  if t == 1 then
    local n = ((d % 360) + 360) % 360
    -- 官方：rotation >= π/2 或 < -π/2 时横向镜像；用 [0,360) 表示即
    -- n ∈ [90, 270)。90 含、270 不含（-270° 归一化成 90°，要 flip）。
    local flip = (n >= 90 and n < 270)
    return 0, flip
  elseif t == 2 then
    return 0, false
  end
  return d, false
end

function M.get_styles(self, args)
  -- getStyles 是造型下拉表达式：返回它所携带的 style_id。
  return args.style_id or args.value
end

function M.set_sprite_style(self, args, th)
  local id = args.style_id
  if self:set_style_by_id(id) then return end
  -- 官方 setSpriteStyle（player.main:2138862 段）：数字造型号取 `h[Math.round(s)-1]`，
  -- 超出范围 → addError(NO_ID) 且**不改**当前造型；不能把 2.4 直接写进 style_index
  -- （styles[2.4] = nil → 角色画不出来）。
  local n = tonumber(id)
  if n == nil or n ~= n then return end
  n = V.js_round(n)
  if n >= 1 and n <= #self.styles then self.style_index = n end
end

M.self_set_style = M.set_sprite_style

function M.self_prev_next_style(self, args)
  local n = #self.styles
  if n == 0 then return end
  local dir = (args.prev_next == "prev") and -1 or 1
  self.style_index = ((self.style_index - 1 + dir) % n) + 1
end

M.self_switch_style = M.self_prev_next_style

function M.self_appear(self, args)
  -- 官方 selfAppear（main:1 byte 1606486）：只有 "appear" 显示，其他值隐藏。
  self.visible = (tostring(args.value) == "appear")
end

M.self_set_visibility = M.self_appear

function M.self_gradually_show_hide(self, args, th)
  local ms = V.num(args.time) * 1000
  -- 作品的取值是 show / hide（旧实现只认 disappear → "隐藏"被当成"显示"）
  local v = tostring(args.show_hide or args.value or "show"):lower()
  local hide = (v == "hide" or v == "disappear" or v == "0" or v == "隐藏")
  local target = hide and 0 or 100
  -- 从当前 alpha 起算；避免渐隐前先跳回 100。
  local from = self.alpha
  if from == nil then from = self.visible and 100 or 0 end
  if target == 100 then self.visible = true end
  glide(th, ms, function(p)
    local a = from + (target - from) * p
    self.alpha = a
    if target == 0 and p >= 1 then self.visible = false end
  end)
  self.alpha = target
end

M.self_fade = M.self_gradually_show_hide

-- 「设置角色大小」= 同时设置两轴（唯一的存储就是 scale_x/scale_y，1.0 = 原尺寸）

function M.apply_scale(self, pct)
  if pct ~= pct then return end
  -- 官方 setScale：clamp(scale, 1, 9999)。
  pct = math.max(1, math.min(M.MAX_SCALE_PCT, pct))
  local k = pct / 100
  self.scale_x, self.scale_y = k, k
end

function M.set_scale(self, args)
  M.apply_scale(self, V.num(args.scale or args.value))
end

M.self_set_scale = M.set_scale

function M.self_change_scale(self, args)
  -- 官方 selfChangeScale：x/y 各自加带符号值，保持宽高独立。
  local v = V.num(args.value or args.scale)
  if v ~= v then return end
  if tostring(args.increase or "increase") == "decrease" then v = -v end
  local function one(cur)
    return math.max(1, math.min(M.MAX_SCALE_PCT, (cur or 1) * 100 + v)) / 100
  end
  self.scale_x, self.scale_y = one(self.scale_x), one(self.scale_y)
end

-- 特效下拉（当前 UI）：0 颜色 1 透明 2 亮度 3 像素化 4 波纹 5 扭曲 6 黑白

local EFFECT_MAP = {
  ["0"] = "color",
  ["1"] = "opacity",
  ["2"] = "brightness",
  ["3"] = "pixelate",
  ["4"] = "ripple",
  ["5"] = "distortion",
  ["6"] = "grayscale",
}

local function effect_key(args)
  return EFFECT_MAP[tostring(args.scope or args.attribute or "0")] or "color"
end

local function clamp_effect(key, v)
  if key == "color" then return ((v % 360) + 360) % 360 end
  if key == "opacity" or key == "grayscale" or key == "ripple" or key == "distortion" then
    return math.max(0, math.min(100, v))
  end
  if key == "brightness" then return math.max(0, math.min(200, v)) end
  if key == "pixelate" then return math.max(1, v) end
  return v
end

function M.self_set_effect(self, args)
  local k = effect_key(args)
  local v = V.num(args.value)
  if v ~= v then return end -- 官方：非数值输入 → addError 并忽略执行
  -- 官方「透明」不落在特效槽：effect 应用函数里 ALPHA 走
  -- `alpha = (100 - value)/100`（player.main:2239194 的 s 函数），
  -- 所以这里写角色 alpha；写 effects.opacity 会与渲染的 alpha 相乘、变成双重透明。
  if k == "opacity" then
    self.alpha = math.max(0, math.min(100, 100 - v))
    return
  end
  self.effects[k] = clamp_effect(k, v)
end

M.self_set_effect_value = M.self_set_effect

function M.self_change_effect(self, args)
  local k = effect_key(args)
  local d = delta_of(args, "value", "steps")
  if k == "opacity" then
    -- 官方 change alpha：`alpha = clamp(alpha - signed_value/100, 0, 1)`
    self.alpha = math.max(0, math.min(100, (self.alpha or 100) - d))
    return
  end
  self.effects[k] = clamp_effect(k, (self.effects[k] or 0) + d)
end

function M.clear_all_effects(self, args)
  for k in pairs(self.effects or {}) do self.effects[k] = 0 end
end

M.self_clear_all_effects = M.clear_all_effects

-- 设置角色宽高：**像素**（覆盖造型原始尺寸；两轴独立 → 旋转后沿角色局部轴拉伸）
-- 「设置宽高缩放」：官方模型里角色只有一个 PIXI scale（x/y 两轴），
-- 这块只改其中一轴，值是百分比（100 = 原尺寸）。几何与图像印章都要认它。

function M.set_width_height_scale(self, args)
  -- 【单位 = 百分比】100 = 原尺寸（用户确认的坐标系/单位说明）
  local t = tostring(args.type or "width")
  local is_h = (t == "height" or t == "2" or t == "高")
  local pct = V.num(args.value)
  if pct ~= pct then return end
  pct = math.max(1, math.min(M.MAX_SCALE_PCT, pct))
  local mult = pct / 100
  if is_h then self.scale_y = mult else self.scale_x = mult end
end

function M.add_width_height_scale(self, args)
  local t = tostring(args.type or "width")
  local is_h = (t == "height" or t == "2" or t == "高")
  local delta = M.round_to(delta_of(args, "value", "steps") / 100, 4)
  local function one(cur)
    return math.max(0.01, math.min(99.99, (cur or 1) + delta))
  end
  if is_h then self.scale_y = one(self.scale_y) else self.scale_x = one(self.scale_x) end
end


---------------------------------------------------------------- pen

local function layer_cmp(a, b)
  local la, lb = a.layer or 0, b.layer or 0
  if la ~= lb then return la < lb end
  local oa, ob = a.order or 0, b.order or 0
  if oa ~= ob then return oa < ob end
  return (a.seq or 0) < (b.seq or 0)
end

local function scene_actor_list(g)
  local list = {}
  local scene = require("rt.scene")
  for _, e in ipairs(g.entities) do
    if e.kind == "actor" and not e.deleted and scene.in_scene(e, g) then
      list[#list + 1] = e
    end
  end
  table.sort(list, layer_cmp)
  return list
end

local function index_of(list, target)
  for i, e in ipairs(list) do if e == target then return i - 1 end end
  return nil
end

local function set_z_index(list, target, index)
  index = math.max(0, math.min(index or 0, #list))
  for i = #list, 1, -1 do
    if list[i] == target then table.remove(list, i) break end
  end
  table.insert(list, math.min(index + 1, #list + 1), target)
  for i, e in ipairs(list) do e.layer = i end
end

function M.set_top_bottom_layer(self, args, th)
  local g = th and th.sched and th.sched.game
  if not g then return end
  local layer = tostring(args.layer or args.value or "peak")
  local list = scene_actor_list(g)
  local v = index_of(list, self)
  if v == nil then return end

  local host = g.host
  local brush_self = host and host.pen_brush_target and
    (host:pen_brush_target() == self.id or host:pen_brush_target() == self.name)
  local brush_empty = host and host.pen_brush_empty and host:pen_brush_empty()
  local function brush_set(t) if host and host.set_pen_brush_target then host:set_pen_brush_target(t) end end
  local function brush_unset() if host and host.unset_pen_brush_target then host:unset_pen_brush_target() end end

  local target = nil
  local target_id = args.target_layer or args.sprite
  if target_id ~= nil and target_id ~= "" and target_id ~= "--self" then
    target = g:find(target_id)
  elseif target_id == "--self" then
    target = self
  end

  local below, above = list[v], list[v + 2]
  if target and target ~= self then
    local d = index_of(list, target)
    if d ~= nil then
      if layer == "prev_layer" then
        set_z_index(list, self, (v > d) and (d + 1) or d)
        if brush_self then
          if v > d then
            if v ~= d + 1 then brush_set(below) end
          else
            if below then brush_set(below) else brush_unset() end
          end
        elseif host and host.pen_brush_target and
          (host:pen_brush_target() == target.id or host:pen_brush_target() == target.name) then
          brush_set(self)
        end
      elseif layer == "next_layer" then
        set_z_index(list, self, (v > d) and d or (d - 1))
        if brush_self then
          if below then brush_set(below) else brush_unset() end
        end
      end
      return
    end
  end

  if layer == "peak" then
    set_z_index(list, self, #list)
    if brush_self then
      if below then brush_set(below) else brush_unset() end
    end
  elseif layer == "bottom" then
    set_z_index(list, self, 0)
    if brush_self then
      if below then brush_set(below) else brush_unset() end
    elseif host and host.pen_brush_target and not host:pen_brush_target() then
      brush_set(self)
    end
  elseif layer == "prev_layer" then
    if brush_self then
      if above then
        if brush_empty then set_z_index(list, self, v + 1) end
      end
    elseif above then
      local bid = host and host.pen_brush_target and host:pen_brush_target()
      if bid == above.id or bid == above.name then
        set_z_index(list, self, v + 1)
        brush_set(self)
      else
        set_z_index(list, self, v + 1)
      end
    end
  elseif layer == "next_layer" then
    if below then
      if brush_self then
        set_z_index(list, self, v - 1)
        brush_set(below)
      else
        local bid = host and host.pen_brush_target and host:pen_brush_target()
        if bid ~= below.id and bid ~= below.name or brush_empty then
          set_z_index(list, self, v - 1)
        else
          brush_set(self)
        end
      end
    elseif host and host.pen_brush_target and not host:pen_brush_target() then
      brush_set(self)
    end
  end
end

M.set_layer = M.set_top_bottom_layer

-- 移动画笔图层：layer = peak/bottom/prev_layer/next_layer/角色…（官方 set_pen_layer）

return M
