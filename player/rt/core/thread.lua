-- 线程（协程）：迭代让出 / warp 预算 / 阻塞 / 过程参数栈
-- （原 rt/core.lua Thread 段；2026-10-24 拆分）

local S = require("rt.core.state")
local SIG, C, now_ms = S.SIG, S.C, S.now_ms

local Thread = {}
Thread.__index = Thread

function Thread.new(sched, owner, hat, args, body, event, exec_self)
  local t = setmetatable({}, Thread)
  t.sched = sched
  t.owner = owner
  t.base_exec_self = exec_self or owner
  t.execution_self = t.base_exec_self
  t.hat = hat
  t.args = args or {}
  t.event = event or {}
  t.body = body
  t.blocked_until = 0
  t.done = false
  t.warp_frames = 0   -- 运行期 warp 深度（覆盖 warp 内调用的过程体）
  t.warp_iters = 0    -- 本帧已消耗的 warp 迭代数
  t.frame_start = 0
  t.script_vars = {}  -- 脚本私有变量（官方按 interpreter 作用域）
  t.born_frame = (sched and sched.game and sched.game.frame) or 0
  t.params = {}       -- 参数栈：traverse_number_param / self_listen_param
  t.frames = {}       -- trampoline 过程帧
  t.call_depth = 0
  t.wait_for = nil    -- 等待的线程集合（广播并等待 / 告诉执行并等待）
  t.lock_count = 0    -- per-thread 阻塞锁数量（官方 get_thread_lock 的 interpreter 粒度）
  t.co = coroutine.create(function()
    body(t, t.execution_self)
  end)
  return t
end

-- 循环收尾：非 warp —— 每帧 1 次迭代
-- 返回 true 表示「本层循环应跳出」（break 积木）
function Thread:iter_n()
  if _G._YIELD_PROBE then
    local info = debug.getinfo(2, "Sl")
    if info then
      local key = tostring(info.short_src) .. ":" .. tostring(info.currentline)
      _G._YIELD_SEEN = _G._YIELD_SEEN or {}
      if not _G._YIELD_SEEN[key] then
        _G._YIELD_SEEN[key] = true
        print("[YIELD] " .. key .. "  hat=" .. tostring(self.hat) .. " owner=" .. tostring(self.owner and self.owner.name))
      end
    end
  end
  coroutine.yield()
  return false
end

-- 循环收尾：编译期已知在「一步执行(warp)」内
function Thread:iter_w()
  self:budget_warp()
  return false
end

-- 循环收尾：运行期判断（过程体 / tell 体：可能被 warp 调用）
function Thread:iter_d()
  if self.warp_frames > 0 then
    self:budget_warp()
  else
    coroutine.yield()
  end
  return false
end

function Thread:budget_warp()
  local n = self.warp_iters + 1
  self.warp_iters = n
  if n >= C.max_warp_iterations then
    coroutine.yield()
  elseif (n % 32) == 0 and (now_ms() - self.frame_start) >= C.warp_time_limit_ms then
    coroutine.yield()
  end
end

-- 阻塞：登记 blocked_until 后让出（官方 runtime_manager.thread_wait）
function Thread:block(ms)
  self.blocked_until = now_ms() + ms
  coroutine.yield()
end

function Thread:warp_enter()
  self.warp_frames = self.warp_frames + 1
end

function Thread:warp_exit()
  self.warp_frames = self.warp_frames - 1
end

function Thread:push_param(v)
  local n = #self.params + 1
  self.params[n] = v
  return n
end

function Thread:pop_params(n)
  for i = #self.params, n, -1 do self.params[i] = nil end
end

function Thread:pop_param()
  local n = #self.params
  if n > 0 then self.params[n] = nil end
end

function Thread:param()
  return self.params[#self.params]
end

-- 过程 trampoline：不在 Lua C 栈上递归，由 Sched:resume 驱动显式帧。
function Thread:call_proc(proc, self_arg, ...)
  if type(proc) ~= "function" then return nil end
  if coroutine.status(self.co) ~= "suspended" and coroutine.status(self.co) ~= "running" then
    return nil
  end
  self._proc_calls = (self._proc_calls or 0) + 1
  return coroutine.yield({
    __kn_proc = proc,
    __kn_self = self_arg,
    __kn_args = { ... },
    __kn_n = select("#", ...),
  })
end

-- 等待一组线程跑完（广播并等待 / 告诉执行并等待）
function Thread:join(threads)
  local set, count = {}, 0
  for i = 1, #threads do
    local th = threads[i]
    if th and not th.done then
      set[th] = true
      count = count + 1
    end
  end
  if count == 0 then return end -- 没有接收者：立即继续
  self.wait_for = set
  coroutine.yield()
end

----------------------------------------------------------------------
-- 调度器

return { Thread = Thread }
