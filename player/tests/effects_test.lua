-- 三滤镜测试作品（effects.bcmkn）headless 状态测试
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/effects.lua"))(), host)
rt.start()
local e
for _, v in ipairs(g.entities) do if v.name == "新角色" then e = v end end

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-46s %s"):format(desc, tostring(got)))
  end
end
local function step(n) for _ = 1, n do rt.step(1 / 60) end end

check("角色存在", e ~= nil, true)
step(90)
check("阶段1 displacement", e.effects.ripple, 20)
check("阶段1 无 twist", e.effects.distortion, 0)
check("阶段1 无 pixelate", e.effects.pixelate, 0)
step(60)
check("阶段2 twist", e.effects.distortion, 20)
step(120)
check("阶段3 pixelate", e.effects.pixelate, 8)
step(600)
check("最终 displacement", e.effects.ripple, 10)
check("最终 twist", e.effects.distortion, 10)
check("最终 pixelate", e.effects.pixelate, 8)
check("最终线程结束", #g.sched.threads, 0)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
