-- 十进制四则：Decimal.js precision=16 / HALF_UP 的本地回归
package.path = "./?.lua;" .. package.path
local D = require("rt.decimal_v2")
local M = require("rt.impl.op_sensing")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else print(("  ok   %-46s %s"):format(desc, tostring(got))) end
end
local function num(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%.17g want=%.17g"):format(desc, got, want))
  else print(("  ok   %-46s %.17g"):format(desc, got)) end
end

num("0.1 + 0.2", D.to_number(D.add(0.1, 0.2)), 0.3)
num("0.3 - 0.2", D.to_number(D.sub(0.3, 0.2)), 0.1)
num("1.1 * 1.1", D.to_number(D.mul(1.1, 1.1)), 1.21)
num("1 / 3", D.to_number(D.div(1, 3)), 1 / 3)
num("2 / 3", D.to_number(D.div(2, 3)), tonumber("0.6666666666666667"))
check("0 / 0 NaN", D.to_number(D.div(0, 0)) ~= D.to_number(D.div(0, 0)), true)
check("1 / 0 Infinity", D.to_number(D.div(1, 0)), math.huge)
check("-1 / 0 -Infinity", D.to_number(D.div(-1, 0)), -math.huge)
check("1e20 - 1", D.to_number(D.sub(1e20, 1)), 1e20)
check("0.000001 + 999999", D.to_number(D.add(0.000001, 999999)), 999999.000001)

check("math add 0.1+0.2 (native)", M.math_arithmetic(nil, { A = 0.1, B = 0.2, type = "add" }), 0.1 + 0.2)
check("math divide 0/0 NaN", M.math_arithmetic(nil, { A = 0, B = 0, type = "divide" }) ~=
  M.math_arithmetic(nil, { A = 0, B = 0, type = "divide" }), true)
check("math string add", M.math_arithmetic(nil, { A = "a", B = "b", type = "add" }), "ab")

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
