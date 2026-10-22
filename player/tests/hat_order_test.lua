-- B-order：同帧 spawn 顺序 = 作品 JSON 的实体/hat 定义次序。
-- 夹具：actorsDict 先 A(id=zzz-actor) 后 B(id=aaa-actor)，UUID 排序会得到 B→A。
-- A 两个 hat（先 first 后 second），B 一个 hat；跨角色断言 A→B，同角色断言 first→second。
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

local work = Helper.compiled("hat_order")
local host = Headless.new()
rt.set_host(host)
local game = rt.load(work, host)

local order = {}
local orig = game.sched.spawn
game.sched.spawn = function(self, owner, hat, args, body, event, reg)
  if hat == "on_running_group_activated" then
    local li = debug.getinfo(body, "S")
    order[#order + 1] = {
      name = owner and owner.name or "?",
      line = li and li.linedefined or 0,
    }
  end
  return orig(self, owner, hat, args, body, event, reg)
end

rt.start()
check("同帧 spawn 数", #order, 3)
check("跨角色：先 A", order[1] and order[1].name, "A")
check("同角色：A 的第二个 hat", order[2] and order[2].name, "A")
check("跨角色：后 B", order[3] and order[3].name, "B")
check("同角色：hat 定义次序 first→second",
  (order[1] and order[2] and order[1].line < order[2].line), true)

for _ = 1, 2 do rt.step(1 / 60) end
check("A first hat 已执行", game.vars["v_first"], 1)
check("A second hat 已执行", game.vars["v_second"], 1)
check("B hat 已执行", game.vars["v_b"], 1)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
