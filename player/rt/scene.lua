-- 场景视图的唯一权威（把"运算"和"渲染"解耦的关键一环）
--
-- 约定（项目架构原则）：
--   * 运算（调度器）：只遍历**正在运行的线程**；它不关心有哪些实体、谁可见。
--   * 渲染 / 命中：只遍历**当前 scene 的实体**，这份列表只能由本模块提供。
--
-- 为什么需要它：过去渲染、命中、切屏各自按各自的方式筛实体（还用名字/创建顺序当图层），
-- 于是"谁盖住谁、点到谁、哪个屏幕的角色该显示"三处结论经常不一致。
-- 现在统一走这里：可见性/场景门/图层顺序只有一处定义。
local Values = require("rt.values")

local M = {}

-- 场景门：角色是否属于当前屏幕（全局角色恒属于）
function M.in_scene(e, game)
  -- 屏幕实体：只有"当前屏幕"那个算在内（别的屏幕的实体及其脚本都不参与）
  if e.kind == "screen" then
    if game.cur_screen == nil then return true end
    return e.id == game.cur_screen
  end
  if e.is_global then return true end
  -- 优先用"所属屏幕列表"（编辑器里一个角色可能被多个屏幕共享）
  if e.scenes and #e.scenes > 0 then
    local cur = game.cur_screen
    for _, sid in ipairs(e.scenes) do if sid == cur then return true end end
    return false
  end
  -- 完全没有场景信息的实体（测试构造/旧数据）按"全局"处理；有信息才判定
  if e.scene == nil or e.scene == "" then return true end
  return e.scene == game.cur_screen
end

-- 绘制/命中共用的唯一排序：**自下而上**。
-- 官方 get_actor_ids() 返回 PIXI children 顺序（crc_libs:1 byte 1141200），
-- set_z_index 的 0 是底层、末尾是顶层（byte 1162523），setTopBottomLayer 的 peak 取末尾
-- （main.15ba0757.js:1 byte 1609639）→ order 大 = 上层，后创建的克隆体在上。
local function bottom_first(a, b)
  local la, lb = a.layer or 0, b.layer or 0
  if la ~= lb then return la < lb end
  local oa, ob = a.order or 0, b.order or 0
  if oa ~= ob then return oa < ob end
  -- 真实实体一定由 Entity.new 分配 seq；裸 table（旧测试/外部构造）没有 seq，
  -- 回退到 game.entities 的位置（= 官方 PIXI children 的创建次序）。
  return (a.seq or a._idx or 0) < (b.seq or b._idx or 0)
end

-- 当前屏幕应当参与**渲染**的实体（可见 + 场景内），自下而上排好序。
-- 性能：复用同一张表；并先做一次 O(n) 有序性检查，顺序没变就不排序（大多数帧如此）。
function M.render_list(game)
  local list = game._render_list
  if not list then
    list = {}
    game._render_list = list
  end
  local n = 0
  local sorted = true
  local prev = nil
  local entities = game.entities
  for i = 1, #entities do
    local e = entities[i]
    e._idx = i
    if e.kind ~= "screen" and e.visible ~= false and M.in_scene(e, game) then
      n = n + 1
      list[n] = e
      if prev and not bottom_first(prev, e) then sorted = false end
      prev = e
    end
  end
  for i = #list, n + 1, -1 do list[i] = nil end
  if not sorted then table.sort(list, bottom_first) end
  return list
end

-- 命中候选：与 render_list **严格互为反序**（第一个就是最上层）
function M.hit_list(game)
  local list = {}
  for i, e in ipairs(game.entities) do
    if e.kind ~= "screen" and e.visible ~= false and M.in_scene(e, game) and not e.deleted then
      e._idx = i
      list[#list + 1] = e
    end
  end
  table.sort(list, function(a, b) return bottom_first(b, a) end)
  return list
end

return M
