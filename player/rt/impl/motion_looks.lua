-- 运动 / 外观 / 画笔 原语
-- 统一签名：function(self, args, th)
local V = require("rt.values")

local M = {}

-- 官方限制：角色缩放上限 9999%（百分比）；图像印章以像素计，上限 8192px
-- （146px 宽的角色最大印章缩放 5612% ≈ 146*56.12 = 8193.5px，与 8192 吻合）
M.MAX_SCALE_PCT = 9999
M.MAX_STAMP_PX  = 8192
local function clamp_scale(v)
  v = V.num(v)
  if v ~= v then return 100 end          -- NaN 保护
  return math.max(-M.MAX_SCALE_PCT, math.min(M.MAX_SCALE_PCT, v))
end
M.clamp_scale = clamp_scale
-- 官方涉及舍入的块目前保持官方四舍五入；未来需要“不舍入”时统一改这里。
M.ROUNDING = true
function M.round_to(v, n)
  if not M.ROUNDING then return v end
  local p = 10 ^ (n or 0)
  return math.floor(v * p + 0.5) / p
end

local function forward(self, steps)
  local rad = math.rad(self.dir)
  self.x = self.x + steps * math.cos(rad)
  self.y = self.y + steps * math.sin(rad)
end

-- 渐变助手：在 ms 毫秒内把 setter(p) 从 p=0 推到 p=1，每帧让出
local function glide(th, ms, setter)
  if ms <= 0 then setter(1) return end
  local start = require("rt.core").now_ms()
  while true do
    local p = (require("rt.core").now_ms() - start) / ms
    if p >= 1 then setter(1) break end
    setter(p)
    coroutine.yield()
  end
end

---------------------------------------------------------------- motion
function M.self_go_forward(self, args)
  forward(self, V.num(args.steps))
end

local function finite(v)
  return type(v) == "number" and v == v and v ~= math.huge and v ~= -math.huge
end

-- 画笔颜色：官方块对外是 HSV（hue/saturation/brightness）；brush 内部保存 HSL。
-- 这里做 hex <-> HSL，以及 g.kO/g.Iv 等价的 HSL <-> HSV。
local function clamp01(v) return math.max(0, math.min(1, v)) end

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
local function pen_move_tick(self, th)
  local g = th and th.sched and th.sched.game
  if g and g.host and g.host.pen_tick then g.host:pen_tick(self, g) end
end

function M.self_move_to(self, args, th)
  -- 官方 moveTargetTo（main.15ba0757.js:1 byte 1749237/1750330）：
  -- 非 number 或非有限坐标不写入，保留当前值；get_mouse_info 的 NaN 不得污染实体。
  local x, y = V.num(args.x), V.num(args.y)
  if finite(x) then self.x = x end
  if finite(y) then self.y = y end
  pen_move_tick(self, th)
end


-- 官方 selfMoveSpecify（main.15ba0757.js:1 byte 1598302）：
-- --mouse 取当前指针；--random 取舞台随机点；默认目标角色；--self 不动。
function M.self_move_specify(self, args, th)
  local g = th.sched.game
  local sv = tostring(args.sprite or "")
  if sv == "--mouse" then
    -- 官方「移到鼠标」是持续跟随指针；不能只在按下时更新，否则手指角色会停在
    -- 上一次点击位置，所有用 coordinate_of_sprite(手指) 布局的 UI 都会偏移。
    local x, y = g:pointer_world()
    -- 官方 selfMoveSpecify @1598287 只写位置，没有“从命中里排除自己”的副作用。
    if finite(x) then self.x = x end
    if finite(y) then self.y = y end
  elseif sv == "--random" then
    local x = math.random() * g.stage_w - g.stage_w / 2
    local y = math.random() * g.stage_h - g.stage_h / 2
    if finite(x) then self.x = x end
    if finite(y) then self.y = y end
  elseif sv == "" or sv == "--self" then
    return
  else
    local target = g:find(sv)
    if target then
      if finite(target.x) then self.x = target.x end
      if finite(target.y) then self.y = target.y end
    end
  end
  pen_move_tick(self, th)
end

function M.self_move_specify_sprite(self, args, th)
  -- 官方 selfMoveSpecifySprite 就是 selfMoveSpecify 的别名（main:1 byte 1599140）
  return M.self_move_specify(self, args, th)
end
M.self_move_to_sprite = M.self_move_specify_sprite

function M.self_set_position_x(self, args, th)
  -- 官方 selfSetPositionX 走 moveTargetTo：非有限值不写（byte 1749237/1750330）。
  local v = V.num(args.value or args.x)
  if finite(v) then self.x = v end
  pen_move_tick(self, th)
end
function M.self_set_position_y(self, args, th)
  local v = V.num(args.value or args.y)
  if finite(v) then self.y = v end
  pen_move_tick(self, th)
