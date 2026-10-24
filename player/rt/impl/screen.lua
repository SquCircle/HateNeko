-- 舞台与切屏（来自 op_sensing.lua）


local M = {}

local function game(th) return th.sched.game end


function M.get_stage_info(self, args, th)
  local g = game(th)
  if tostring(args.type or "width") == "height" then return g.stage_h end
  return g.stage_w
end


---------------------------------------------------------------- 切屏
-- 切屏：显示目标屏幕的角色、隐藏其它屏幕的（官方切屏还会重置该屏的脚本，这里先做显隐）

function M.switch_to_screen(self, args, th)
  local g = game(th)
  local raw = args.screen_id or args.screen or args.id or args.name
  local key = (type(raw) == "number" or tostring(raw) == "next" or tostring(raw) == "prev")
    and g:resolve_screen(raw) or g:resolve_var_key(raw)
  if key == nil then return end
  if not g.screens[key] then key = g:resolve_screen(raw) or key end
  if key == nil or not g.screens[key] or key == g.cur_screen then return end
  local Scene = require("rt.scene")
  local old = g.cur_screen
  -- 机制（官方源码，非推测）：见 Sched:step 里的 thread_in_running_group 分支。
  --   `interpreter_out_of_running_group(group_id) ? block_finish_out_of_run_group(type) && dispose
  --                                          : is_blocking || _step`
  -- （player.main:4829705 step_code）
  -- 即：切屏**不销毁**除「进入屏幕」外的线程，只是**冻结**（不 step）；切回该屏会继续。
  -- 旧实现把旧屏线程 done=true 直接杀，导致"切回原屏后原脚本永久失效"（R1 审计 bug）。
  -- 这里不再杀线程；旧屏的绿旗线程会在下一次 step 判断为跑出运行组而被销毁。
  -- 旧屏幕的克隆体随屏幕销毁；否则回到该屏幕时旧 clone 会残留，
  -- 表现为点击位置的“残影/印章”。
  for i = #g.entities, 1, -1 do
    local e = g.entities[i]
    local parent_scene = e.parent and (e.parent.scene or (e.parent.scenes and e.parent.scenes[1]))
    if e.is_clone and (e.scene == old or parent_scene == old) then
      if g.bubbles then g.bubbles[e] = nil end
      if e.parent then e.parent.clones = math.max(0, (e.parent.clones or 0) - 1) end
      table.remove(g.entities, i)
    end
  end
  for _, e in ipairs(g.entities) do
    if e.kind ~= "screen" and (e.scene == old or (e.scenes and e.scenes[1] == old)) then
      e.clones, e.clone_seq = 0, 0
    end
  end
  local cfg = g.transition_cfg or { type = "none", direction = "up" }
  if cfg.type ~= "none" and cfg.type ~= nil then
    g.transition = { type = cfg.type, direction = cfg.direction, elapsed = 0,
      duration = cfg.duration or 0.35, from = old, to = key }
  end
  g.cur_screen = key
  -- 笔层按当前屏幕切换；不清空任何屏幕的笔层。
  -- 切换场景门（唯一权威判定），并启动新屏幕的绿旗
  g.sched:fire_green_flag(key)
  -- 官方语义：切屏语句**不中断**当前解释器（domain 函数返回后继续跑，直到下一次 yield；
  -- 从下一帧起它因"跑出运行组"被冻结/销毁）。旧实现在这里 error(STOP_THIS)，
  -- 会让"切屏 → 后续语句"整段永远不执行（R1 审计 bug）。
end

function M.set_screen_transition(self, args, th)
  local g = game(th)
  g.transition_cfg = { type = tostring(args.type or "none"),
    direction = tostring(args.direction or "up"), duration = tonumber(args.duration) or 0.35 }
end

function M.get_screens(self, args, th)
  -- 官方 get_screens 直接返回字段值（next/prev/UUID/name/数字）。
  return args.screen_id
end

return M
