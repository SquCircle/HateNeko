-- 事件测试（第二批）：角色被点击 / 按键事件与轮询 / 当…条件 / 克隆与克隆体启动
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
    print(("  FAIL %-40s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-40s %s"):format(desc, tostring(got)))
  end
end

local work = Helper.compiled("events2")

local host = Headless.new()
rt.set_host(host)
local game = rt.load(work, host)
rt.start()
local V = game.vars
local function step(n) for _ = 1, (n or 1) do rt.step(1 / 60) end end

local n_before = #game.entities   -- 基线要在克隆发生前取
step(2)
check("初始：点击未触发", V["v_tap"], 0)

-- ① 角色被点击
local tapper = nil
for _, e in ipairs(game.entities) do if e.name == "被点角色" then tapper = e end end
host:click(0, 0, tapper and tapper.id or nil)
step(2)
check("「角色被点击」触发", V["v_tap"], 1)

-- ② 按键事件（按下 a=65）
host:press_key("65")
step(2)
check("「按下按键」事件触发", V["v_key"], 1)

-- ③ 按键轮询（等待直到 按键按下 → 键已按下）
step(3)
check("「按键按下」轮询成立", V["v_poll"], 1)

-- ④ 当…条件（把条件变量置 1）
V["v_x"] = 1
step(3)
check("「当 条件」触发", V["v_when"], 1)

-- ⑤ 克隆：克隆体启动时的事件（n_before 已在开头取好）
step(3)
check("克隆体已创建", #game.entities > n_before, true)
check("「作为克隆体启动」触发", V["v_clone"], 1)

-- ⑥ 碰到角色时（两个角色重合 → 边沿触发）
step(3)
check("「碰到角色时」触发", V["v_bump"], 1)

-- ⑦ 滑动事件
host:swipe("left")
step(2)
check("「滑动」事件触发", V["v_swipe"], 1)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
