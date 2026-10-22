-- 包 N：self_move_to 对非有限坐标的 guard（官方 moveTargetTo byte 1749237/1750330）
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")
local ML = require("rt.impl.motion_looks")

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

-- 纯函数：NaN/Inf 不写；部分非法只写合法轴
local e = { x = 10, y = 20 }
ML.self_move_to(e, { x = 0 / 0, y = 0 / 0 })
check("NaN/NaN 不写 x", e.x, 10)
check("NaN/NaN 不写 y", e.y, 20)

ML.self_move_to(e, { x = 0 / 0, y = 30 })
check("NaN x 保留", e.x, 10)
check("合法 y 写入", e.y, 30)

ML.self_move_to(e, { x = 40, y = math.huge })
check("合法 x 写入", e.x, 40)
check("Inf y 保留", e.y, 30)

-- 包 N.2：set_position_x/y 与 change_coordinate 也必须拒绝非有限值
ML.self_set_position_x(e, { value = 0 / 0 })
check("set_position_x NaN 保留", e.x, 40)
ML.self_set_position_y(e, { value = math.huge })
check("set_position_y Inf 保留", e.y, 30)
ML.self_set_position_x(e, { value = 55 })
check("set_position_x 合法写入", e.x, 55)
ML.self_change_coordinate_x(e, { value = math.huge, increase = "increase" })
check("change_coordinate_x Inf 忽略", e.x, 55)
ML.self_change_coordinate_y(e, { value = 0 / 0, increase = "increase" })
check("change_coordinate_y NaN 忽略", e.y, 30)
ML.self_change_coordinate_y(e, { value = 5, increase = "increase" })
check("change_coordinate_y 合法写入", e.y, 35)

-- get_mouse_info 的官方 NaN 语义不能被包 N 改掉
local th = { sched = { game = { host = { mouse_is_down = false } } } }
local OS = require("rt.impl.op_sensing")
local mv = OS.get_mouse_info({}, { type = "x" }, th)
check("get_mouse_info 仍返回 NaN", mv ~= mv, true)

-- 真实 now：f207/f209 后三实体不得被 NaN 污染
local host = Headless.new()
rt.set_host(host)
local work = assert(loadfile("works/now.lua"))()
local g = rt.load(work, host)
rt.start()
for _ = 1, 210 do rt.step(1 / 60) end
local names = { ["总PP"] = true, ["星"] = true, ["支持者内容"] = true }
local seen = 0
for _, ent in ipairs(g.entities) do
  if names[ent.name] then
    seen = seen + 1
    check(ent.name .. " x 有限", ent.x == ent.x and ent.x ~= math.huge and ent.x ~= -math.huge, true)
    check(ent.name .. " y 有限", ent.y == ent.y and ent.y ~= math.huge and ent.y ~= -math.huge, true)
  end
end
check("三个实体都在", seen, 3)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
