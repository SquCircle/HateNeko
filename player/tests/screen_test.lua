-- 切屏机制测试（黄金用例：tests/fixtures/switch.bcmkn）
--
-- 作品结构：两屏（700824a5 只有角色"编程猫"；7208001f 是空场景，脚本挂在**屏幕实体**上）
--   屏幕 7208001f：当开始运行 → i=0; 永远循环{旋转}
--                  当自己被点击(start_on_click) → i=0; 永远循环{i+1}
--                  当屏幕被点击(--screen) → 切换屏幕 700824a5
--   角色 编程猫：   当被点击(--screen) → 切换屏幕 7208001f
--
-- 要验证的两条机制：
--   ① 事件侦测**只在当前 scene 判定**：不在当前 scene 的事件，条件满足也不启动
--   ② 切屏只终止「当开始运行」线程；**事件启动的线程继续跑**
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local Helper = require("tests.helper")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

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

local work = Helper.compiled("switch")
local host = Headless.new()
rt.set_host(host)
local game = rt.load(work, host)
host:preload(game)
rt.start()

local SCENE1 = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
local SCENE2 = "7208001f-85ff-4135-a221-780136a774de"
local function step(n) for _ = 1, (n or 1) do rt.step(1 / 60) end end
local function var_i()
  for k, v in pairs(game.vars) do if game:describe(k) == "i" then return v end end
  return 0
end
local function threads_of(hat)
  local n = 0
  for _, th in ipairs(game.sched.threads) do
    if not th.done and th.hat == hat then n = n + 1 end
  end
  return n
end

step(5)
check("开局：在第一屏", game.cur_screen, SCENE1)
check("开局：第二屏的绿旗没有跑（绿旗带 group_id，只在进入该屏幕时启动）", threads_of("on_running_group_activated"), 0)
-- 官方 HAT_BLOCKS：start_on_click 是**启动块**（不带 group_id）→ 作品开始播放时就启动、且跨切屏存活
check("开局：start_on_click 已在跑（播放时启动）", threads_of("start_on_click") + threads_of("start_on_click_2") >= 1, true)

-- 第一次点击：第一屏的角色（编程猫）在 scene 内 → 切到第二屏
host:click(game.stage_w / 2, game.stage_h / 2, nil)
step(5)
check("第一次点击：切到第二屏", game.cur_screen, SCENE2)
check("第二屏绿旗启动（旋转循环）", threads_of("on_running_group_activated") >= 1, true)

-- 第二次点击：这次第二屏的事件在 scene 内 → 启动计数循环，同时切回第一屏
host:click(game.stage_w / 2, game.stage_h / 2, nil)
step(5)
check("第二次点击：start_on_click 线程一直在（跨切屏存活）", threads_of("start_on_click") + threads_of("start_on_click_2") >= 1, true)

-- 关键：切屏后事件线程继续跑（绿旗线程换了，计数不停）
local a = var_i()
step(30)
local b = var_i()
check("切屏后计数继续增长（事件线程存活）", b > a, true)
check("增长幅度合理", b - a >= 10, true)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