end
-- 「增加/减少」下拉的统一解析（官方：increase 默认；decrease 取负）。
-- 之前 change_coordinate_x/y、change_pen_size、glide_coordinate 都只看 value、无视下拉，
-- 于是作品里"减少 y"变成"增加 y"——now 的雪花因此往天上飞、永远落不到底。
local function delta_of(args, k1, k2)
  local v = V.num(args[k1] or args[k2])
  -- 官方 changeTargetPosition 对 !isFinite(n) 或 n==0 直接忽略（byte 1750630）。
  if not finite(v) then return 0 end
  local mode = tostring(args.increase or args.method or "increase"):lower()
  if mode == "decrease" or mode == "minus" or mode == "-1" or mode == "减少" then v = -v end
  return v
end

function M.self_set_position(self, args, th)
  local coord = tostring(args.coordinate or args.scope or "x")
  local v = V.num(args.value or args.x or args.y)
  if not finite(v) then return end
  if coord == "y" or coord == "Y" then self.y = v else self.x = v end
  pen_move_tick(self, th)
end

function M.self_change_coordinate_x(self, args, th) self.x = self.x + delta_of(args, "value", "x"); pen_move_tick(self, th) end
function M.self_change_coordinate_y(self, args, th) self.y = self.y + delta_of(args, "value", "y"); pen_move_tick(self, th) end
function M.self_change_coordinate(self, args, th)
  local coord = tostring(args.coordinate or args.scope or "x")
  if coord == "y" or coord == "Y" then return M.self_change_coordinate_y(self, args, th) end
  return M.self_change_coordinate_x(self, args, th)
end
M.self_set_position_value = M.self_set_position

function M.self_glide_to(self, args, th)
  local x0, y0 = self.x, self.y
  local x1, y1 = V.num(args.x), V.num(args.y)
  glide(th, V.num(args.time) * 1000, function(p)
    self.x = x0 + (x1 - x0) * p
    self.y = y0 + (y1 - y0) * p
    pen_move_tick(self, th)
  end)
end

-- 「逐渐改变x/y坐标」：目标 = 当前位置 ± value（value 是**增量**，不是绝对坐标），按时长插值。
function M.self_glide_coordinate_x(self, args, th)
  local x0 = self.x
  local x1 = x0 + delta_of(args, "value", "x")
  glide(th, V.num(args.time) * 1000, function(p) self.x = x0 + (x1 - x0) * p; pen_move_tick(self, th) end)
end

function M.self_glide_coordinate_y(self, args, th)
  local y0 = self.y
  local y1 = y0 + delta_of(args, "value", "y")
  glide(th, V.num(args.time) * 1000, function(p) self.y = y0 + (y1 - y0) * p; pen_move_tick(self, th) end)
end
function M.self_glide_coordinate(self, args, th)
  local coord = tostring(args.coordinate or args.scope or "x")
  if coord == "y" or coord == "Y" then return M.self_glide_coordinate_y(self, args, th) end
  return M.self_glide_coordinate_x(self, args, th)
end

function M.self_rotate(self, args)
  self.dir = self.dir + V.num(args.degrees or args.value)
end

function M.self_point_towards(self, args)
  self.dir = V.num(args.degrees)
end

function M.face_point(self, tx, ty)
  if finite(tx) and finite(ty) then
    self.dir = math.deg(math.atan2(ty - self.y, tx - self.x))
  end
end

function M.self_face_to(self, args, th)
  local g = th and th.sched and th.sched.game
  local sprite = args.sprite
  if sprite == nil and args.degrees ~= nil then
    self.dir = V.num(args.degrees)
    return
  end
  if not g then return end
  if sprite == "--mouse" then
    local x, y = g:pointer_world()
    M.face_point(self, x, y)
  elseif sprite == "--random" then
    M.face_point(self, math.random() * g.stage_w - g.stage_w / 2,
      math.random() * g.stage_h - g.stage_h / 2)
  else
    local target = g:find(sprite)
    if target then M.face_point(self, target.x, target.y) end
  end
end

function M.self_face_to_sprite(self, args, th)
  return M.self_face_to(self, args, th)
end
M.self_point_towards_target = M.self_face_to_sprite

function M.self_set_draggable(self, args)
  self.draggable = V.bool(args.draggable or args.value)
end

