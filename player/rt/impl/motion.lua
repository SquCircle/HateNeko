-- 运动（坐标/朝向/滑行/反弹/拖动）（来自 motion_looks.lua）


local V = require("rt.values")
local C = require("rt.impl.common")
local M = {}

local finite, delta_of, glide, pen_move_tick = C.finite, C.delta_of, C.glide, C.pen_move_tick


local function forward(self, steps)
  -- 官方 moveTargetTo 一类运动原语会校验 NaN/Infinity（player.main:2236402）：
  -- 非有限步数/朝向不得写入，否则实体坐标会变成 NaN（绘制直接消失，且之后每帧都画不出来）。
  if not finite(steps) or not finite(self.dir) then return end
  local rad = math.rad(self.dir)
  self.x = self.x + steps * math.cos(rad)
  self.y = self.y + steps * math.sin(rad)
end

-- 渐变助手：在 ms 毫秒内把 setter(p) 从 p=0 推到 p=1，每帧让出

function M.self_go_forward(self, args)
  forward(self, V.num(args.steps))
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

function M.self_set_position(self, args, th)
  local coord = tostring(args.coordinate or args.scope or "x")
  local v = V.num(args.value or args.x or args.y)
  if not finite(v) then return end
  if coord == "y" or coord == "Y" then self.y = v else self.x = v end
  pen_move_tick(self, th)
end

function M.self_change_coordinate_x(self, args, th)
  local d = delta_of(args, "value", "x")
  if finite(d) then self.x = self.x + d end   -- NaN 偏移不写入（同 move_to/set_position）
  pen_move_tick(self, th)
end

function M.self_change_coordinate_y(self, args, th)
  local d = delta_of(args, "value", "y")
  if finite(d) then self.y = self.y + d end
  pen_move_tick(self, th)
end

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
  local d = V.num(args.degrees)
  -- 鼠标坐标在触屏抬起后是 NaN（官方移动端 setMousePosition({NaN,NaN})）：
  -- NaN 朝向必须**保留原朝向**，不能写进 self.dir —— 否则下面 go_forward 会把坐标算成 NaN，
  -- 那一笔白色点就画不出来（atkn 介绍3 的初始那一帧正是这种情况）。
  if not finite(d) then return end
  self.dir = d
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

return M
