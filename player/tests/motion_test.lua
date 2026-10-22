-- 运动域测试：移到 / 设置坐标 / 滑行(补间) / 面向 / 前进
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local Helper = require("tests.helper")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local fails, checks = 0, 0
local function check(desc, got, want, tol)
  checks = checks + 1
  local ok
  if type(got) == "number" and type(want) == "number" then
    ok = math.abs(got - want) <= (tol or 0.51)
  else
    ok = got == want
  end
  if not ok then
    fails = fails + 1
    print(("  FAIL %-36s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-36s %s"):format(desc, tostring(got)))
  end
end

local work = Helper.compiled("motion")

local host = Headless.new()
rt.set_host(host)
local game = rt.load(work, host)
rt.start()
local V = game.vars
local function step(n) for _ = 1, (n or 1) do rt.step(1 / 60) end end

step(2)
check("移到(100,50)：x", V["v_x1"], 100)
check("移到(100,50)：y", V["v_y1"], 50)
check("设置x为200", V["v_x2"], 200)
check("滑行到是阻塞的（调用返回时已到位）", V["v_glide_mid"], 0, 1.5)

-- 滑行 0.2 秒 + 之后 wait 0.3 秒
step(40)
check("滑行结束后 x≈0", V["v_glide_end"], 0, 1.5)
check("面向角度（手机传感器离线占位）", V["v_dir"], 0)
check("前进100 后 x≈0（向上走）", V["v_fx"], 0, 1.5)
check("前进100 后 y≈100", V["v_fy"], 100, 1.5)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
