-- stop 积木作用域语义
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()

local fail = 0
local function check(name, got, want)
  if got ~= want then
    fail = fail + 1
    print(("FAIL %s got=%s want=%s"):format(name, tostring(got), tostring(want)))
  else
    print("ok\t" .. name)
  end
end

local A, B = { name = "A", vars = {} }, { name = "B", vars = {} }
local function spawn(owner, body)
  return g.sched:spawn(owner, "test", {}, body)
end

-- scope 2: stop other scripts of same owner, current stays alive; other owner unaffected
local t1, t2, t3
local after2 = false
t1 = spawn(A, function(th, self)
  rt.f.stop(self, { scope = "2" }, th)
  after2 = true
  th:block(10000000)
end)
t2 = spawn(A, function(th) th:block(10000000) end)
t3 = spawn(B, function(th) th:block(10000000) end)
rt.step(1/60)
check("scope2 current alive", t1.done, false)
check("scope2 continued", after2, true)
check("scope2 same-owner stopped", t2.done, true)
check("scope2 same-owner stopped flag", t2.stopped, true)
check("scope2 other-owner alive", t3.done, false)

-- scope 3: stop other owners, current and same-owner stay alive
local t4, t5, t6
local after3 = false
t4 = spawn(A, function(th, self)
  rt.f.stop(self, { scope = "3" }, th)
  after3 = true
  th:block(10000000)
end)
t5 = spawn(A, function(th) th:block(10000000) end)
t6 = spawn(B, function(th) th:block(10000000) end)
rt.step(1/60)
check("scope3 current alive", t4.done, false)
check("scope3 continued", after3, true)
check("scope3 same-owner alive", t5.done, false)
check("scope3 other-owner stopped", t6.done, true)
check("scope3 other-owner stopped flag", t6.stopped, true)

print(("stop scope tests: %s"):format(fail == 0 and "ok" or ("FAIL " .. fail)))
if fail > 0 then os.exit(1) end
