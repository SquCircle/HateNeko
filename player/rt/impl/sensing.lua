-- 侦测（碰撞/坐标/属性/特效值/鼠标/按键）（来自 op_sensing.lua）


local V = require("rt.values")
local M = {}

local function game(th) return th.sched.game end


local EDGE_NAMES = {
  ["0"] = "edge", ["edge"] = "edge", ["--edge"] = "edge",
  ["1"] = "left", ["edge_left"] = "left", ["--edge_left"] = "left",
  ["2"] = "top", ["edge_top"] = "top", ["--edge_top"] = "top",
  ["3"] = "bottom", ["edge_bottom"] = "bottom", ["--edge_bottom"] = "bottom",
  ["4"] = "right", ["edge_right"] = "right", ["--edge_right"] = "right",
}

local function edge_name(v)
  local k = tostring(v or ""):lower()
  return EDGE_NAMES[k] or EDGE_NAMES[tostring(v or "")]
end

-- 把"目标槽"解析成 { kind = entity|point|edge|stage|camp, ... }

local function resolve_target(g, self, v)
  if v == nil or v == "" or v == "--self" then
    return { kind = "entity", e = self }
  end
  local sv = tostring(v)
  if sv == "--mouse" then
    -- 官方 bumpInto @1557532：直接取 getMousePosition() 判 NaN，**不要求按下**。
    -- PC 悬停即算碰到；触屏抬起后官方把位置置 NaN（本运行时 pointer_valid=false）。
    local px, py = g:pointer_world()
    if px ~= px or py ~= py then return { kind = "none" } end
    return { kind = "point", x = px, y = py }
  end
  if sv == "--screen" then return { kind = "stage" } end
  local en = edge_name(sv)
  if en then return { kind = "edge", which = en } end
  if sv:match("^camp_") then return { kind = "camp", camp = sv } end
  local e = g:find(sv)
  if e then return { kind = "entity", e = e } end
  return nil
end

-- 角色包围盒是否**碰到**某条舞台边（"碰到下边缘"= 最低点到达舞台底）

local function touches_edge(e, which, g)
  local x1, y1, x2, y2 = require("rt.hit").aabb(e, g)
  if not x1 then return false end
  local W, H = g.stage_w, g.stage_h
  local L, R, B, T = -W / 2, W / 2, -H / 2, H / 2
  if which == "bottom" then return y1 <= B end
  if which == "top" then return y2 >= T end
  if which == "left" then return x1 <= L end
  if which == "right" then return x2 >= R end
  return x1 <= L or x2 >= R or y1 <= B or y2 >= T
end

-- 角色包围盒是否**整个离开**某条舞台边（"跑出舞台"= 完全越过）

local function past_edge(e, which, g)
  local x1, y1, x2, y2 = require("rt.hit").aabb(e, g)
  if not x1 then return false end
  local W, H = g.stage_w, g.stage_h
  local L, R, B, T = -W / 2, W / 2, -H / 2, H / 2
  if which == "bottom" then return y2 <= B end
  if which == "top" then return y1 >= T end
  if which == "left" then return x2 <= L end
  if which == "right" then return x1 >= R end
  return x2 <= L or x1 >= R or y2 <= B or y1 >= T
end

local function collide(g, self, a, b)
  local Hit = require("rt.hit")
  if a.kind == "none" or b.kind == "none" then return false end
  local function as_entity(t)
    if t.kind == "entity" then return t.e end
  end
  local ea, eb = as_entity(a), as_entity(b)
  -- 两个角色：像素级（官方 check_bumped_other：同 scene + 可见 + 重叠区采样）
  if ea and eb then
    if ea == eb then return touches_edge(ea, "edge", g) end   -- 自己碰自己 → 按"碰边缘"处理
    return Hit.overlaps(ea, eb, g)
  end
  -- 角色 × 鼠标点
  if ea and b.kind == "point" then return Hit.is_touching(ea, b.x, b.y, g) end
  if eb and a.kind == "point" then return Hit.is_touching(eb, a.x, a.y, g) end
  -- 角色 × 边缘 / 舞台
  if ea and b.kind == "edge" then return touches_edge(ea, b.which, g) end
  if eb and a.kind == "edge" then return touches_edge(eb, a.which, g) end
  if ea and b.kind == "stage" then return touches_edge(ea, "edge", g) end
  if eb and a.kind == "stage" then return touches_edge(eb, "edge", g) end
  -- 阵营（camp_*）：该阵营里任一角色碰到另一端
  local function camp_hit(t, other)
    if t.kind ~= "camp" then return nil end
    for _, e in ipairs(g.entities) do
      if not e.deleted and e.kind == "actor" and tostring(e.camp or "") == t.camp
         and not require("rt.hit").invisible(e) then
        local r = collide(g, self, { kind = "entity", e = e }, other)
        if r then return true end
      end
    end
    return false
  end
  local ch = camp_hit(a, b); if ch ~= nil then return ch end
  ch = camp_hit(b, a); if ch ~= nil then return ch end
  return false
