-- 几何/命中层：**严格对齐官方源码**（official/player_main.63b4a46c.js）
--
-- 官方事实（逐字摘自播放器 bundle）：
--  ① 每个显示对象 interactive = true；stage/interactive+全屏 hitArea；scene_container.interactive = true
--  ② hitArea = is_touching(...)；PIXI recursiveFindHit 自上而下、visible=false 直接 false
--  ③ is_touching(点)：把点**反旋转、反缩放**映射到纹理像素坐标，查该像素 alpha>0
--        t.prototype.is_touching = function(e){
--          var r = 变换(e, this),                  // 见下 coord_in_texture()
--              tex = this.data.get_texture_points_color_data(style),
--              W = this.texture.width, H = this.texture.height;
--          return !(r.x>W||r.y>H||r.x<0||r.y<0) && tex[r.y*W+r.x]>>>24 > 0 }
--        变换 = rotAround(p, 中心, -rotation) 后：
--          i = scale.x>0 ? r.x-n.x+width/2 : r.x-n.x-width/2
--          a = scale.y>0 ? r.y-n.y+height/2 : r.y-n.y-height/2
--          return round(i/scale.x), round(a/scale.y)
--        ★ 这里的 width/height 是 PIXI `Sprite.width/height` = **|scale| × texture**（显示尺寸），
--          不是纹理原始尺寸。用错会让 scale≠1 的命中全部偏移/越界（见下方 coord_in_texture）。
--  ④ check_bumped_other：都要 visible、都不能 has_left_stage、**必须同一 scene**、
--        先包围盒粗筛，再在重叠区**每 2 像素**采样双方 is_touching，命中数达到
--        min_points_for_collision(=5) 即算碰到
--  ⑤ has_left_stage：getBounds() 的四条边都 <= 0
--  ⑥ get_bounds_in_stage：顶点包围盒各向外扩 5 像素，clamp 到舞台后取整
local Values = require("rt.values")

local M = {}

local function sid_of(e)
  local f = e and e.style_id
  if type(f) == "function" then return f(e) end
  return f or (e and e.id)
end

M.MIN_POINTS_FOR_COLLISION = 5 -- 官方常量

-- 造型 alpha 取样：{ w, h, rgba = <RGBA8 原始字节串> } 或旧格式 { alpha = <每像素 1 字节> }
-- 新格式不复制/重建 alpha 串，命中热路径只按偏移取第 4 个字节（内存/首帧开销都减半）。
function M.alpha_at(px, i)
  if not px then return 0 end
  if px.alpha then return px.alpha:byte(i) or 0 end
  local rgba = px.rgba
  if not rgba then return 0 end
  return rgba:byte((i - 1) * 4 + 4) or 0
end

---------------------------------------------------------------- 基础几何
-- 官方 get_vertices()：把一组顶点变换到舞台（本地有无旋转都按朝向走）
function M.aabb(e, game)
  local sid = sid_of(e)
  if e._aabb and e._aabb_sid == sid and e._aabb_x == e.x and e._aabb_y == e.y
     and e._aabb_dir == e.dir and e._aabb_sx == e.scale_x and e._aabb_sy == e.scale_y
     and e._aabb_fx == e.flip_x and e._aabb_fy == e.flip_y
     and e._aabb_iw == e.img_w and e._aabb_ih == e.img_h then
    local v = e._aabb
    return v[1], v[2], v[3], v[4]
  end
  local w, h, sc = M.actor_size(e, game)
  if not w then return nil end
  local rad = math.rad(e.dir or 0)
  local c, s = math.cos(rad), math.sin(rad)
  local hw, hh = w / 2, h / 2
  local x1, y1 = math.huge, math.huge
  local x2, y2 = -math.huge, -math.huge
  for _, p in ipairs({ { -hw, -hh }, { hw, -hh }, { hw, hh }, { -hw, hh } }) do
    local px = e.x + p[1] * c - p[2] * s
    local py = e.y + p[1] * s + p[2] * c
    x1, y1 = math.min(x1, px), math.min(y1, py)
    x2, y2 = math.max(x2, px), math.max(y2, py)
  end
  e._aabb = { x1, y1, x2, y2 }
  e._aabb_sid, e._aabb_x, e._aabb_y, e._aabb_dir = sid, e.x, e.y, e.dir
  e._aabb_sx, e._aabb_sy, e._aabb_fx, e._aabb_fy = e.scale_x, e.scale_y, e.flip_x, e.flip_y
  e._aabb_iw, e._aabb_ih = e.img_w, e.img_h
  return x1, y1, x2, y2
