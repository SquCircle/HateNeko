-- 控制类原语（阻塞 / 并发 / 中断 / 广播）
-- 注意：循环与条件（repeat_*/controls_if）由**编译器内联**成 Lua 原生语法，
-- 不在这里；这里只有「需要新建线程 / 需要让出 / 需要中断」的原语。
-- 统一签名：function(self, args, th)
local V = require("rt.values")

local M = {}
local SIG = require("rt.core").SIG

-- 等待秒数（官方 runtime_manager.thread_wait(interpreter, entity, ms)）
function M.wait(self, args, th)
  local t = V.num(args.time)
  -- 官方语义（原版实测 + nan_to_zero_conversion_blocks）：
  --   NaN  → 0
  --   负数 → 0
  --   +inf → **真的等无限久**（原版 setTimeout(Infinity) 就是永远不回来）
  -- 所以这里把 +inf 折成一个"实际上等不到"的极大值（1e9 秒 ≈ 31 年），
  -- 而不是 0——归零会让"1 ÷ 0"这种算式算出的 inf 变成每帧空转（闪屏）。
  if t ~= t then t = 0
  elseif t < 0 then t = 0
  elseif t == math.huge then t = 1e9
  elseif t == -math.huge then t = 0 end
  th:block(t * 1000)
end

-- 等待直到（编译期通常内联成 while not cond do th:iter_n() end；这是闭包版）
function M.wait_until(self, args, th)
  local cond = args.cond or args.condition
  if type(cond) == "function" then
    while not V.js_boolean(cond(self, th)) do th:iter_n() end
  end
end

-- 停止脚本：scope 0=全部脚本 1=当前脚本 2=当前角色的其它脚本 3=其它角色的脚本
function M.stop(self, args, th)
  local scope = tostring(args.scope or "1")
  if scope == "0" then
    error(SIG.STOP_ALL, 0)
  elseif scope == "2" then
    -- 官方：停止当前角色的其它脚本；当前脚本继续执行。
    th.sched:stop_scope(th, "other")
  elseif scope == "3" then
    -- 其它角色的脚本：当前线程继续；停止的线程标记 stopped，避免 restart_when_finished 复活。
    local sched = th.sched
    for i = 1, #sched.threads do
      local other = sched.threads[i]
      if other ~= th and other.owner ~= self then
        other.stopped = true
        sched:finish(other)
      end
    end
  else
    error(SIG.STOP_THIS, 0)
  end
end

function M.restart(self, args, th)
  error(SIG.RESTART, 0)
end

local function screen_of(game)
  for i = 1, #game.entities do
    if game.entities[i].kind == "screen" then return game.entities[i] end
  end
  return nil
end

local function target_of(ref, self, th)
  if ref == nil or ref == "" or ref == "--self" then return self end
  if ref == "--screen" then return screen_of(th.sched.game) end
  return th.sched.game:find(ref)
end

-- 告诉执行：在目标角色上新建线程跑同一段 body（不同步等待）
function M.tell(self, args, th)
  local target = target_of(args.sprite or args.target, self, th)
  if not target then return end
  local do_ = args.DO
  if type(do_) ~= "function" then return end
  th.sched:spawn(target, "tell", {}, function(t2, s2) do_(t2, s2) end, {})
end

-- 告诉执行并等待（官方 eval_sync_tell：同一解释器内联执行，不 spawn）
-- 不能包 pcall：DO 里可能含 wait/yield，Lua5.1 不允许跨 pcall 让出。
function M.sync_tell(self, args, th)
  local target = target_of(args.sprite or args.target, self, th)
  if not target then return end
  local do_ = args.DO
  if type(do_) ~= "function" then return end
  local prev = th.execution_self
  th.execution_self = target
  do_(th, target)
  th.execution_self = prev
end

-- 一步执行（warp）：编译期主路径是内联 th:warp_enter()/warp_exit()，这是闭包版
function M.warp(self, args, th)
  local do_ = args.DO
  if type(do_) ~= "function" then return end
  th:warp_enter()
  local ok, err = pcall(do_, th, self)
  th:warp_exit()
  if not ok then error(err, 0) end
end

-- 发送广播：立即返回（接收者各自新建线程）
function M.self_broadcast(self, args, th)
  th.sched:broadcast(args.message, nil, self)
end

-- 发送广播并携带内容
function M.self_broadcast_with_param(self, args, th)
  th.sched:broadcast(args.message, args.param, self)
end

-- 发送广播并等待：等所有接收线程结束
function M.self_broadcast_and_wait(self, args, th)
  -- 先绑定已存在的 listener，再广播；两者都要等。
  local live = th.sched:live_listeners(args.message)
  local started, state = th.sched:broadcast(args.message, nil, self, nil, true, th)
  for _, t in ipairs(live) do
    started[#started + 1] = t
    if state then
      local key = tostring(t.reg or t)
      if not state.listeners[key] then state.listeners[key] = true; state.count = state.count + 1 end
      t._broadcast_state = state
    end
  end
  if state and state.count > 0 then state.status = "sending" else if state then state.status = "idle" end end
  th:join(started)
end

-- 克隆 / 删除本克隆体
function M.mirror(self, args, th)
  local target = target_of(args.sprite or args.target, self, th)
  if not target then return end
  th.sched:mirror(target)
end

function M.dispose_clone(self, args, th)
  th.sched:dispose_clone(self)
end

function M.console_log(self, args, th)
  local host = th.sched.game.host
  if host and host.log then host:log(V.str(args.console_log or args.value), "info") end
end

return M