end

function M.bump_into(self, args, th)
  local g = game(th)
  -- 快路径（表达式每帧大量重复）：--self × 角色 / 边缘 / 舞台 / 鼠标，不建 target 表
  local a, b = args.sprite, args.sprite1
  local is_camp = type(b) == "string" and b:sub(1, 5) == "camp_"
  if (a == nil or a == "--self" or a == "") and b ~= nil and not is_camp then
    if b == "--screen" then
      return touches_edge(self, "edge", g)
    end
    local en = edge_name(b)
    if en then return touches_edge(self, en, g) end
    if b == "--mouse" then
      local px, py = g:pointer_world()
      if px ~= px or py ~= py then return false end
      return require("rt.hit").is_touching(self, px, py, g)
    end
    if b == "--self" then return touches_edge(self, "edge", g) end
    local t = g:find(b)
    if t then return require("rt.hit").overlaps(self, t, g) end
    return false
  end
  -- 官方形态：{ sprite = 主体1, sprite1 = 主体2 }（碰撞是二元的，"碰到下边缘"就是 sprite1="--edge_bottom"）
  if args.sprite1 ~= nil then
    local a = resolve_target(g, self, args.sprite or "--self")
    local b = resolve_target(g, self, args.sprite1)
    if not a or not b then return false end
    return collide(g, self, a, b)
  end
  -- 单槽老形态（旧编译器/测试用）：
  --   sprite = "--self"  → 指针是否压在"我"身上
  --   sprite = 其它      → "我"是否碰到它
  if args.sprite == nil or tostring(args.sprite) == "--self" then
    local px, py = g:pointer_world()
    return require("rt.hit").is_touching(self, px, py, g)
  end
  local b = resolve_target(g, self, args.sprite)
  if not b then return false end
  return collide(g, self, { kind = "entity", e = self }, b)
end

function M.bump_into_color(self, args, th)
  local g = game(th)
  local target = self
  local spr = args.sprite or "--self"
  if spr ~= "--self" and g.find then target = g:find(spr) or self end
  local color = args.color or args.COLOR or "#000000"
  if g.host and g.host.color_touching then return g.host:color_touching(target, g, color) end
  return false
end
-- 碰到边缘：造型包围盒超出舞台范围

function M.out_of_boundary(self, args, th)
  -- 「判断离开边缘」：边界下拉（0=整个舞台 1=左 2=上 3=下 4=右），
  -- 语义是"**整个**包围盒越过该边"（has_left_stage 的逐边版本）。
  local which = edge_name(args.boundary or args.type)
  local g = game(th)
  if not which then return require("rt.hit").has_left_stage(self, g) end
  return past_edge(self, which, g)
end

function M.distance_to(self, args, th)
  -- 官方 distanceTo @1562155：自身位置到目标（支持 --mouse）；Math.hypot；结果保留两位小数；
  -- 目标缺失 → NaN（不是 0）。
  local g = game(th)
  local ax, ay = self.x or 0, self.y or 0
  local sprite = args.sprite
  local bx, by
  if sprite == "--mouse" then
    if g.host and g.host.pointer_valid == false then return 0 / 0 end
    bx, by = g:pointer_world()
  elseif sprite == nil or sprite == "" or sprite == "--self" then
    bx, by = ax, ay
  else
    local target = g:find(sprite)
    if not target then return 0 / 0 end
    bx, by = target.x or 0, target.y or 0
  end
  local d = math.sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
  return math.floor(d * 100 + 0.5) / 100
end