end

function M.actor_size(e, game)
  -- 官方几何基于加载后的 texture.width/height；我们让宿主按造型给出尺寸（love 用真图，无头读文件头）
  if (e.img_w == nil or e.img_h == nil) and game and game.host and game.host.style_size then
    local w0, h0 = game.host:style_size(sid_of(e), game)
    if w0 and h0 then e.img_w, e.img_h = w0, h0 end
  end
  local w, h = e.img_w, e.img_h
  if not w or not h then return nil end
  -- 官方：包围盒 = texture.width/height × scale.x/scale.y
  local sx = e.scale_x or 1
  local sy = e.scale_y or 1
  return w * math.abs(sx), h * math.abs(sy), sx
end


-- 像素级 alpha 包围盒（官方 get_texture_internal_points_vertices 的等价物）
function M.alpha_bounds(e, game)
  local w, h = M.actor_size(e, game)
  if not w or not h then return nil end
  local px = M.style_pixels(e, game)
  if not px then return nil end
  local cache
  if game.host then
    game.host._alpha_bounds_cache = game.host._alpha_bounds_cache or {}
    cache = game.host._alpha_bounds_cache
  end
  local key = tostring(sid_of(e)) .. ":" .. tostring(px.w) .. "x" .. tostring(px.h)
  if cache and cache[key] then return cache[key][1], cache[key][2], cache[key][3], cache[key][4] end
  local minx, miny, maxx, maxy = px.w, px.h, -1, -1
  for v = 0, px.h - 1 do
    local row = v * px.w
    for u = 0, px.w - 1 do
      if M.alpha_at(px, row + u + 1) > 0 then
        if u < minx then minx = u end
        if u > maxx then maxx = u end
        if v < miny then miny = v end
        if v > maxy then maxy = v end
      end
    end
  end
  if maxx < 0 then return nil end
  if cache then cache[key] = { minx, miny, maxx, maxy } end
  return minx, miny, maxx, maxy
end