function M.self_bounce_off_edge(self, args, th)
  -- 官方 bounce_if_collision_with_edge（crc_libs:1 byte 1171190）：
  -- 用每个 alpha 像素的实际世界坐标判边；先推回舞台，再应用反射后的朝向。
  local g = th and th.sched and th.sched.game
  if not g then return end
  local Hit = require("rt.hit")
  local L, R = -g.stage_w / 2, g.stage_w / 2
  local B, T = -g.stage_h / 2, g.stage_h / 2
  -- AABB 粗筛：没碰到边就不必生成/遍历 internal points。
  local bx1, by1, bx2, by2 = Hit.aabb(self, g)
  if not bx1 then return end
  if bx2 <= R and bx1 >= L and by2 <= T and by1 >= B then return end
  local x1, y1, x2, y2 = Hit.internal_vertices(self, g)
  if not x1 then return end
  local rad = math.rad(self.dir or 0)
  local c, sn = math.cos(rad), math.sin(rad)
  -- 任一 alpha 像素中心越界即触发（不再用 step=2 internal points / bbox 代替）。
  local hit_right = x2 > R
  local hit_left = x1 < L
  local hit_top = y2 > T
  local hit_bottom = y1 < B
  if not (hit_right or hit_left or hit_top or hit_bottom) then return end
  local new_dir = self.dir or 0
  if hit_right or hit_left then new_dir = 180 - new_dir end
  if hit_top or hit_bottom then new_dir = -new_dir end
  -- 用反射后的角度重新计算像素边界，再推回舞台；最后才写 new_dir。
  local old_dir = self.dir
  self.dir = new_dir
  local ax1, ay1, ax2, ay2 = Hit.internal_vertices(self, g)
  self.dir = old_dir
  if not ax1 then return end
  local pad = 10
  -- 官方：h = a-(max_x+10), h = -a-(min_x-10), 等价于把越界像素推到边界内 10px。
  if hit_right then self.x = self.x - (ax2 - (R - pad)) end
  if hit_left then self.x = self.x + ((L + pad) - ax1) end
  if hit_top then self.y = self.y - (ay2 - (T - pad)) end
  if hit_bottom then self.y = self.y + ((B + pad) - ay1) end
  -- 位置已推回，最后旋转。
  self.dir = new_dir % 360
  self.edge_bounce = true
end

function M.self_set_role_camp(self, args)
  local c = tostring(args.role_camp or "")
  -- 官方 selfSetRoleCamp（main:1 byte 1604149）：no_camp -> clear_group()
  if c == "" or c == "no_camp" then self.camp = nil else self.camp = c end
end
M.self_set_camp = M.self_set_role_camp

-- 旋转方式（官方 rotation_type：ALL 自由 / LEFT_RIGHT 左右翻转 / DONT 不旋转）
-- 源码：set_scale 里 is_horizontal_flipped 会把 scale.x 取负；
--       左右翻转模式下，角色朝向落在左半区时横向镜像、且绘制时不旋转。
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

function M.self_rotate_around(self, args, th)
  -- 官方 selfRotateAround（main:1 byte 1601659）：绕 sprite 的 actor.position 旋转。
  local g = th and th.sched and th.sched.game
  local sprite = args.sprite
  local target
  if sprite == nil or sprite == "" or sprite == "--self" then
    target = self
  elseif g then
    target = g:find(sprite)
  end
  if not target then return end
  local cx, cy = V.num(args.x or target.x), V.num(args.y or target.y)
  if not finite(cx) or not finite(cy) then return end
  local deg = V.num(args.degrees or args.value)
  local rad = math.rad(deg)
  local dx, dy = (self.x or 0) - cx, (self.y or 0) - cy
  local cs, sn = math.cos(rad), math.sin(rad)
  self.x = cx + dx * cs - dy * sn
  self.y = cy + dx * sn + dy * cs
  self.dir = (self.dir or 90) + deg
end
function M.self_reset(self, args)
  -- 官方「重置」：位置回 (0,0)、朝向 90、大小 100、宽高缩放复位、特效清零
  self.x, self.y = 0, 0
  self.dir = 90
  self.scale_x, self.scale_y = 1, 1
  self.effects = {}
  if self.pen then self.pen.last_x, self.pen.last_y = nil, nil end
end

---------------------------------------------------------------- looks
function M.get_styles(self, args)
  -- getStyles 是造型下拉表达式：返回它所携带的 style_id。
  return args.style_id or args.value
end

function M.set_sprite_style(self, args, th)
  local id = args.style_id
  if self:set_style_by_id(id) then return end
  local n = tonumber(id)
  if n and n >= 1 and n <= #self.styles then self.style_index = n end
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
  self.effects[k] = clamp_effect(k, V.num(args.value))
end
M.self_set_effect_value = M.self_set_effect

function M.self_change_effect(self, args)
  local k = effect_key(args)
  self.effects[k] = clamp_effect(k, (self.effects[k] or 0) + delta_of(args, "value", "steps"))
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
function M.set_pen_layer(self, args, th)
  local g = th.sched.game
  if g.host and g.host.pen_layer_move then
    g.host:pen_layer_move(tostring(args.layer or args.value or ""), tostring(args.target_layer or ""), g)
  end
end

return M
