-- 控制类积木 + control 作品 headless
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local hit = require("rt.hit")

local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/control.lua"))(), host)
-- 无图形宿主没有 alpha；为边缘反弹提供全不透明像素。
host.style_pixels = function(self, id, game)
  local w, h = self:style_size(id, game)
  if not w then return nil end
  return { w = w, h = h, alpha = string.rep("\255", w * h) }
end
rt.start()

local cat, cat1
for _, e in ipairs(g.entities) do
  if e.name == "编程猫" then cat = e
  elseif e.name == "编程猫1" then cat1 = e end
end

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
local function near(desc, got, want, eps)
  checks = checks + 1
  if math.abs((got or 0) - want) > (eps or 0.01) then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want≈%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-46s %s"):format(desc, tostring(got)))
  end
end
local function contains(t, sub)
  for _, v in ipairs(t or {}) do if tostring(v):find(sub, 1, true) then return true end end
  return false
end

check("舞台宽", g.stage_w, 900)
check("编程猫存在", cat ~= nil, true)
check("编程猫1存在", cat1 ~= nil, true)
check("无 f.break 运行时", rawget(rt.f, "break"), nil)
check("control 脚本无 f.break", io.open("works/control.lua", "rb"):read("*a"):find('f["break"]', 1, true), nil)

-- 重复/遍历/重复直到/if/break/wait/wait_until/warp/tell/sync_tell
for i = 1, 1500 do
  if i >= 500 then host:click(450, 281) end
  rt.step(1 / 60)
end

near("最终 x", cat1.x, 200, 0.01)
near("最终 y", cat1.y, 200, 0.01)
near("最终 dir", cat1.dir, 0, 0.01)
check("console_log 已执行", contains(host.logs, "已执行"), true)
check("编程猫仍在舞台内 x", math.abs(cat.x) <= 450, true)
check("编程猫仍在舞台内 y", math.abs(cat.y) <= 281, true)
check("活动线程数", #g.sched.threads, 1)

-- traverse 循环变量已被清理（无残留参数）
check("参数栈已清空", #g.sched.threads[1].params, 0)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