-- 官方 get_texture_internal_points（crc_libs:1 byte 1106893）：
-- step=2 网格；只有 (x-1,y-1),(x,y-1),(x-1,y),(x,y) 四邻 alpha>0 才取点。
function M.internal_points(e, game)
  local px = M.style_pixels(e, game)
  if not px then return nil end
  local host = game.host
  local cache
  if host then
    host._internal_points_cache = host._internal_points_cache or {}
    cache = host._internal_points_cache
  end
  local key = tostring(sid_of(e)) .. ":" .. tostring(px.w) .. "x" .. tostring(px.h)
  if cache and cache[key] then return cache[key] end
  local step = 2
  local w, h = px.w, px.h
  local function opaque(x, y)
    if x < 0 or y < 0 or x >= w or y >= h then return false end
    return M.alpha_at(px, y * w + x + 1) > 0
  end
  local points = {}
  local y = 0
  while y < h do
    local x = 0
    while x < w do
      if opaque(x - 1, y - 1) and opaque(x, y - 1)
         and opaque(x - 1, y) and opaque(x, y) then
        points[#points + 1] = { x, y }
      end
      x = x + step
    end
    y = y + step
  end
  if #points == 0 then return nil end
  if cache then cache[key] = points end
  return points
end

-- 把 internal points 预投影成 actor 局部坐标（只依赖造型/缩放/center），供凸包复用。
local function local_points(e, game, w, h, iw, ih, ox, oy, sx, sy)
  local points = M.internal_points(e, game)
  if not points then return nil end
  local host = game.host
  local cache
  if host then
    host._local_points_cache = host._local_points_cache or {}
    cache = host._local_points_cache
  end
  local key = table.concat({ tostring(sid_of(e)), tostring(w), tostring(h),
    tostring(iw), tostring(ih), tostring(ox), tostring(oy) }, "|")
  if cache and cache[key] then return cache[key] end
  local out = {}
  for i = 1, #points do
    local pt = points[i]
    out[i] = { (pt[1] + 0.5 - ox) * sx, (oy - (pt[2] + 0.5)) * sy }
  end
  if cache then cache[key] = out end
  return out
end

-- 单调链凸包：边缘碰撞只需要旋转后的 min/max，凸包点集与全点集等价。
local function convex_hull(points)
  local n = #points
  if n <= 3 then return points end
  local p = {}
  for i = 1, n do p[i] = points[i] end
  table.sort(p, function(a, b)
    if a[1] == b[1] then return a[2] < b[2] end
    return a[1] < b[1]
  end)
  local function cross(o, a, b)
    return (a[1] - o[1]) * (b[2] - o[2]) - (a[2] - o[2]) * (b[1] - o[1])
  end
  local lower = {}
  for i = 1, n do
    while #lower >= 2 and cross(lower[#lower - 1], lower[#lower], p[i]) <= 0 do
      lower[#lower] = nil
    end
    lower[#lower + 1] = p[i]
  end
  local upper = {}
  for i = n, 1, -1 do
    while #upper >= 2 and cross(upper[#upper - 1], upper[#upper], p[i]) <= 0 do
      upper[#upper] = nil
    end
    upper[#upper + 1] = p[i]
  end
  lower[#lower] = nil
  upper[#upper] = nil
  for i = 1, #upper do lower[#lower + 1] = upper[i] end
  return lower
end

local function hull_for(e, game, w, h, iw, ih, ox, oy, sx, sy)
  local pts = local_points(e, game, w, h, iw, ih, ox, oy, sx, sy)
  if not pts then return nil end
  local host = game.host
  local cache
  if host then
    host._hull_cache = host._hull_cache or {}
    cache = host._hull_cache
  end
  local key = table.concat({ tostring(sid_of(e)), tostring(w), tostring(h),
    tostring(iw), tostring(ih), tostring(ox), tostring(oy) }, "|")
  if cache and cache[key] then return cache[key] end
  local hull = convex_hull(pts)
  if cache then cache[key] = hull end
  return hull
end

-- 把 internal points 的凸包映射到舞台，返回顶点集合的世界包围（官方 get_vertices）。
function M.internal_vertices(e, game)
  local w, h = M.actor_size(e, game)
  if not w or not h then return nil end
  local iw, ih = e.img_w or w, e.img_h or h
  local asset = game.assets and game.assets[sid_of(e)]
  local cp = (asset and asset.center) or e.center_point
  local cx, cy = (cp and tonumber(cp.x) or 0), (cp and tonumber(cp.y) or 0)
  local ox, oy = iw / 2 + cx, ih / 2 + cy
  local sx, sy = w / iw, h / ih
  -- 数值状态比较，避免 table.concat 签名。
  local sid = sid_of(e)
  if e._iv and e._iv_sid == sid and e._iv_x == e.x and e._iv_y == e.y
     and e._iv_dir == e.dir and e._iv_sx == e.scale_x and e._iv_sy == e.scale_y
     and e._iv_fx == e.flip_x and e._iv_fy == e.flip_y
     and e._iv_cx == cx and e._iv_cy == cy then
    local v = e._iv
    return v[1], v[2], v[3], v[4]
  end
  local hull = hull_for(e, game, w, h, iw, ih, ox, oy, sx, sy)
  if not hull then return nil end
  local rad = math.rad(e.dir or 0)
  local c, s = math.cos(rad), math.sin(rad)
  local minx, miny, maxx, maxy = math.huge, math.huge, -math.huge, -math.huge
  for i = 1, #hull do
    local p = hull[i]
    local wx = e.x + p[1] * c - p[2] * s
    local wy = e.y + p[1] * s + p[2] * c
    if wx < minx then minx = wx end
    if wx > maxx then maxx = wx end
    if wy < miny then miny = wy end
    if wy > maxy then maxy = wy end
  end
  e._iv = { minx, miny, maxx, maxy }
  e._iv_sid, e._iv_x, e._iv_y, e._iv_dir = sid, e.x, e.y, e.dir
  e._iv_sx, e._iv_sy, e._iv_fx, e._iv_fy = e.scale_x, e.scale_y, e.flip_x, e.flip_y
  e._iv_cx, e._iv_cy = cx, cy
  return minx, miny, maxx, maxy
end
-- 贴图像素级世界边界：逐 alpha 像素映射到舞台，取实际最小/最大（不是纹理包围盒）。
function M.pixel_aabb(e, game)
  local w, h = M.actor_size(e, game)
  if not w or not h then return nil end
  local px = M.style_pixels(e, game)
  if not px then return nil end
  local iw, ih = e.img_w or w, e.img_h or h
  local sx, sy = w / iw, h / ih
  local asset = game.assets and game.assets[sid_of(e)]
  local cp = (asset and asset.center) or e.center_point
  local ox = iw / 2 + (cp and tonumber(cp.x) or 0)
  local oy = ih / 2 + (cp and tonumber(cp.y) or 0)
  local rad = math.rad(e.dir or 0)
  local c, s = math.cos(rad), math.sin(rad)
  local minx, miny, maxx, maxy = math.huge, math.huge, -math.huge, -math.huge
  local any = false
  for v = 0, px.h - 1 do
    local row = v * px.w
    local ly = (oy - (v + 0.5)) * sy
    for u = 0, px.w - 1 do
      if M.alpha_at(px, row + u + 1) > 0 then
        local lx = ((u + 0.5) - ox) * sx
        local wx = e.x + lx * c - ly * s
        local wy = e.y + lx * s + ly * c
        if wx < minx then minx = wx end
        if wx > maxx then maxx = wx end
        if wy < miny then miny = wy end
        if wy > maxy then maxy = wy end
        any = true
      end
    end
  end
  if not any then return nil end
  return minx, miny, maxx, maxy
end
-- 把 alpha 包围盒按 actor 的旋转/缩放映射到舞台（官方 internal points vertices）
function M.alpha_aabb(e, game)
  local w, h = M.actor_size(e, game)
  if not w or not h then return nil end
  local minx, miny, maxx, maxy = M.alpha_bounds(e, game)
  if not minx then return nil end
  local iw, ih = e.img_w or w, e.img_h or h
  local sx, sy = w / iw, h / ih
  local x1, y1, x2, y2 = minx * sx - w / 2, miny * sy - h / 2,
    (maxx + 1) * sx - w / 2, (maxy + 1) * sy - h / 2
  local rad = math.rad(e.dir or 0)
  local c, s = math.cos(rad), math.sin(rad)
  local ax, ay = math.huge, math.huge
  local bx, by = -math.huge, -math.huge
  for _, p in ipairs({ { x1, y1 }, { x2, y1 }, { x2, y2 }, { x1, y2 } }) do
    local px = e.x + p[1] * c - p[2] * s
    local py = e.y + p[1] * s + p[2] * c
    ax, ay = math.min(ax, px), math.min(ay, py)
    bx, by = math.max(bx, px), math.max(by, py)
  end
  return ax, ay, bx, by
end
-- 官方 has_left_stage()：整块都在舞台外
function M.has_left_stage(e, game)
  local x1, y1, x2, y2 = M.aabb(e, game)
  if not x1 then return false end
  local W, H = game.stage_w, game.stage_h
  local L, R = -W / 2, W / 2
  local B, T = -H / 2, H / 2
  return x2 <= L or x1 >= R or y2 <= B or y1 >= T
end

-- 官方 get_bounds_in_stage()：顶点包围盒外扩 5 像素，clamp 到舞台，取整
function M.bounds_in_stage(e, game)
  local x1, y1, x2, y2 = M.aabb(e, game)
  if not x1 then return nil end
  local W, H = game.stage_w, game.stage_h
  local clamp = function(v, lo, hi) if v < lo then return lo elseif v > hi then return hi else return v end end
  local left, right = clamp(x1 - 5, -W / 2, W / 2), clamp(x2 + 5, -W / 2, W / 2)
  local bottom, top = clamp(y1 - 5, -H / 2, H / 2), clamp(y2 + 5, -H / 2, H / 2)
  return math.round(left), math.round(bottom),
         math.abs(math.floor(right - left)), math.abs(math.floor(top - bottom))
end

---------------------------------------------------------------- 像素级命中（官方 is_touching）
-- 把舞台点映射到**纹理像素坐标**（官方那段变换；注意 y 轴方向相反）。
--
-- 官方源码（player.main:5447038 / crc_libs:1172650）：
--   i = scale.x>0 ? r.x-n.x + t.width/2  : r.x-n.x - t.width/2
--   a = scale.y>0 ? r.y-n.y + t.height/2 : r.y-n.y - t.height/2
--   return round(i/scale.x), round(a/scale.y)
-- 这里的 `t.width` 是 PIXI `Sprite.width` = **|scale.x| * texture.width**（显示尺寸，已缩放；
-- main-vendors:694860 `width:{get:()=>Math.abs(this.scale.x)*this._texture.orig.width}`）。
-- 所以等价于 `r.x-n.x + texture.width*scale.x/2`，再除 scale.x → `r.x/scale.x + texture.width/2`。
-- ★ 曾经的 bug：用 `texture.width/2` 再加、然后除 scale → scale=0.2 时中心映射到 5 倍纹理坐标（250），
--   越界 → is_touching 恒 false；scale≠1 的角色（nodevm 的「新角色1」scale=0.2）因此永不可点。
function M.coord_in_texture(e, wx, wy, game)
  local w, h, sc = M.actor_size(e, game)
  if not w or not h then return nil end
  local rad = math.rad(e.dir or 0)
  local c, s = math.cos(-rad), math.sin(-rad) -- rotAround(..., -rotation)
  local dx, dy = wx - e.x, wy - e.y
  local rx = dx * c - dy * s
  local ry = dx * s + dy * c
  -- PIXI 是 y 向下；我们的舞台是 y 向上 → 先在"图像坐标系"（y 向下）里做
  local iy = -ry
  local sx = e.scale_x or ((e.scale or 100) / 100)
  if e.flip_x then sx = -sx end
  local sy = e.scale_y or ((e.scale or 100) / 100)
  if e.flip_y then sy = -sy end
  if sx == 0 or sy == 0 then return nil end
  local i = rx + e.img_w * sx / 2
  local a = iy + e.img_h * sy / 2
  return math.floor(i / sx + 0.5), math.floor(a / sy + 0.5) -- Math.round
end

-- 该造型的 alpha 缓冲（官方 set_points_data：原分辨率 RGBA；我们只需要 alpha 字节）
-- 由宿主提供：host:style_pixels(style_id) → { w, h, rgba = <RGBA8 原始字节串> }
function M.style_pixels(e, game)
  local host = game.host
  if not host or not host.style_pixels then return nil end
  local id = sid_of(e)
  if not id or id == "" then return nil end
  if host._pixels_cache and host._pixels_cache[id] then return host._pixels_cache[id] end
  local px = host:style_pixels(id, game)
  host._pixels_cache = host._pixels_cache or {}
  host._pixels_cache[id] = px or false
  return px or nil
end

-- 官方 is_touching(点)
function M.is_touching(e, wx, wy, game)
  if not M.point_in_aabb(e, wx, wy, game) then return false end -- 粗筛（官方也是先包围盒）
  local px = M.style_pixels(e, game)
  if not px then
    -- 没有像素数据（无头/缺图）时退回包围盒 —— 与官方在"没有 current_style"时也 false 不同，
    -- 但测试环境拿不到图，这里保守地按包围盒判定。
    return true
  end
  local tx, ty = M.coord_in_texture(e, wx, wy, game)
  if not tx or not ty then return true end
  local w, h = e.img_w, e.img_h
  if tx < 0 or ty < 0 or tx >= w or ty >= h then return false end
  local a = M.alpha_at(px, ty * w + tx + 1)
  return a > 0
end

function M.point_in_aabb(e, wx, wy, game)
  local x1, y1, x2, y2 = M.aabb(e, game)
  if not x1 then return false end
  return wx >= x1 and wx <= x2 and wy >= y1 and wy <= y2
end

function M.invisible(e)
  local a = e.alpha
  local op = (e.effects and e.effects.opacity) or 0
  local eff_alpha = 1 - math.min(1, math.max(0, op / 100))
  local a1 = (a == nil) and 1 or (a / 100)
  return (a1 * eff_alpha) <= 0.001
end

---------------------------------------------------------------- 点击命中
-- 官方：每个显示对象各自挂监听 → 一次点击会派发给**所有命中对象**（不是只最上层）
-- 返回 hit_list 里所有 is_touching 为真的角色
function M.hit_list_at(game, wx, wy)
  local out = {}
  local list = require("rt.scene").hit_list(game)
  for i = 1, #list do
    local e = list[i]
    if e.kind == "actor" and e.visible ~= false and not e.deleted and not e.pointer_ignore and not M.invisible(e) then
      local w, h = M.actor_size(e, game)
      if w and w > 0 and h and h > 0 and M.is_touching(e, wx, wy, game) then
        out[#out + 1] = e
      end
    end
  end
  return out
end

function M.test(game, wx, wy)
  -- 官方：PIXI recursiveFindHit，自上而下，visible=false 直接跳过，命中用 is_touching
  local list = require("rt.scene").hit_list(game)
  for i = 1, #list do
    local e = list[i]
    if e.kind == "actor" and e.visible ~= false and not e.deleted and not e.pointer_ignore and not M.invisible(e) then
      local w, h = M.actor_size(e, game)
      if w and w > 0 and h and h > 0 and M.is_touching(e, wx, wy, game) then
        return e
      end
    end
  end
  return nil
end

-- 角色碰撞采样用的纹理探针：缓存反旋转/缩放参数，避免每个采样点重复三角函数。
local function texture_probe(e, game)
  local sid = sid_of(e)
  if e._probe and e._probe_sid == sid and e._probe_x == e.x and e._probe_y == e.y
     and e._probe_dir == e.dir and e._probe_sx == e.scale_x and e._probe_sy == e.scale_y
     and e._probe_fx == e.flip_x and e._probe_fy == e.flip_y then
    return e._probe
  end
  local w, h = M.actor_size(e, game)
  if not w or not h then return nil end
  local px = M.style_pixels(e, game)
  if not px then return nil end
  local rad = math.rad(e.dir or 0)
  local c, s = math.cos(-rad), math.sin(-rad)
  local sx = e.scale_x or ((e.scale or 100) / 100)
  if e.flip_x then sx = -sx end
  local sy = e.scale_y or ((e.scale or 100) / 100)
  if e.flip_y then sy = -sy end
  if sx == 0 or sy == 0 then return nil end
  local iw, ih = e.img_w or px.w, e.img_h or px.h
  local p = { e = e, px = px, c = c, s = s, sx = sx, sy = sy,
    iw = iw, ih = ih, iw2 = iw / 2, ih2 = ih / 2,
    -- 与 coord_in_texture 同一口径：偏移是**显示**半宽 (= texture/2 * scale)，
    -- 不能直接写 texture/2（scale≠1 时会把采样点映射到纹理之外）。
    offx = iw * sx / 2,
    offy = ih * sy / 2,
    inv_sx = 1 / sx, inv_sy = 1 / sy }
  e._probe = p
  e._probe_sid, e._probe_x, e._probe_y, e._probe_dir = sid, e.x, e.y, e.dir
  e._probe_sx, e._probe_sy, e._probe_fx, e._probe_fy = e.scale_x, e.scale_y, e.flip_x, e.flip_y
  return p
end

local function probe_hit(p, wx, wy)
  local e = p.e
  local dx, dy = wx - e.x, wy - e.y
  local rx = dx * p.c - dy * p.s
  local ry = dx * p.s + dy * p.c
  local iy = -ry
  local i = rx + p.offx
  local a = iy + p.offy
  local tx = math.floor(i * p.inv_sx + 0.5)
  local ty = math.floor(a * p.inv_sy + 0.5)
  if tx < 0 or ty < 0 or tx >= p.px.w or ty >= p.px.h then return false end
  return M.alpha_at(p.px, ty * p.px.w + tx + 1) > 0
end

---------------------------------------------------------------- 碰到角色（官方 check_bumped_other）
function M.overlaps(a, b, game)
  if not a or not b or a == b then return false end
  -- 同一帧内同一对角色只跑一次像素采样：表达式重复 bump_into / 多个 hat 共用结果。
  local cache, cache_key
  if game and game.host and a.id and b.id then
    local host = game.host
    if host._collision_frame ~= game.frame or not host._collision_cache then
      host._collision_frame = game.frame
      host._collision_cache = {}
    end
    cache = host._collision_cache
    cache_key = (tostring(a.id) < tostring(b.id)) and (tostring(a.id) .. "|" .. tostring(b.id))
      or (tostring(b.id) .. "|" .. tostring(a.id))
    -- 同一帧内移动/旋转/缩放也必须让缓存失效，不能只按 id 缓存。
    cache_key = table.concat({ cache_key,
      tostring(a.x), tostring(a.y), tostring(a.dir), tostring(a.scale_x), tostring(a.scale_y),
      tostring(a.flip_x), tostring(a.flip_y),
      tostring(b.x), tostring(b.y), tostring(b.dir), tostring(b.scale_x), tostring(b.scale_y),
      tostring(b.flip_x), tostring(b.flip_y) }, ":")
    if cache[cache_key] ~= nil then return cache[cache_key] end
    -- AABB 先粗筛，没重叠直接缓存 false，不进入采样。
    local ax1, ay1, ax2, ay2 = M.aabb(a, game)
    local bx1, by1, bx2, by2 = M.aabb(b, game)
    if not ax1 or not bx1 or not (ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1) then
      cache[cache_key] = false; return false
    end
  end
  -- 官方前置条件
  if a.visible == false or b.visible == false then return false end
  -- 官方：this.parent_scene.id !== other.parent_scene.id → false
  -- 全局角色在官方是"每个屏幕各一份实例"，其 parent_scene 即当前屏幕
  local function eff(e)
    if e.is_global or e.scene == nil or e.scene == "" then return game.cur_screen end
    return e.scene
  end
  if eff(a) ~= eff(b) then return false end
  if M.has_left_stage(a, game) or M.has_left_stage(b, game) then return false end
  local a1, b1, a2, b2 = M.aabb(a, game)
  local c1, d1, c2, d2 = M.aabb(b, game)
  if not a1 or not c1 then return false end
  if not (a1 < c2 and a2 > c1 and b1 < d2 and b2 > d1) then return false end -- AABB 粗筛
  -- 重叠区每 2 像素采样（官方 step = 2）
  local left, right = math.max(a1, c1), math.min(a2, c2)
  local bottom, top = math.max(b1, d1), math.min(b2, d2)
  local hits = 0
  local tiny = M.is_tiny(a, game) or M.is_tiny(b, game)
  local pa, pb = texture_probe(a, game), texture_probe(b, game)
  local y = top
  while y > bottom do
    local x = left
    while x < right do
      local hit
      if pa and pb then
        hit = probe_hit(pa, x, y) and probe_hit(pb, x, y)
      else
        -- 无 alpha 数据：保留原来的兜底路径（headless / 缺图）。
        hit = M.is_touching(a, x, y, game) and M.is_touching(b, x, y, game)
      end
      if hit then
        hits = hits + 1
        if tiny or hits >= M.MIN_POINTS_FOR_COLLISION then
          if cache then cache[cache_key] = true end
          return true
        end
      end
      x = x + 2
    end
    y = y - 2
  end
  if cache then cache[cache_key] = false end
  return false
end

function M.is_tiny(e, game)
  local w, h = M.actor_size(e, game)
  if not w then return false end
  return w * h < 2 * M.MIN_POINTS_FOR_COLLISION
end

return M
