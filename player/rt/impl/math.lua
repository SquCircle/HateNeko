-- 运算（数字/逻辑/取模/三角/公式）（来自 op_sensing.lua）


local V = require("rt.values")
local M = {}


function M.math_number(self, args)
  return V.num(args.NUM or args.value)
end

M.math_number_with_dial = M.math_number

function M.logic_empty(self, args)
  return false
end

local function js_add(a, b)
  if type(a) == "string" or type(b) == "string" then
    return V.js_str(a) .. V.js_str(b)
  end
  return V.js_num(a) + V.js_num(b)
end

local function num_sub(a, b) return V.js_num(a) - V.js_num(b) end

local function num_mul(a, b) return V.js_num(a) * V.js_num(b) end

local function num_div(a, b)
  local x, y = V.js_num(a), V.js_num(b)
  if x == 0 and y == 0 then return 0 / 0 end
  return x / y
end

local ARITH = {
  ["add"] = js_add, ["+"] = js_add, ADD = js_add,
  ["minus"] = num_sub, ["-"] = num_sub, MINUS = num_sub,
  ["multiply"] = num_mul, ["*"] = num_mul, MULTIPLY = num_mul,
  ["divide"] = num_div, ["/"] = num_div, DIVIDE = num_div,
  ["power"] = function(a, b) return V.js_num(a) ^ V.js_num(b) end,
  ["^"] = function(a, b) return V.js_num(a) ^ V.js_num(b) end,
  POWER = function(a, b) return V.js_num(a) ^ V.js_num(b) end,
}

function M.math_arithmetic(self, args)
  local a, b = args.A, args.B
  if a == nil then a = args.a end
  if b == nil then b = args.b end
  -- 数值快路径（作品里绝大多数调用都是 number + number，省掉字符串 tostring/表查找）
  if type(a) == "number" and type(b) == "number" then
    local t = args.type or args.operator
    if t == "add" then return a + b end
    if t == "minus" then return a - b end
    if t == "multiply" then return a * b end
    if t == "divide" then return a / b end
  end
  local f = ARITH[tostring(args.type or args.operator or args.OP or "add")]
  if not f then return 0 end
  return f(a, b)
end

M.calculate = function(self, args, th)
  -- 官方：calculate → lex(input).toPostfix().postfixEval()（见 rt/impl/formula.lua）
  return require("rt.impl.formula").evaluate(args.input)
end

function M.math_arithmetic_power(self, args)
  return V.num(args.A or args.a) ^ V.num(args.B or args.b)
end

function M.random_num(self, args)
  -- 官方 randomNum（main:1 byte 1613664）：A/B 先 Math.round，再闭区间采样。
  local a = math.floor(V.num(args.A or args.a) + 0.5)
  local b = math.floor(V.num(args.B or args.b) + 0.5)
  if a > b then return a end
  local rnd = (love and love.math and love.math.random) or math.random
  return math.floor(rnd() * (b - a + 1)) + a
end

M.random = M.random_num

-- 官方实现：EQ → 宽松相等；LT/LTE/GT/GTE → JS 原生比较（V.js_*）

local COMPARE_JS = {
  ["LT"] = V.js_lt,
  ["<"] = V.js_lt,
  ["LTE"] = V.js_le,
  ["<="] = V.js_le,
  ["GT"] = V.js_gt,
  [">"] = V.js_gt,
  ["GTE"] = V.js_ge,
  [">="] = V.js_ge,
}

function M.logic_compare(self, args)
  local op = args.OP or args.op
  if op == nil then op = "EQ" end
  local a, b = args.A, args.B
  if a == nil then a = args.a end
  b = args.B
  if b == nil then b = args.b end
  -- 数值快路径：k3t V2 的 3D 循环里绝大多数比较都是 number/number
  if type(a) == "number" and type(b) == "number" then
    if op == "LT" or op == "<" then return a < b end
    if op == "LTE" or op == "<=" then return a <= b end
    if op == "GT" or op == ">" then return a > b end
    if op == "GTE" or op == ">=" then return a >= b end
  end
  if op == "EQ" or op == "===" then return V.eq(a, b) end
  if op == "NEQ" or op == "!==" then return not V.eq(a, b) end
  local f = COMPARE_JS[op]
  if not f then return false end
  return f(a, b) and true or false
end

function M.logic_operation(self, args)
  -- 官方 logicOperation @1614282：`"and"===t ? A&&B : A||B`（返回操作数，不是布尔）
  local t = tostring(args.type or args.operator or "and")
  local a, b = args.A, args.B
  if a == nil then a = args.a end
  if b == nil then b = args.b end
  if t == "and" then
    if V.js_boolean(a) then return b end
    return a
  end
  if V.js_boolean(a) then return a end
  return b
end

function M.logic_boolean(self, args)
  -- 官方 logicBoolean @1614437：`"true" === e.BOOL`（严格）
  local v = args.BOOL
  if v == nil then v = args.value end
  return v == "true"
end

function M.logic_negate(self, args)
  -- 官方 logicNegate @1614379：`!e.logic`（JS 真值："0" 为真）
  local v = args.BOOL
  if v == nil then v = args.OPERAND end
  if v == nil then v = args.logic end
  if v == nil then v = args.value end
  return not V.js_boolean(v)
end

function M.math_round(self, args)
  local n = V.num(args.num or args.value)
  local t = args.type or "round"
  if t == "round_up" then return math.ceil(n) end
  if t == "round_down" then return math.floor(n) end
  return math.floor(n + 0.5)
end