function M.coordinate_of_sprite(self, args, th)
  local sprite = args.sprite
  local t = args.coordinate or args.type or args.coord or "x"
  -- 快路径：--self（绝大多数）+ x/y，不碰 game/find/tostring
  if sprite == nil or sprite == "--self" or sprite == "" then
    if t == "y" or t == "Y" then return self.y end
    return self.x
  end
  local g = game(th)
  local target = g:find(sprite) or self
  t = tostring(t):lower()
  if t == "y" then return target.y end
  return target.x
end

function M.style_of_sprite(self, args, th)
  local g = game(th)
  local target = self
  if args.sprite and args.sprite ~= "--self" then target = g:find(args.sprite) or self end
  local t = tostring(args.type or "index")
  if t == "name" then return tostring(target:style_id() or "") end
  return target.style_index
end

function M.appearance_of_sprite(self, args, th)
  local g = game(th)
  local target = self
  if args.sprite and args.sprite ~= "--self" then target = g:find(args.sprite) or self end
  local t = tostring(args.appearance or args.type or "scale")
  -- 官方「角色属性值」选项：scale/width/height/direction/visibility（见 block_catalog options）
  -- 单位：scale = **百分比**（作品里 (115 - appearance) 这类算式只有百分比成立）
  --       width/height = **像素**（官方取的是 PIXI 的 width/height，已在舞台上量过缩放）
  --       direction = **度**（KN 口径，逆时针为正）
  local sx = target.scale_x or 1
  local sy = target.scale_y or 1
  -- 宽度/高度同样按**百分比**返回（与"更改角色大小"同一口径；100 = 原尺寸）
  if t == "width" then return sx * 100 end
  if t == "height" then return sy * 100 end
  if t == "xscale" then return sx * 100 end
  if t == "yscale" then return sy * 100 end
  if t == "direction" or t == "rotation" then return target.dir or 0 end
  if t == "visibility" or t == "visible" then return target.visible and 1 or 0 end
  if t == "x" then return target.x or 0 end
  if t == "y" then return target.y or 0 end
  -- 「大小」：两轴统一写之后以 x 轴为准（宽高块只改单轴时也能读到最新值）
  return sx * 100
end

-- 官方 get_sprite_property（编辑器把 coordinate/style/appearance/effect 统一到这个块）：
--   x/y → 坐标；style_index → 造型序号；scale/width/height/direction → 外观；
--   distance → 距离；0..6/color/opacity/... → 特效值。不支持 → NaN（官方抛"暂不支持"）。

function M.get_sprite_property(self, args, th)
  local attr = tostring(args.attribute or args.type or "")
  local sprite = args.sprite
  if attr == "x" or attr == "y" then
    return M.coordinate_of_sprite(self, { sprite = sprite, coordinate = attr }, th)
  end
  if attr == "style_index" or attr == "style" then
    return M.style_of_sprite(self, { sprite = sprite, type = "index" }, th)
  end
  if attr == "scale" or attr == "width" or attr == "height"
     or attr == "direction" or attr == "rotation" or attr == "visibility" then
    return M.appearance_of_sprite(self, { sprite = sprite, appearance = attr }, th)
  end
  if attr == "distance" then
    return M.distance_to(self, { sprite = sprite }, th)
  end
  local effect = ({
    ["0"] = "0", ["1"] = "1", ["2"] = "2", ["3"] = "3",
    ["4"] = "4", ["5"] = "5", ["6"] = "6",
    color = "0", opacity = "1", brightness = "2", pixelate = "3",
    ripple = "4", distortion = "5", grayscale = "6",
  })[attr]
  if effect ~= nil then
    return M.effect_of_sprite(self, { sprite = sprite, effect = effect }, th)
  end
  return 0 / 0
end

function M.effect_of_sprite(self, args, th)
  local g = game(th)
  local target = self
  if args.sprite and args.sprite ~= "--self" then target = g:find(args.sprite) or self end
  -- 官方 effect_of_sprite → getSceneOrActorProperty(get_effects, scope)（player.main:2095562 段；
  -- 取值实现是 main.15ba0757.js 模块 40206 的 v 函数）：
  --   0 hue / 2 brightness / 3 pixelate / 4 displacement / 5 twist / 6 grey(=-saturate) → round(...,2)
  --   1 **透明**不是特效槽**：`visible ? round(100*(1-alpha),2) : 100`
  local code = tostring(args.effect or args.attribute or args.type or "0")
  local function r2(v)
    if type(v) ~= "number" or v ~= v then return v end
    return math.floor(v * 100 + 0.5) / 100
  end
  if code == "1" or code == "opacity" or code == "transparency" then
    if target.visible == false then return 100 end
    return r2(100 - (target.alpha or 100))
  end
  local map = { ["0"] = "color", ["1"] = "opacity", ["2"] = "brightness", ["3"] = "pixelate",
                ["4"] = "ripple", ["5"] = "distortion", ["6"] = "grayscale" }
  local key = map[code] or "color"
  return r2((target.effects or {})[key] or 0)
