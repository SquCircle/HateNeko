-- G6-5 验收：per-thread ask 锁 + FIFO 队列 + callback 写 choice/index。
-- 三个线程：A 先 ask、B 后 ask、B 上的 spinner 每帧 +1。
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")
local ui = require("rt.impl.ui")

local M = {
  stage_w = 100, stage_h = 100, cur_scene = "",
  screens = {},
  vars = {
    { id = "v_a_choice", name = "a_choice", value = "" },
    { id = "v_a_index",  name = "a_index",  value = -1 },
    { id = "v_a_done",   name = "a_done",   value = 0 },
    { id = "v_b_choice", name = "b_choice", value = "" },
    { id = "v_b_index",  name = "b_index",  value = -1 },
    { id = "v_b_done",   name = "b_done",   value = 0 },
    { id = "v_spin",     name = "spin",     value = 0 },
  },
  actors = {
    { id = "a1", name = "A", styles = {} },
    { id = "b1", name = "B", styles = {} },
  },
  assets = {}, audios = {},
}

local function ask_hat(prefix)
  return function(th, self)
    local f = rt.f
    f.ask_and_choose(self, {
      question = prefix == "a" and "Q1" or "Q2",
      CHOICE0 = "A", CHOICE1 = "B", CHOICE2 = "C", CHOICE3 = "D",
    }, th)
    f.variables_set(self, {
      variable = "v_" .. prefix .. "_choice",
      value = f.get_choice_and_index(self, { type = "content" }, th),
    }, th)
    f.variables_set(self, {
      variable = "v_" .. prefix .. "_index",
      value = f.get_choice_and_index(self, { type = "index" }, th),
    }, th)
    f.variables_set(self, { variable = "v_" .. prefix .. "_done", value = 1 }, th)
  end
end

function M.register(rt2, game, ents)
  rt2.on(ents.a1, "on_running_group_activated", {}, ask_hat("a"))
  rt2.on(ents.b1, "on_running_group_activated", {}, ask_hat("b"))
  rt2.on(ents.b1, "on_running_group_activated", {}, function(th, self)
    while true do
      rt2.f.change_variables(self, { variable = "v_spin", value = 1, method = "increase" }, th)
      if th:iter_n() then break end
    end
  end)
end

local host = Headless.new()
rt.set_host(host)
local game = rt.load(M, host)
rt.start()
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
local function step(n) for _ = 1, (n or 1) do rt.step(1 / 60) end end

step(1)
local d1 = ui.current_dialog(game)
local spin1 = game.vars["v_spin"]
check("frame1 thr（A/B 锁住 + spinner）", #game.sched.threads, 3)
check("frame1 current owner", d1 and d1.owner and d1.owner.name, "A")
check("frame1 spinner 在跑", spin1 > 0, true)

local ok1 = ui.submit_choice("B")
check("submit 第一个成功", ok1, true)
step(2)
check("submit1 后 thr 递减到 2", #game.sched.threads, 2)
check("A choice", game.vars["v_a_choice"], "B")
check("A index 是数字 2", game.vars["v_a_index"], 2)
check("A index 类型", type(game.vars["v_a_index"]), "number")
check("A done", game.vars["v_a_done"], 1)
local d2 = ui.current_dialog(game)
check("queue 前进到 B", d2 and d2.owner and d2.owner.name, "B")
check("spinner 持续在跑", game.vars["v_spin"] > spin1, true)

local ok2 = ui.submit_choice("A")
check("submit 第二个成功", ok2, true)
step(2)
check("submit2 后 thr 递减到 1", #game.sched.threads, 1)
check("B choice", game.vars["v_b_choice"], "A")
check("B index 是数字 1", game.vars["v_b_index"], 1)
check("B done", game.vars["v_b_done"], 1)
check("队列已清空", ui.current_dialog(game), nil)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
