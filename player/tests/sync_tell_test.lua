-- sync_tell 官方语义回归：同线程内联执行 DO、切换 execution_self、结束后恢复。
-- tell（异步）仍 spawn；同步版本不得 spawn/join。
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-52s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-52s %s"):format(desc, tostring(got)))
  end
end

local h = Headless.new(); rt.set_host(h)
local g = rt.load({
  stage_w = 900, stage_h = 562, vars = {}, screens = {}, assets = {}, audios = {},
  actors = {
    { id = "root", name = "R", x = 0, y = 0, styles = { "s1" }, style_index = 1 },
    { id = "far", name = "F", x = 30, y = 40, styles = { "s1" }, style_index = 1 },
  },
}, h)
rt.build_f()
local f = rt.f
local root, far = g:find("root"), g:find("far")

-- 1) 普通内联：DO 内 self=target、同一线程、结束后恢复
local th = { sched = { game = g }, execution_self = root }
local seen
local n0 = #g.sched.threads
f.sync_tell(root, { sprite = "far", DO = function(t2, s2)
  seen = { th = t2, self = s2, exec = th.execution_self }
end }, th)
check("sync_tell 不新建线程", #g.sched.threads, n0)
check("DO 收到的线程是当前线程", seen.th, th)
check("DO 的 self 是目标", seen.self, far)
check("DO 内 execution_self=目标", seen.exec, far)
check("结束后恢复 execution_self", th.execution_self, root)

-- 2) 嵌套：内层恢复外层目标，外层再恢复调用者
local seq = {}
local function who()
  if th.execution_self == far then return "far" end
  if th.execution_self == root then return "root" end
  return "?"
end
f.sync_tell(root, { sprite = "far", DO = function(_, outer)
  seq[#seq + 1] = who()
  f.sync_tell(root, { sprite = "root", DO = function(_, inner)
    seq[#seq + 1] = who()
    check("内层 self=root", inner, root)
  end }, th)
  seq[#seq + 1] = who()
end }, th)
check("嵌套执行序列", table.concat(seq, ","), "far,root,far")
check("嵌套后恢复", th.execution_self, root)

-- 3) DO 内让出（模拟 wait）：让出期间保持目标上下文，恢复后继续，最终恢复
local co = coroutine.create(function()
  f.sync_tell(root, { sprite = "far", DO = function()
    seq[#seq + 1] = "before:" .. tostring(th.execution_self == far)
    coroutine.yield()
    seq[#seq + 1] = "after:" .. tostring(th.execution_self == far)
  end }, th)
  seq[#seq + 1] = "done"
end)
assert(coroutine.resume(co))
check("让出期间保持目标", th.execution_self, far)
assert(coroutine.resume(co))
check("让出恢复后仍为目标", seq[#seq - 1], "after:true")
check("DO 结束后恢复", th.execution_self, root)
check("DO 正常结束", seq[#seq], "done")

-- 4) DO 抛错：线程结束并复位 execution_self
local errs = 0
g.on_error = function() errs = errs + 1 end
rt.start()
local t = g.sched:spawn(root, "manual", {}, function(t2)
  f.sync_tell(t2, { sprite = "far", DO = function() error("boom") end }, t2)
end, {}, root)
rt.step(1 / 60)
check("出错线程已结束", t.done, true)
check("出错后 execution_self 复位", t.execution_self, root)
check("错误被调度器捕获", errs, 1)

-- 5) tell 仍是异步 spawn
local before = #g.sched.threads
f.tell(root, { sprite = "far", DO = function() end },
  { sched = g.sched, execution_self = root })
check("tell 仍 spawn 线程", #g.sched.threads, before + 1)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