end

local function hit_table_has(hits, owner)
  if not hits or not owner then return false end
  if hits[owner.id] then return true end
  local oid = tostring(owner.id or "")
  if oid == "" then return false end
  for id in pairs(hits) do
    if type(id) == "string" and id:sub(1, #oid + 1) == oid .. "#" then return true end
  end
  return false
end

-- 目标实体（或它的克隆体）是否在某个 id 集合里

local function id_in(set, e)
  if not set or not e then return false end
  if set[e.id] then return true end
  local p = tostring(e.id) .. "#"
  for id in pairs(set) do
    if type(id) == "string" and id:sub(1, #p) == p then return true end
  end
  return false
end

function M.mouse_down(self, args, th)
  -- 官方 mouseDown @1562946（配合官方 sprite_on_tap / global_tap / global_click 动作状态）：
  --   --screen：click → global_click（仅空白处点击，one_frame）；down/up → global_tap
  --   指定角色：click → getIsMouseClickTarget(entity)（每帧清空）；down/up → sprite_on_tap 状态
  local g = game(th)
  local host = g.host
  local t = tostring(args.type or "down")
  local target = args.sprite
  -- 旧测试/直接注入输入态（从未产生过事件）时退回鼠标原始状态
  if host.global_tap == nil then
    if t == "click" then return g.last_click_frame == g.frame end
    if t == "down" then return host.mouse_is_down == true end
    return host.mouse_up == true
  end
  if target == nil or target == "" or target == "--screen" then
    if t == "click" then return host.global_click == true end
    if t == "down" then return host.global_tap == "mouse_down" end
    return host.global_tap == "mouse_up"
  end
  local e
  if target == "--self" or target == self.id or target == self.name then
    e = self
  else
    e = g:find(target)
  end
  if not e then return false end
  if t == "click" then
    if host.click_targets then return id_in(host.click_targets, e) end
    return id_in(host.click_hits, e)
  end
  local st = nil
  local action = host.tap_action or {}
  if action[e.id] ~= nil then
    st = action[e.id]
  else
    local p = tostring(e.id) .. "#"
    for id, v in pairs(action) do
      if type(id) == "string" and id:sub(1, #p) == p then st = v end
    end
  end
  if t == "down" then return st == "mouse_down" end
  return st == "mouse_up"
end

function M.check_key(self, args, th)
  -- 官方 checkKey @1563644：on_keydown 动作状态 === type（down/up 会一直保持到最后一次事件）
  local host = game(th).host
  local code = tostring(args.key or "")
  local want = tostring(args.type or "down")
  local st = host.key_states and host.key_states[code]
  if st == nil then
    -- 旧测试/直接注入 host.keys 的路径
    local down = (host.key_down and host:key_down(code) == true)
      or (host.keys and host.keys[code] == true)
    return (want == "down") and down or false
  end
  return st == want
end

function M.get_mouse_info(self, args, th)
  local g = game(th)
  local host = g.host
  -- PC：鼠标位置在 mouseup 后继续有效（官方 __IS_PC__ 分支）。
  -- 移动端：手指抬起后位置为 NaN（官方 touchend 清空）。
  if not host or host.pointer_valid == false then return 0 / 0 end
  if host.is_mobile and not host.mouse_is_down then return 0 / 0 end
  if type(g.pointer_world) ~= "function" then return 0 / 0 end
  local wx, wy = g:pointer_world()
  -- 官方 getMouseInfo @1563856：round(坐标, 2)
  local function round2(v)
    if v ~= v then return v end
    return math.floor(v * 100 + 0.5) / 100
  end
  local t = tostring(args.type or "x"):lower()
  if t == "y" then return round2(wy) end
  return round2(wx)
end

function M.get_voice_volume(self) return 0 end

function M.get_orientation(self)
  -- 手机传感器暂未接入：倾斜角按离线占位返回 0。
  return 0
end

function M.get_voice_answer(self) return "" end

---------------------------------------------------------------- 计时器 / 时间 / 舞台

return M
