-- 运行时内核共享状态：常量 / 哨兵 / 宿主注入 / 诊断 / 时间源
-- （原 rt/core.lua 头部；2026-10-24 拆分）

-- 语义对齐官方 Heart/Ohno 引擎；阈值见 S.C（与官方 Config 一致）。

local S = {}

local C = {
  max_warp_iterations = 30000, -- 官方 max_warp_iterations_per_interpreter_step
  warp_time_limit_ms = 4,      -- 官方 warp_interpreter_millisecond_time_limit
  max_clones_per_entity = 300,
  max_threads = 2000,
}
S.C = C

local function copy_value(v)
  if type(v) ~= "table" then return v end
  local t = {}
  for k, x in pairs(v) do t[k] = copy_value(x) end
  return t
end
S.copy_value = copy_value

-- 哨兵错误：用 identity 比较，error(obj, 0) 抛出，调度器在 resume 处捕获
local SIG = { STOP_THIS = {}, STOP_OTHER = {}, STOP_ALL = {}, RESTART = {}, BREAK_ALL = {} }
S.SIG = SIG

local host -- 由 core.set_host 注入

function S.set_host(h)
  host = h
end

function S.get_host() return host end

-- 诊断日志：同时写 host（终端/logcat）与 At.log（AtLua 控制台可见）。
function S.diag(fmt, ...)
  local msg = select("#", ...) > 0 and string.format(tostring(fmt), ...) or tostring(fmt)
  if host and host.log then pcall(host.log, host, msg, "diag") end
  local ok, A = pcall(require, "At.At")
  if ok and A and A.log and A.log.info then pcall(A.log.info, msg) end
end

function S.warn(fmt, ...)
  local msg = select("#", ...) > 0 and string.format(tostring(fmt), ...) or tostring(fmt)
  if host and host.log then pcall(host.log, host, msg, "warn") end
  local ok, A = pcall(require, "At.At")
  if ok and A and A.log and A.log.warn then pcall(A.log.warn, msg) end
end

local function now_ms()
  return host:now_ms()
end

----------------------------------------------------------------------

-- 时间源（原来 core.now_ms 直接转发到这里）
function S.now_ms() return now_ms() end

return S
