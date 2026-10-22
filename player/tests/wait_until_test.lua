-- G1-1/G1-2/G9-1 验收：wait_until 条件假→阻塞、条件真→立即继续；reset 后 timer 继续跑。
package.path = "./?.lua;" .. package.path

local Helper = require("tests.helper")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-44s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-44s %s"):format(desc, tostring(got)))
  end
end

local work = Helper.compiled("wait_until")
local host = Headless.new()
rt.set_host(host)
local game = rt.load(work, host)
rt.start()

local function step(n) for _ = 1, (n or 1) do rt.step(1 / 60) end end

step(1)
check("frame1 恒真条件立即通过", game.vars["v_immediate"], 1)
check("frame1 v_after 仍为 0（条件假，阻塞中）", game.vars["v_after"], 0)
check("frame1 v_ready 仍为 0（wait 0.02 阻塞）", game.vars["v_ready"], 0)
check("frame1 v_timer 仍为 0（reset 后 timer 尚未 >0）", game.vars["v_timer"], 0)

step(60)
check("条件变真后 v_after=1", game.vars["v_after"], 1)
check("3 次 wait 后 v_ready=3", game.vars["v_ready"], 3)
check("reset 后 timer 继续跑 → v_timer=1", game.vars["v_timer"], 1)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
