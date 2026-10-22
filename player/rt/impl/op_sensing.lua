-- 运算 / 文本 / 侦测 / 计时器 / 舞台 原语
-- 统一签名：function(self, args, th)（报告类返回一个值）
local V = require("rt.values")

local M = {}

local function game(th) return th.sched.game end

---------------------------------------------------------------- 字面量（shadow 常量）
function M.math_number(self, args)
  return V.num(args.NUM or args.value)
end
M.math_number_with_dial = M.math_number

function M.text(self, args)
  return V.str(args.TEXT or args.text)
end
M.shadow_text = M.text

function M.logic_empty(self, args)
  return false
end

function M.default_value(self, args)
  return args.VALUE or args.value or 0
end

---------------------------------------------------------------- 运算
-- 本任务要求：四则使用 Lua 原生；保留 JS 字符串 add/NaN/Infinity 语义。
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
local function join_any(args)
  local items = args.items
  if type(items) == "table" then
    local out = {}
    for i = 1, #items do out[i] = V.str(items[i]) end
    return table.concat(out)
  end
  -- 收集所有「前缀+数字」形态的键，按数字排序
  local numbered = {}
  local prefix
  for k in pairs(args) do
    local p, i = tostring(k):match("^(%a+)(%d+)$")
    if p and i then
      numbered[#numbered + 1] = { k = k, i = tonumber(i), p = p }
      prefix = p
    end
  end
  if #numbered > 0 then
    table.sort(numbered, function(a, b) return a.i < b.i end)
    local out = {}
    for i = 1, #numbered do out[i] = V.str(args[numbered[i].k]) end
    return table.concat(out)
  end
  return V.str(args.A or args.a) .. V.str(args.B or args.b)
end

function M.text_join(self, args)
  return join_any(args)
end

-- 官方 text_split：先 toString，split 后**把数字片段转成数值**（"0"→0，"a"→"a"）
function M.text_split(self, args)
  local text = args.TEXT_TO_SPLIT
  if text == nil then text = args.text end
  text = V.str(text)
  local sep = V.str(args.SPLIT_TEXT or args.sep)
  local raw = {}
  if sep == "" then
    for i = 1, #text do raw[i] = text:sub(i, i) end
  else
    local pos = 1
    while true do
      local s, e = text:find(sep, pos, true)
      if not s then
        raw[#raw + 1] = text:sub(pos)
        break
      end
      raw[#raw + 1] = text:sub(pos, s - 1)
      pos = e + 1
    end
  end
  local out = {}
  for i = 1, #raw do
    local chunk = raw[i]
    if chunk ~= "" then
      local n = tonumber(chunk)
      out[i] = n ~= nil and n or chunk
    else
      out[i] = chunk
    end
  end
  return out
end

function M.text_contain(self, args)
  local text = V.str(args.text or args.A or args.a)
  local sub = V.str(args.substring or args.B or args.b)
  return text:find(sub, 1, true) ~= nil
end

function M.text_select(self, args)
  -- 官方 textSelect @1618671：
  --   a = Number.isNaN(text) ? "NaN" : text?.toString()
  --   o = round(start_index)；无 end_index → a[o-1]（0 基）；否则
  --   s = round(end_index)-1；o<=s ? a.substring(o-1,s+1) : reverse(a.substring(s,o))
  -- JS 的索引/长度都是 UTF-16 码元（中文 1、emoji 2），不能按 Lua 字节。
  local raw = args.text
  if raw == nil then raw = args.A end
  local a
  if V.js_number_is_nan(raw) then
    a = "NaN"
  elseif raw == nil then
    a = nil
  else
    a = V.js_str(raw)
  end
  local start = V.js_round(args.start_index)
  local o = start -- 与官方同名变量
  if args.end_index == nil then
    if a == nil then return "" end
    local ch = V.utf16_char_at0(a, o - 1)
    if ch == nil then return "" end
    return ch
  end
  local s = V.js_round(args.end_index) - 1
  if a == nil then return "" end
  if o <= s then
    return V.utf16_substring0(a, o - 1, s + 1)
  end
  return V.utf16_reverse(V.utf16_substring0(a, s, o))
end

function M.text_length(self, args)
  -- 官方 textLength @1618983：toString().length（UTF-16 码元）
  local v = args.text
  if v == nil then v = args.A end
  if v == nil then return 0 end
  return V.utf16_len(v)
end

function M.convert_type(self, args)
  -- 官方 convertType @1619126：
  --   number：Number.isNaN(s) 或 "NaN" → Number(s)；boolean → String(s)；Number(s) 为 NaN → String(s)；
  --           否则 Number(s)
  --   string：String(s)    boolean：Boolean(s)
  local t = tostring(args.type or "string")
  local v = args.text
  if v == nil then v = args.value end
  if t == "number" then
    if v == "NaN" or V.js_number_is_nan(v) then return V.js_number(v) end
    if type(v) == "boolean" then return V.js_str(v) end
    local n = V.js_number(v)
    if V.js_number_is_nan(n) then return V.js_str(v) end
    return n
  elseif t == "boolean" then
    return V.js_boolean(v)
  elseif t == "string" then
    return V.js_str(v)
  end
  return nil
end

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
local EDGE_NAMES = {
  ["0"] = "edge", ["edge"] = "edge", ["--edge"] = "edge",
  ["1"] = "left", ["edge_left"] = "left", ["--edge_left"] = "left",
  ["2"] = "top", ["edge_top"] = "top", ["--edge_top"] = "top",
  ["3"] = "bottom", ["edge_bottom"] = "bottom", ["--edge_bottom"] = "bottom",
  ["4"] = "right", ["edge_right"] = "right", ["--edge_right"] = "right",
}

local function edge_name(v)
  local k = tostring(v or ""):lower()
  return EDGE_NAMES[k] or EDGE_NAMES[tostring(v or "")]
end

-- 把"目标槽"解析成 { kind = entity|point|edge|stage|camp, ... }
local function resolve_target(g, self, v)
  if v == nil or v == "" or v == "--self" then
    return { kind = "entity", e = self }
  end
  local sv = tostring(v)
  if sv == "--mouse" then
    -- 官方 bumpInto @1557532：直接取 getMousePosition() 判 NaN，**不要求按下**。
    -- PC 悬停即算碰到；触屏抬起后官方把位置置 NaN（本运行时 pointer_valid=false）。
    local px, py = g:pointer_world()
    if px ~= px or py ~= py then return { kind = "none" } end
    return { kind = "point", x = px, y = py }
  end
  if sv == "--screen" then return { kind = "stage" } end
  local en = edge_name(sv)
  if en then return { kind = "edge", which = en } end
  if sv:match("^camp_") then return { kind = "camp", camp = sv } end
  local e = g:find(sv)
  if e then return { kind = "entity", e = e } end
  return nil
end

-- 角色包围盒是否**碰到**某条舞台边（"碰到下边缘"= 最低点到达舞台底）
local function touches_edge(e, which, g)
  local x1, y1, x2, y2 = require("rt.hit").aabb(e, g)
  if not x1 then return false end
  local W, H = g.stage_w, g.stage_h
  local L, R, B, T = -W / 2, W / 2, -H / 2, H / 2
  if which == "bottom" then return y1 <= B end
  if which == "top" then return y2 >= T end
  if which == "left" then return x1 <= L end
  if which == "right" then return x2 >= R end
  return x1 <= L or x2 >= R or y1 <= B or y2 >= T
end

-- 角色包围盒是否**整个离开**某条舞台边（"跑出舞台"= 完全越过）
local function past_edge(e, which, g)
  local x1, y1, x2, y2 = require("rt.hit").aabb(e, g)
  if not x1 then return false end
  local W, H = g.stage_w, g.stage_h
  local L, R, B, T = -W / 2, W / 2, -H / 2, H / 2
  if which == "bottom" then return y2 <= B end
  if which == "top" then return y1 >= T end
  if which == "left" then return x2 <= L end
  if which == "right" then return x1 >= R end
  return x2 <= L or x1 >= R or y2 <= B or y1 >= T
end

local function collide(g, self, a, b)
  local Hit = require("rt.hit")
  if a.kind == "none" or b.kind == "none" then return false end
  local function as_entity(t)
    if t.kind == "entity" then return t.e end
  end
  local ea, eb = as_entity(a), as_entity(b)
  -- 两个角色：像素级（官方 check_bumped_other：同 scene + 可见 + 重叠区采样）
  if ea and eb then
    if ea == eb then return touches_edge(ea, "edge", g) end   -- 自己碰自己 → 按"碰边缘"处理
    return Hit.overlaps(ea, eb, g)
  end
  -- 角色 × 鼠标点
  if ea and b.kind == "point" then return Hit.is_touching(ea, b.x, b.y, g) end
  if eb and a.kind == "point" then return Hit.is_touching(eb, a.x, a.y, g) end
  -- 角色 × 边缘 / 舞台
  if ea and b.kind == "edge" then return touches_edge(ea, b.which, g) end
  if eb and a.kind == "edge" then return touches_edge(eb, a.which, g) end
  if ea and b.kind == "stage" then return touches_edge(ea, "edge", g) end
  if eb and a.kind == "stage" then return touches_edge(eb, "edge", g) end
  -- 阵营（camp_*）：该阵营里任一角色碰到另一端
  local function camp_hit(t, other)
    if t.kind ~= "camp" then return nil end
    for _, e in ipairs(g.entities) do
      if not e.deleted and e.kind == "actor" and tostring(e.camp or "") == t.camp
         and not require("rt.hit").invisible(e) then
        local r = collide(g, self, { kind = "entity", e = e }, other)
        if r then return true end
      end
    end
    return false
  end
  local ch = camp_hit(a, b); if ch ~= nil then return ch end
  ch = camp_hit(b, a); if ch ~= nil then return ch end
  return false
end

function M.bump_into(self, args, th)
  local g = game(th)
  -- 快路径（表达式每帧大量重复）：--self × 角色 / 边缘 / 舞台 / 鼠标，不建 target 表
  local a, b = args.sprite, args.sprite1
  local is_camp = type(b) == "string" and b:sub(1, 5) == "camp_"
  if (a == nil or a == "--self" or a == "") and b ~= nil and not is_camp then
    if b == "--screen" then
      return touches_edge(self, "edge", g)
    end
    local en = edge_name(b)
    if en then return touches_edge(self, en, g) end
    if b == "--mouse" then
      local px, py = g:pointer_world()
      if px ~= px or py ~= py then return false end
      return require("rt.hit").is_touching(self, px, py, g)
    end
    if b == "--self" then return touches_edge(self, "edge", g) end
    local t = g:find(b)
    if t then return require("rt.hit").overlaps(self, t, g) end
    return false
  end
  -- 官方形态：{ sprite = 主体1, sprite1 = 主体2 }（碰撞是二元的，"碰到下边缘"就是 sprite1="--edge_bottom"）
  if args.sprite1 ~= nil then
    local a = resolve_target(g, self, args.sprite or "--self")
    local b = resolve_target(g, self, args.sprite1)
    if not a or not b then return false end
    return collide(g, self, a, b)
  end
  -- 单槽老形态（旧编译器/测试用）：
  --   sprite = "--self"  → 指针是否压在"我"身上
  --   sprite = 其它      → "我"是否碰到它
  if args.sprite == nil or tostring(args.sprite) == "--self" then
    local px, py = g:pointer_world()
    return require("rt.hit").is_touching(self, px, py, g)
  end
  local b = resolve_target(g, self, args.sprite)
  if not b then return false end
  return collide(g, self, { kind = "entity", e = self }, b)
end

function M.bump_into_color(self, args, th)
  local g = game(th)
  local target = self
  local spr = args.sprite or "--self"
  if spr ~= "--self" and g.find then target = g:find(spr) or self end
  local color = args.color or args.COLOR or "#000000"
  if g.host and g.host.color_touching then return g.host:color_touching(target, g, color) end
  return false
end
-- 碰到边缘：造型包围盒超出舞台范围
function M.out_of_boundary(self, args, th)
  -- 「判断离开边缘」：边界下拉（0=整个舞台 1=左 2=上 3=下 4=右），
  -- 语义是"**整个**包围盒越过该边"（has_left_stage 的逐边版本）。
  local which = edge_name(args.boundary or args.type)
  local g = game(th)
  if not which then return require("rt.hit").has_left_stage(self, g) end
  return past_edge(self, which, g)
end
function M.distance_to(self, args, th)
  -- 官方 distanceTo @1562155：自身位置到目标（支持 --mouse）；Math.hypot；结果保留两位小数；
  -- 目标缺失 → NaN（不是 0）。
  local g = game(th)
  local ax, ay = self.x or 0, self.y or 0
  local sprite = args.sprite
  local bx, by
  if sprite == "--mouse" then
    if g.host and g.host.pointer_valid == false then return 0 / 0 end
    bx, by = g:pointer_world()
  elseif sprite == nil or sprite == "" or sprite == "--self" then
    bx, by = ax, ay
  else
    local target = g:find(sprite)
    if not target then return 0 / 0 end
    bx, by = target.x or 0, target.y or 0
  end
  local d = math.sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
  return math.floor(d * 100 + 0.5) / 100
end

function M.coordinate_of_sprite(self, args, th)
  local sprite = args.sprite
  local t = args.coordinate or args.type or args.coord or "x"
  -- 快路径：--self（绝大多数）+ x/y，不碰 game/find/tostring
  if sprite == nil or sprite == "--self" or sprite == "" then
    if t == "y" or t == "Y" then return self.y end
    return self.x
  end
  local g = game(th)
  local target = g:find(sprite) or self
  t = tostring(t):lower()
  if t == "y" then return target.y end
  return target.x
end

function M.style_of_sprite(self, args, th)
  local g = game(th)
  local target = self
  if args.sprite and args.sprite ~= "--self" then target = g:find(args.sprite) or self end
  local t = tostring(args.type or "index")
  if t == "name" then return tostring(target:style_id() or "") end
  return target.style_index
end

function M.appearance_of_sprite(self, args, th)
  local g = game(th)
  local target = self
  if args.sprite and args.sprite ~= "--self" then target = g:find(args.sprite) or self end
  local t = tostring(args.appearance or args.type or "scale")
  -- 官方「角色属性值」选项：scale/width/height/direction/visibility（见 block_catalog options）
  -- 单位：scale = **百分比**（作品里 (115 - appearance) 这类算式只有百分比成立）
  --       width/height = **像素**（官方取的是 PIXI 的 width/height，已在舞台上量过缩放）
  --       direction = **度**（KN 口径，逆时针为正）
  local sx = target.scale_x or 1
  local sy = target.scale_y or 1
  -- 宽度/高度同样按**百分比**返回（与"更改角色大小"同一口径；100 = 原尺寸）
  if t == "width" then return sx * 100 end
  if t == "height" then return sy * 100 end
  if t == "xscale" then return sx * 100 end
  if t == "yscale" then return sy * 100 end
  if t == "direction" or t == "rotation" then return target.dir or 0 end
  if t == "visibility" or t == "visible" then return target.visible and 1 or 0 end
  if t == "x" then return target.x or 0 end
  if t == "y" then return target.y or 0 end
  -- 「大小」：两轴统一写之后以 x 轴为准（宽高块只改单轴时也能读到最新值）
  return sx * 100
end

-- 官方 get_sprite_property（编辑器把 coordinate/style/appearance/effect 统一到这个块）：
--   x/y → 坐标；style_index → 造型序号；scale/width/height/direction → 外观；
--   distance → 距离；0..6/color/opacity/... → 特效值。不支持 → NaN（官方抛"暂不支持"）。
function M.get_sprite_property(self, args, th)
  local attr = tostring(args.attribute or args.type or "")
  local sprite = args.sprite
  if attr == "x" or attr == "y" then
    return M.coordinate_of_sprite(self, { sprite = sprite, coordinate = attr }, th)
  end
  if attr == "style_index" or attr == "style" then
    return M.style_of_sprite(self, { sprite = sprite, type = "index" }, th)
  end
  if attr == "scale" or attr == "width" or attr == "height"
     or attr == "direction" or attr == "rotation" or attr == "visibility" then
    return M.appearance_of_sprite(self, { sprite = sprite, appearance = attr }, th)
  end
  if attr == "distance" then
    return M.distance_to(self, { sprite = sprite }, th)
  end
  local effect = ({
    ["0"] = "0", ["1"] = "1", ["2"] = "2", ["3"] = "3",
    ["4"] = "4", ["5"] = "5", ["6"] = "6",
    color = "0", opacity = "1", brightness = "2", pixelate = "3",
    ripple = "4", distortion = "5", grayscale = "6",
  })[attr]
  if effect ~= nil then
    return M.effect_of_sprite(self, { sprite = sprite, effect = effect }, th)
  end
  return 0 / 0
end

function M.effect_of_sprite(self, args, th)
  local g = game(th)
  local target = self
  if args.sprite and args.sprite ~= "--self" then target = g:find(args.sprite) or self end
  local map = { ["0"] = "color", ["1"] = "opacity", ["2"] = "brightness", ["3"] = "pixelate",
                ["4"] = "ripple", ["5"] = "distortion", ["6"] = "grayscale" }
  -- 字段名在不同代里叫 attribute / effect / type（这个作品用 effect）
  local key = map[tostring(args.effect or args.attribute or args.type or "0")] or "color"
  return target.effects[key] or 0
end

local function hit_table_has(hits, owner)
  if not hits or not owner then return false end
  if hits[owner.id] then return true end
  local oid = tostring(owner.id or "")
  if oid == "" then return false end
  for id in pairs(hits) do
    if type(id) == "string" and id:sub(1, #oid + 1) == oid .. "#" then return true end
  end
  return false
end

-- 目标实体（或它的克隆体）是否在某个 id 集合里
local function id_in(set, e)
  if not set or not e then return false end
  if set[e.id] then return true end
  local p = tostring(e.id) .. "#"
  for id in pairs(set) do
    if type(id) == "string" and id:sub(1, #p) == p then return true end
  end
  return false
end

function M.mouse_down(self, args, th)
  -- 官方 mouseDown @1562946（配合官方 sprite_on_tap / global_tap / global_click 动作状态）：
  --   --screen：click → global_click（仅空白处点击，one_frame）；down/up → global_tap
  --   指定角色：click → getIsMouseClickTarget(entity)（每帧清空）；down/up → sprite_on_tap 状态
  local g = game(th)
  local host = g.host
  local t = tostring(args.type or "down")
  local target = args.sprite
  -- 旧测试/直接注入输入态（从未产生过事件）时退回鼠标原始状态
  if host.global_tap == nil then
    if t == "click" then return g.last_click_frame == g.frame end
    if t == "down" then return host.mouse_is_down == true end
    return host.mouse_up == true
  end
  if target == nil or target == "" or target == "--screen" then
    if t == "click" then return host.global_click == true end
    if t == "down" then return host.global_tap == "mouse_down" end
    return host.global_tap == "mouse_up"
  end
  local e
  if target == "--self" or target == self.id or target == self.name then
    e = self
  else
    e = g:find(target)
  end
  if not e then return false end
  if t == "click" then
    if host.click_targets then return id_in(host.click_targets, e) end
    return id_in(host.click_hits, e)
  end
  local st = nil
  local action = host.tap_action or {}
  if action[e.id] ~= nil then
    st = action[e.id]
  else
    local p = tostring(e.id) .. "#"
    for id, v in pairs(action) do
      if type(id) == "string" and id:sub(1, #p) == p then st = v end
    end
  end
  if t == "down" then return st == "mouse_down" end
  return st == "mouse_up"
end

function M.check_key(self, args, th)
  -- 官方 checkKey @1563644：on_keydown 动作状态 === type（down/up 会一直保持到最后一次事件）
  local host = game(th).host
  local code = tostring(args.key or "")
  local want = tostring(args.type or "down")
  local st = host.key_states and host.key_states[code]
  if st == nil then
    -- 旧测试/直接注入 host.keys 的路径
    local down = (host.key_down and host:key_down(code) == true)
      or (host.keys and host.keys[code] == true)
    return (want == "down") and down or false
  end
  return st == want
end

function M.get_mouse_info(self, args, th)
  local g = game(th)
  local host = g.host
  -- PC：鼠标位置在 mouseup 后继续有效（官方 __IS_PC__ 分支）。
  -- 移动端：手指抬起后位置为 NaN（官方 touchend 清空）。
  if not host or host.pointer_valid == false then return 0 / 0 end
  if host.is_mobile and not host.mouse_is_down then return 0 / 0 end
  if type(g.pointer_world) ~= "function" then return 0 / 0 end
  local wx, wy = g:pointer_world()
  -- 官方 getMouseInfo @1563856：round(坐标, 2)
  local function round2(v)
    if v ~= v then return v end
    return math.floor(v * 100 + 0.5) / 100
  end
  local t = tostring(args.type or "x"):lower()
  if t == "y" then return round2(wy) end
  return round2(wx)
end

function M.get_voice_volume(self) return 0 end
function M.get_orientation(self)
  -- 手机传感器暂未接入：倾斜角按离线占位返回 0。
  return 0
end
function M.get_voice_answer(self) return "" end

---------------------------------------------------------------- 计时器 / 时间 / 舞台
function M.timer(self, args, th)
  return game(th).timer
end
M.get_timer = M.timer

function M.set_timer_state(self, args, th)
  local g = game(th)
  -- 作品里传的是**中文**：执行计时器("开始"/"停止"/"重置")。
  -- 之前只认 start/stop，别的全落到 else → "开始"变成了"重置且不跑"，
  -- 于是 等待直到(计时器值() >= …) 永远不成立，歌词/音乐的整条链卡死。
  local t = tostring(args.type or args.state or "start")
  local tl = t:lower()
  if t == "开始" or tl == "start" then
    g.timer_running = true
    g.timer_visible = true
  elseif t == "停止" or tl == "stop" then
    g.timer_running = false
  elseif t == "重置" or tl == "reset" then
    -- 官方 control_timer: reset → resetTimer(), startTimer()（main.15ba0757.js:1 byte 1566124）
    g.timer = 0
    g.timer_running = true
  end
end
M.reset_timer = function(self, args, th) game(th).timer = 0 end

-- 官方 week.names0..6 是本地化日名（main.15ba0757.js:1 byte 1565722）。
-- 默认中文；KN_LANG/LANG 以 en/fr 开头时切换。
local DAY_NAMES = {
  zh = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" },
  en = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" },
  fr = { "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi" },
}
local function day_names()
  local lang = tostring(os.getenv("KN_LANG") or os.getenv("LANG") or ""):lower()
  if lang:match("^en") then return DAY_NAMES.en end
  if lang:match("^fr") then return DAY_NAMES.fr end
  return DAY_NAMES.zh
end

function M.show_hide_timer(self, args, th)
  local g = game(th)
  g.timer_visible = (tostring(args.showHide or args.show or args.type or "show") ~= "hide")
  if not g.timer_pos then g.timer_pos = { x = g.stage_w - 180, y = 12 } end
end

function M.get_time(self, args, th)
  -- 官方「当前时间」：字段 time = year/month/date/weekday/weekday_num/hour/minute/second
  local t = tostring(args.time or args.type or "second"):lower()
  if t == "year" then return tonumber(os.date("%Y")) end
  if t == "month" then return tonumber(os.date("%m")) end
  if t == "date" or t == "day" then return tonumber(os.date("%d")) end
  if t == "hour" then return tonumber(os.date("%H")) end
  if t == "minute" then return tonumber(os.date("%M")) end
  if t == "second" or t == "sec" then return tonumber(os.date("%S")) end
  if t == "weekday" or t == "week" or t == "wday" then
    local w = tonumber(os.date("%w")) or 0
    return day_names()[w + 1]
  end
  if t == "weekday_num" then
    local w = tonumber(os.date("%w")) or 0
    return w == 0 and 7 or w
  end
  return tonumber(os.date("%S"))
end

function M.get_stage_info(self, args, th)
  local g = game(th)
  if tostring(args.type or "width") == "height" then return g.stage_h end
  return g.stage_w
end


---------------------------------------------------------------- 切屏
-- 切屏：显示目标屏幕的角色、隐藏其它屏幕的（官方切屏还会重置该屏的脚本，这里先做显隐）
function M.switch_to_screen(self, args, th)
  local g = game(th)
  local raw = args.screen_id or args.screen or args.id or args.name
  local key = (type(raw) == "number" or tostring(raw) == "next" or tostring(raw) == "prev")
    and g:resolve_screen(raw) or g:resolve_var_key(raw)
  if key == nil then return end
  if not g.screens[key] then key = g:resolve_screen(raw) or key end
  if key == nil or not g.screens[key] or key == g.cur_screen then return end
  local Scene = require("rt.scene")
  local old = g.cur_screen
  -- 机制（**官方源码登记表**，非推测）：
  --   跑出运行组（group_id 有值且 != 当前屏幕）时，只有 block_finish_out_of_run_group 里的类型被销毁，
  --   官方该表只有 ["on_running_group_activated"] → 切屏只销毁**绿旗**线程；
  --   而 start_on_click 没有 group_id → 永不"跑出运行组" → 线程永不因切屏销毁。
  -- 切屏必须终止旧屏幕的全部运行线程。官方只把 on_running_group_activated 标记为
  -- finish_out_of_run_group，但旧屏幕的 start_on_click / sprite_on_tap 线程如果继续存活，
  -- 会在新屏幕上继续轮询 mouse_down / bump_into，形成输入穿透和残留笔迹。
  for _, t2 in ipairs(g.sched.threads) do
    if not t2.done and t2 ~= th then
      local o = t2.owner
      local old_owner = o and (o.kind == "screen" or (o.scene == old) or (o.scenes and o.scenes[1] == old))
      local keep = (t2.hat == "start_on_click" or t2.hat == "start_on_click_2")
      if old_owner and not keep then
        t2.stopped = true
        t2.done = true
        t2.wait_for = nil
        t2.lock_count = 0
      end
    end
  end
  -- 旧屏幕的克隆体随屏幕销毁；否则回到该屏幕时旧 clone 会残留，
  -- 表现为点击位置的“残影/印章”。
  for i = #g.entities, 1, -1 do
    local e = g.entities[i]
    local parent_scene = e.parent and (e.parent.scene or (e.parent.scenes and e.parent.scenes[1]))
    if e.is_clone and (e.scene == old or parent_scene == old) then
      if g.bubbles then g.bubbles[e] = nil end
      if e.parent then e.parent.clones = math.max(0, (e.parent.clones or 0) - 1) end
      table.remove(g.entities, i)
    end
  end
  for _, e in ipairs(g.entities) do
    if e.kind ~= "screen" and (e.scene == old or (e.scenes and e.scenes[1] == old)) then
      e.clones, e.clone_seq = 0, 0
    end
  end
  local cfg = g.transition_cfg or { type = "none", direction = "up" }
  if cfg.type ~= "none" and cfg.type ~= nil then
    g.transition = { type = cfg.type, direction = cfg.direction, elapsed = 0,
      duration = cfg.duration or 0.35, from = old, to = key }
  end
  g.cur_screen = key
  -- 笔层按当前屏幕切换；不清空任何屏幕的笔层。
  -- 切换场景门（唯一权威判定），并启动新屏幕的绿旗
  g.sched:fire_green_flag(key)
  -- 当前线程属于旧屏幕：切屏完成后立即结束，避免继续执行旧屏点击后的语句。
  if th and th.owner then
    local o = th.owner
    local old_owner = (o.kind == "screen") or (o.scene == old) or (o.scenes and o.scenes[1] == old)
    if old_owner then
      th.stopped = true
      th.done = true
      error(require("rt.core").SIG.STOP_THIS, 0)
    end
  end
end
function M.set_screen_transition(self, args, th)
  local g = game(th)
  g.transition_cfg = { type = tostring(args.type or "none"),
    direction = tostring(args.direction or "up"), duration = tonumber(args.duration) or 0.35 }
end
function M.get_screens(self, args, th)
  -- 官方 get_screens 直接返回字段值（next/prev/UUID/name/数字）。
  return args.screen_id
end

return M