function M.math_modulo(self, args)
  -- 官方 mathModulo @1615652：`A % B`（JS 取模：符号随被除数；除零 = NaN）
  local a, b = V.js_number(args.A or args.a), V.js_number(args.B or args.b)
  if b == 0 then return 0 / 0 end
  return math.fmod(a, b)
end

function M.divisible_by(self, args)
  local a, b = V.num(args.A or args.a), V.num(args.B or args.b)
  if b == 0 then return false end
  return a % b == 0
end

-- 「数值判断」：type 是**大写枚举**（EVEN/ODD/PRIME/COMPOSITE/WHOLE/POSITIVE/NEGATIVE），
-- 官方实现是 `v[e.PROPERTY](e)`。曾经按小写比较且没实现 COMPOSITE →
-- now 里"克隆体编号是合数才下落"恒假，雪花永不落底、克隆体无限堆积。

local function is_prime(n)
  if n < 2 or n ~= math.floor(n) then return false end
  if n < 4 then return true end
  if n % 2 == 0 then return false end
  local i = 3
  while i * i <= n do
    if n % i == 0 then return false end
    i = i + 2
  end
  return true
end

function M.math_number_property(self, args)
  local n = V.num(args.num or args.NUMBER or args.value)
  local t = tostring(args.type or args.PROPERTY or args.property or "EVEN"):upper()
  if t == "EVEN" then return n % 2 == 0 end
  if t == "ODD" then return math.abs(n % 2) == 1 end
  if t == "PRIME" then return is_prime(n) end
  if t == "COMPOSITE" then return n > 1 and n == math.floor(n) and not is_prime(n) end
  if t == "WHOLE" or t == "INTEGER" then return n == math.floor(n) end
  if t == "POSITIVE" then return n > 0 end
  if t == "NEGATIVE" then return n < 0 end
  return false
end

-- 官方 math_trig：三角函数按角度、反三角返回角度，且**保留 2 位小数**（g(x, 2)）

local function round2(x)
  return math.floor(x * 100 + 0.5) / 100
end

local TRIG = {
  sin = function(n) return round2(math.sin(math.rad(n))) end,
  cos = function(n) return round2(math.cos(math.rad(n))) end,
  tan = function(n) return round2(math.tan(math.rad(n))) end,
  asin = function(n) return round2(math.deg(math.asin(n))) end,
  acos = function(n) return round2(math.deg(math.acos(n))) end,
  atan = function(n) return round2(math.deg(math.atan(n))) end,
}

function M.math_trig(self, args)
  local key = tostring(args.type or args.OP or "sin"):lower()
  local f = TRIG[key] or TRIG.sin
  return f(V.num(args.num or args.value))
end

-- 官方 math_trig_rad（弧度制）：Math.sin/cos/tan/asin/acos/atan，不做角度换算/舍入。

local TRIG_RAD = {
  sin = math.sin, cos = math.cos, tan = math.tan,
  asin = math.asin, acos = math.acos, atan = math.atan,
}

function M.math_trig_rad(self, args)
  local key = tostring(args.type or args.OP or "sin"):lower()
  local f = TRIG_RAD[key]
  if not f then return 0 / 0 end
  return f(V.num(args.num or args.value))
end

-- 官方 math_single/math_function 的 ops 表：ROOT(算术平方根)/ABS/NEG/LN/LOG10/EXP/POW10
-- 作品里下拉存的是数字索引：0=算术平方根 1=绝对值 2=- 3=ln 4=log10 5=e^ 6=10^

local FN = {
  ["0"] = math.sqrt, ["1"] = math.abs, ["2"] = function(n) return -n end,
  ["3"] = math.log, ["4"] = math.log10, ["5"] = math.exp, ["6"] = function(n) return 10 ^ n end,
  sqrt = math.sqrt, ROOT = math.sqrt, root = math.sqrt,
  abs = math.abs, ABS = math.abs,
  neg = function(n) return -n end, NEG = function(n) return -n end,
  ln = math.log, LN = math.log,
  log10 = math.log10, LOG10 = math.log10,
  exp = math.exp, EXP = math.exp,
  pow10 = function(n) return 10 ^ n end, POW10 = function(n) return 10 ^ n end,
}

function M.math_function(self, args)
  local key = tostring(args.type or args.OP or "1")
  local f = FN[key] or FN[key:lower()] or math.abs
  local n = args.num
  if n == nil then n = args.NUM end
  if n == nil then n = args.value end
  return f(V.num(n))
end

---------------------------------------------------------------- 文本
-- 连接字符串：按 mutation 变参，输入键可能是 ARG0/VAR0/ADD0/TEXT0…（编号顺序拼接）

M.math_arc_trig = function(self, args)
  -- 官方 mathArcTrig @1617743：按 type 分 asin/acos/atan（角度制）
  local n = V.js_number(args.num or args.value)
  local t = tostring(args.type or "asin"):lower()
  if t == "acos" then return math.deg(math.acos(n)) end
  if t == "atan" then return math.deg(math.atan(n)) end
  return math.deg(math.asin(n))
end

---------------------------------------------------------------- 侦测
-- 「判断角色碰撞」/「碰到」：**两个**目标槽（sprite=主体1，sprite1=主体2）。
-- 官方两个下拉都支持特殊值：--self / --screen / --mouse / --edge(-top/bottom/left/right) / camp_* / 角色 UUID。
-- 曾经只读 args.sprite 且把 --self 当成"鼠标点自己" → 碰到"下边缘"永远为假，
-- 于是 now 里的雪花/通知克隆体永远不退出循环（90 秒攒下 281 个克隆、494 条线程，越跑越卡）。

return M
