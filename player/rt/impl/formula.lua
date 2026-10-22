-- 官方「公式计算」求值器（calculate）
--
-- 算法逐字移植自官方播放器内置的 math-expression-evaluator 1.4.0：
--   lex(input) -> toPostfix() -> postfixEval()
-- 依据（研究副本，不进包）：
--   analysis/official_domain_fns.txt:171（calculate 调用链）
--   analysis/kn_math_expr.js.txt（lex / toPostfix / postfixEval / token 表逐字）
--   官方 bundle 内 math 对象：isDegree = true（三角函数按角度、反三角返回角度）
--
-- 与原库一致的怪异行为也保留（例如 1/0 返回字符串 "Infinity"、tanh 因 sinha 未定义而报错、
-- 非法公式抛异常）；只额外加了迭代上限防止表达式把整帧卡死。
local V = require("rt.values")

local M = {}

local MAX_STEPS = 200000

local function fail(msg)
  error("公式错误: " .. tostring(msg), 0)
end
M.fail = fail

---------------------------------------------------------------- 官方 math 对象
local mathf = { isDegree = true }

local function js_floor(x) return math.floor(x) end

local function js_mod(a, b)
  a, b = V.js_number(a), V.js_number(b)
  if b == 0 then return 0 / 0 end
  return math.fmod(a, b)
end

local function js_bit_and(a, b)
  local function to_u32(x)
    x = V.js_number(x)
    if x ~= x or x == math.huge or x == -math.huge then return 0 end
    x = math.floor(x) % 4294967296
    if x < 0 then x = x + 4294967296 end
    return x
  end
  local ua, ub = to_u32(a), to_u32(b)
  local res, bit = 0, 1
  for _ = 1, 32 do
    local xa, xb = ua % 2, ub % 2
    ua, ub = math.floor(ua / 2), math.floor(ub / 2)
    if xa == 1 and xb == 1 then res = res + bit end
    bit = bit * 2
  end
  if res >= 2147483648 then res = res - 4294967296 end
  return res
end

local function fact(n)
  n = V.js_number(n)
  if n % 1 ~= 0 then return "NaN" end
  local pro = 1
  for i = 2, n do pro = pro * i end
  return pro
end

mathf.acos = function(x) return math.deg(math.acos(V.js_number(x))) end
mathf.asin = function(x) return math.deg(math.asin(V.js_number(x))) end
mathf.atan = function(x) return math.deg(math.atan(V.js_number(x))) end
mathf.add = function(a, b)
  if type(a) == "string" or type(b) == "string" then
    return V.js_str(a) .. V.js_str(b)
  end
  return V.js_number(a) + V.js_number(b)
end
mathf.sub = function(a, b) return V.js_number(a) - V.js_number(b) end
mathf.mul = function(a, b) return V.js_number(a) * V.js_number(b) end
mathf.div = function(a, b) return V.js_number(a) / V.js_number(b) end
mathf.mod = js_mod
mathf["and"] = js_bit_and
mathf.changeSign = function(x) return -V.js_number(x) end
mathf.cos = function(x) return math.cos(math.rad(V.js_number(x))) end
mathf.sin = function(x) return math.sin(math.rad(V.js_number(x))) end
mathf.tan = function(x) return math.tan(math.rad(V.js_number(x))) end
mathf.cosh = function(x)
  x = V.js_number(x)
  return (math.exp(x) + math.exp(-x)) / 2
end
mathf.sinh = function(x)
  x = V.js_number(x)
  return (math.exp(x) - math.exp(-x)) / 2
end
mathf.acosh = function(x)
  x = V.js_number(x)
  return math.log(x + math.sqrt(x * x - 1))
end
mathf.asinh = function(x)
  x = V.js_number(x)
  return math.log(x + math.sqrt(x * x + 1))
end
mathf.atanh = function(x)
  x = V.js_number(x)
  return math.log((1 + x) / (1 - x))
end
mathf.tanh = function() return mathf.sinha() / mathf.cosha() end -- 官方就是坏的
mathf.fact = fact
mathf.inverse = function(x) return 1 / V.js_number(x) end
mathf.log = function(x) return math.log(V.js_number(x)) / math.log(10) end
mathf.root = function(x) return math.sqrt(V.js_number(x)) end
mathf.int = js_floor
mathf.pow10x = function(e)
  local x = 1
  while e > 0 do x = x * 10; e = e - 1 end
  return x
end
mathf.P = function(n, r)
  n, r = math.floor(V.js_number(n)), math.floor(V.js_number(r))
  local pro = 1
  for i = n - r + 1, n do pro = pro * i end
  return pro
end
mathf.C = function(n, r)
  n, r = V.js_number(n), V.js_number(r)
  local pro = 1
  local other = n - r
  local choice = r
  if choice < other then choice, other = other, r end
  for i = choice + 1, n do pro = pro * i end
  return pro / fact(other)
end
mathf.sigma = function(low, high, ex)
  local sum = 0
  local i = V.js_number(low)
  high = V.js_number(high)
  local guard = 0
  while i <= high do
    sum = sum + V.js_number(ex:postfixEval({ n = i }))
    i = i + 1
    guard = guard + 1
    if guard > MAX_STEPS then fail("Sigma too long") end
  end
  return sum
end
mathf.Pi = function(low, high, ex)
  local pro = 1
  local i = V.js_number(low)
  high = V.js_number(high)
  local guard = 0
  while i <= high do
    pro = pro * V.js_number(ex:postfixEval({ n = i }))
    i = i + 1
    guard = guard + 1
    if guard > MAX_STEPS then fail("Pi too long") end
  end
  return pro
end

---------------------------------------------------------------- 词法表（官方 token 表逐字）
local TT = {
  FUNCTION_WITH_ONE_ARG = 0, NUMBER = 1, BINARY_OPERATOR_HIGH_PRECENDENCE = 2,
  CONSTANT = 3, OPENING_PARENTHESIS = 4, CLOSING_PARENTHESIS = 5, DECIMAL = 6,
  POSTFIX_FUNCTION_WITH_ONE_ARG = 7, FUNCTION_WITH_N_ARGS = 8,
  BINARY_OPERATOR_LOW_PRECENDENCE = 9, BINARY_OPERATOR_PERMUTATION = 10,
  COMMA = 11, EVALUATED_FUNCTION = 12, EVALUATED_FUNCTION_PARAMETER = 13, SPACE = 14,
}
M.tokenTypes = TT

local tokens = {
  { token = "sin", show = "sin", type = 0, value = mathf.sin },
  { token = "cos", show = "cos", type = 0, value = mathf.cos },
  { token = "tan", show = "tan", type = 0, value = mathf.tan },
  { token = "pi", show = "&pi;", type = 3, value = "PI" },
  { token = "(", show = "(", type = 4, value = "(" },
  { token = ")", show = ")", type = 5, value = ")" },
  { token = "P", show = "P", type = 10, value = mathf.P },
  { token = "C", show = "C", type = 10, value = mathf.C },
  { token = " ", show = " ", type = 14, value = " " },
  { token = "asin", show = "asin", type = 0, value = mathf.asin },
  { token = "acos", show = "acos", type = 0, value = mathf.acos },
  { token = "atan", show = "atan", type = 0, value = mathf.atan },
  { token = "7", show = "7", type = 1, value = "7" },
  { token = "8", show = "8", type = 1, value = "8" },
  { token = "9", show = "9", type = 1, value = "9" },
  { token = "int", show = "Int", type = 0, value = mathf.int },
  { token = "cosh", show = "cosh", type = 0, value = mathf.cosh },
  { token = "acosh", show = "acosh", type = 0, value = mathf.acosh },
  { token = "ln", show = " ln", type = 0, value = function(x) return math.log(V.js_number(x)) end },
  { token = "^", show = "^", type = 10, value = function(a, b) return V.js_number(a) ^ V.js_number(b) end },
  { token = "root", show = "root", type = 0, value = mathf.root },
  { token = "4", show = "4", type = 1, value = "4" },
  { token = "5", show = "5", type = 1, value = "5" },
  { token = "6", show = "6", type = 1, value = "6" },
  { token = "/", show = "&divide;", type = 2, value = mathf.div },
  { token = "!", show = "!", type = 7, value = mathf.fact },
  { token = "tanh", show = "tanh", type = 0, value = mathf.tanh },
  { token = "atanh", show = "atanh", type = 0, value = mathf.atanh },
  { token = "Mod", show = " Mod ", type = 2, value = mathf.mod },
  { token = "1", show = "1", type = 1, value = "1" },
  { token = "2", show = "2", type = 1, value = "2" },
  { token = "3", show = "3", type = 1, value = "3" },
  { token = "*", show = "&times;", type = 2, value = mathf.mul },
  { token = "sinh", show = "sinh", type = 0, value = mathf.sinh },
  { token = "asinh", show = "asinh", type = 0, value = mathf.asinh },
  { token = "e", show = "e", type = 3, value = "E" },
  { token = "log", show = " log", type = 0, value = mathf.log },
  { token = "0", show = "0", type = 1, value = "0" },
  { token = ".", show = ".", type = 6, value = "." },
  { token = "+", show = "+", type = 9, value = mathf.add },
  { token = "-", show = "-", type = 9, value = mathf.sub },
  { token = ",", show = ",", type = 11, value = "," },
  { token = "Sigma", show = "&Sigma;", type = 12, value = mathf.sigma },
  { token = "n", show = "n", type = 13, value = "n" },
  { token = "Pi", show = "&Pi;", type = 12, value = mathf.Pi },
  { token = "pow", show = "pow", type = 8, value = function(a, b) return V.js_number(a) ^ V.js_number(b) end, numberOfArguments = 2 },
  { token = "&", show = "&", type = 9, value = mathf["and"] },
}

local preced = { [0] = 11, [1] = 0, [2] = 3, [3] = 0, [4] = 0, [5] = 0, [6] = 0,
  [7] = 11, [8] = 11, [9] = 1, [10] = 10, [11] = 0, [12] = 11, [13] = 0, [14] = -1, [15] = 11 }
for i = 1, #tokens do tokens[i].precedence = preced[tokens[i].type] end

local type0 = {}
for _, t in ipairs({ 0, 1, 3, 4, 6, 8, 9, 12, 13, 14, 15 }) do type0[t] = true end
local type1 = {}
for _, t in ipairs({ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15 }) do type1[t] = true end
local type1Asterick = {}
for _, t in ipairs({ 0, 3, 4, 8, 12, 13, 15 }) do type1Asterick[t] = true end
local empty = {}
local type3Asterick = {}
for _, t in ipairs({ 0, 1, 3, 4, 6, 8, 12, 13, 15 }) do type3Asterick[t] = true end
local type6 = { [1] = true }

-- tokenize 用的「按长度索引」表（等价库里的 newAr）
local newAr = {}
for i = 1, #tokens do
  local n = #tokens[i].token
  newAr[n] = newAr[n] or {}
  newAr[n][#newAr[n] + 1] = tokens[i].token
end
local tokenByName = {}
for i = 1, #tokens do tokenByName[tokens[i].token] = tokens[i] end

local function match_at(str, tok, pos0)
  for f = 1, #tok do
    if str:sub(pos0 + f, pos0 + f) ~= tok:sub(f, f) then return false end
  end
  return true
end

local function tokenize(str)
  local nodes = {}
  local len = #str
  local maxLen = #newAr
  local i = 1 -- 1-based；等价官方 0-based i
  local guard = 0
  while i <= len do
    -- 连续两个空格只当一个（官方 skip）
    if not (i < len and str:sub(i, i) == " " and str:sub(i + 1, i + 1) == " ") then
      local remaining = len - i + 1
      local maxx = (remaining > maxLen - 1) and maxLen or remaining
      local key = ""
      for x = maxx, 1, -1 do
        local arr = newAr[x]
        if arr then
          for y = 1, #arr do
            if match_at(str, arr[y], i - 1) then key = arr[y] break end
          end
        end
        if key ~= "" then break end
      end
      if key == "" then fail("Can't understand after " .. str:sub(i)) end
      i = i + #key - 1
      nodes[#nodes + 1] = tokenByName[key]
    end
    i = i + 1
    guard = guard + 1
    if guard > MAX_STEPS then fail("expression too long") end
  end
  return nodes
end

local openingParObj = { value = "(", type = 4, pre = 0, show = "(" }
local closingParObj = { value = ")", show = ")", type = 5, pre = 0 }
local changeSignObj = { value = mathf.changeSign, type = 0, pre = 21, show = "-" }

local function inc(arr, val)
  for i = 1, #arr do arr[i] = arr[i] + val end
  return arr
end

---------------------------------------------------------------- Postfix 对象
local Postfix = {}
Postfix.__index = Postfix
function Postfix.new(parsed) return setmetatable({ value = parsed }, Postfix) end

function Postfix:toPostfix()
  local post = {}
  local stack = { { value = "(", type = 4, pre = 0 } }
  local arr = self.value
  for i = 2, #arr do
    local it = arr[i]
    if it.type == 1 or it.type == 3 or it.type == 13 then
      if it.type == 1 then it.value = V.js_number(it.value) end
      post[#post + 1] = it
    elseif it.type == 4 then
      stack[#stack + 1] = it
    elseif it.type == 5 then
      while true do
        local popped = table.remove(stack)
        if not popped or popped.type == 4 then break end
        post[#post + 1] = popped
      end
    elseif it.type == 11 then
      while true do
        local popped = table.remove(stack)
        if not popped or popped.type == 4 then
          if popped then stack[#stack + 1] = popped end
          break
        end
        post[#post + 1] = popped
      end
    else
      local pre = it.pre
      local ele = stack[#stack]
      local prep = ele.pre
      if pre > prep then
        stack[#stack + 1] = it
      else
        while prep >= pre do
          local popped = table.remove(stack)
          ele = stack[#stack]
          if not ele then break end
          post[#post + 1] = popped
          prep = ele.pre
        end
        stack[#stack + 1] = it
      end
    end
  end
  return Postfix.new(post)
end

local function to_fixed15(v)
  -- JS Number#toFixed(15) 后 parseFloat
  if type(v) ~= "number" then fail("toFixed on non-number") end
  if v ~= v then return 0 / 0 end
  if v == math.huge then return "Infinity" end
  if v == -math.huge then return -math.huge end
  if math.abs(v) >= 1e21 then return v end
  local s = string.format("%.15f", v)
  return tonumber(s) or 0
end

function Postfix:postfixEval(user)
  user = user or {}
  user.PI, user.E = math.pi, math.exp(1)
  local stack = {}
  local bool = user.n ~= nil
  local arr = self.value
  for i = 1, #arr do
    local it = arr[i]
    if it.type == 1 then
      stack[#stack + 1] = { value = it.value, type = 1 }
    elseif it.type == 3 then
      stack[#stack + 1] = { value = user[it.value], type = 1 }
    elseif it.type == 0 or it.type == 7 then
      local top = stack[#stack]
      if top.type == nil then
        top.value[#top.value + 1] = it
      else
        top.value = it.value(top.value)
      end
    elseif it.type == 8 then
      local popped = {}
      for _ = 1, it.numberOfArguments do
        local v = table.remove(stack)
        popped[#popped + 1] = v.value
      end
      local args = {}
      for x = #popped, 1, -1 do args[#args + 1] = popped[x] end
      stack[#stack + 1] = { type = 1, value = it.value(unpack(args)) }
    elseif it.type == 10 or it.type == 2 or it.type == 9 then
      local pop1 = table.remove(stack)
      local pop2 = table.remove(stack)
      local function append_all(dst, src)
        if src.type == nil then
          for _, v in ipairs(src.value) do dst[#dst + 1] = v end
        else
          dst[#dst + 1] = src
        end
      end
      if pop2.type == nil then
        append_all(pop2.value, pop1)
        pop2.value[#pop2.value + 1] = it
        stack[#stack + 1] = pop2
      elseif pop1.type == nil then
        table.insert(pop1.value, 1, pop2)
        pop1.value[#pop1.value + 1] = it
        stack[#stack + 1] = pop1
      else
        stack[#stack + 1] = { type = 1, value = it.value(pop2.value, pop1.value) }
      end
    elseif it.type == 12 then
      local pop1 = table.remove(stack)
      if pop1.type ~= nil then pop1 = { pop1 } end
      local pop2 = table.remove(stack)
      local pop3 = table.remove(stack)
      stack[#stack + 1] = { type = 1,
        value = it.value(pop3.value, pop2.value, Postfix.new(pop1.value or pop1)) }
    elseif it.type == 13 then
      if bool then
        stack[#stack + 1] = { value = user[it.value], type = 3 }
      else
        stack[#stack + 1] = { it }
      end
    end
  end
  if #stack > 1 then fail("Uncaught Syntax error") end
  local val = stack[1] and stack[1].value
  if type(val) ~= "number" then fail("Uncaught Syntax error") end
  if val > 1e15 then return "Infinity" end
  if val ~= val then return 0 / 0 end
  return to_fixed15(val)
end

---------------------------------------------------------------- lex
local function lex(inp)
  if type(inp) ~= "string" then fail("input is not a string") end
  local str = { openingParObj }
  local ptc = {}
  local allowed = type0
  local bracToClose = 0
  local asterick = empty
  local prevKey = ""
  local nodes = tokenize(inp)
  local i = 1
  local guard = 0
  while i <= #nodes do
    local node = nodes[i]
    local skip = false
    if node.type == 14 then
      if i > 1 and i < #nodes and nodes[i + 1].type == 1
         and (nodes[i - 1].type == 1 or nodes[i - 1].type == 6) then
        fail("Unexpected Space")
      end
      skip = true
    end
    if not skip then
      local cToken, cType = node.token, node.type
      local cEv, cPre, cShow = node.value, node.precedence, node.show
      local pre = str[#str]
      local j = #ptc
      while j >= 1 do
        if ptc[j] == 0 then
          if cType == 0 or cType == 2 or cType == 3 or cType == 4 or cType == 5
             or cType == 9 or cType == 11 or cType == 12 or cType == 13 then
            if allowed[cType] ~= true then fail(cToken .. " is not allowed after " .. prevKey) end
            str[#str + 1] = closingParObj
            allowed = type1
            asterick = type3Asterick
            ptc[#ptc] = nil
          else
            break
          end
        else
          break
        end
        j = j - 1
      end
      if allowed[cType] ~= true then fail(cToken .. " is not allowed after " .. prevKey) end
      if asterick[cType] == true then
        cType, cEv, cShow, cPre = 2, mathf.mul, "&times;", 3
        i = i - 1
      end
      local obj = { value = cEv, type = cType, pre = cPre, show = cShow,
        numberOfArguments = node.numberOfArguments }

      if cType == 0 then
        allowed, asterick = type0, empty
        inc(ptc, 2)
        str[#str + 1] = obj
        if nodes[i + 1].type ~= 4 then
          str[#str + 1] = openingParObj
          ptc[#ptc + 1] = 2
        end
      elseif cType == 1 then
        if pre.type == 1 then
          pre.value = tostring(pre.value) .. tostring(cEv)
          inc(ptc, 1)
        else
          str[#str + 1] = obj
        end
        allowed, asterick = type1, type1Asterick
      elseif cType == 2 then
        allowed, asterick = type0, empty
        inc(ptc, 2)
        str[#str + 1] = obj
      elseif cType == 3 then
        str[#str + 1] = obj
        allowed, asterick = type1, type3Asterick
      elseif cType == 4 then
        inc(ptc, 1)
        bracToClose = bracToClose + 1
        allowed, asterick = type0, empty
        str[#str + 1] = obj
      elseif cType == 5 then
        if bracToClose == 0 then fail("Closing parenthesis are more than opening one, wait What!!!") end
        bracToClose = bracToClose - 1
        allowed, asterick = type1, type3Asterick
        str[#str + 1] = obj
        inc(ptc, 1)
      elseif cType == 6 then
        if pre.hasDec then fail("Two decimals are not allowed in one number") end
        if pre.type ~= 1 then
          pre = { value = 0, type = 1, pre = 0 }
          str[#str + 1] = pre
        end
        allowed, asterick = type6, empty
        inc(ptc, 1)
        pre.value = tostring(pre.value) .. tostring(cEv)
        pre.hasDec = true
      elseif cType == 7 then
        allowed, asterick = type1, type3Asterick
        inc(ptc, 1)
        str[#str + 1] = obj
      end

      if cType == 8 then
        allowed, asterick = type0, empty
        inc(ptc, (node.numberOfArguments or 2) + 2)
        str[#str + 1] = obj
        if nodes[i + 1].type ~= 4 then
          str[#str + 1] = openingParObj
          ptc[#ptc + 1] = (node.numberOfArguments or 2) + 2
        end
      elseif cType == 9 then
        if pre.type == 9 then
          if pre.value == mathf.add then
            pre.value, pre.show = cEv, cShow
            inc(ptc, 1)
          elseif pre.value == mathf.sub and cShow == "-" then
            pre.value, pre.show = mathf.add, "+"
            inc(ptc, 1)
          end
        elseif pre.type ~= 5 and pre.type ~= 7 and pre.type ~= 1 and pre.type ~= 3 and pre.type ~= 13 then
          if cToken == "-" then
            allowed, asterick = type0, empty
            inc(ptc, 2)
            ptc[#ptc + 1] = 2
            str[#str + 1] = changeSignObj
            str[#str + 1] = openingParObj
          end
        else
          str[#str + 1] = obj
          inc(ptc, 2)
        end
        allowed, asterick = type0, empty
      elseif cType == 10 then
        allowed, asterick = type0, empty
        inc(ptc, 2)
        str[#str + 1] = obj
      elseif cType == 11 then
        allowed, asterick = type0, empty
        str[#str + 1] = obj
      elseif cType == 12 then
        allowed, asterick = type0, empty
        inc(ptc, 6)
        str[#str + 1] = obj
        if nodes[i + 1].type ~= 4 then
          str[#str + 1] = openingParObj
          ptc[#ptc + 1] = 6
        end
      elseif cType == 13 then
        allowed, asterick = type1, type3Asterick
        str[#str + 1] = obj
      end

      inc(ptc, -1)
      prevKey = cToken
    end
    i = i + 1
    guard = guard + 1
    if guard > MAX_STEPS then fail("expression too complex") end
  end
  for _ = 1, #ptc do str[#str + 1] = closingParObj end
  if allowed[5] ~= true then fail("complete the expression") end
  while bracToClose > 0 do
    str[#str + 1] = closingParObj
    bracToClose = bracToClose - 1
  end
  str[#str + 1] = closingParObj
  return Postfix.new(str)
end

M.lex = function(inp) return lex(inp) end

function M.evaluate(input)
  local ok, res = pcall(function()
    local p = lex(input)
    return p:toPostfix():postfixEval()
  end)
  if not ok then error(tostring(res), 0) end
  return res
end

M.math = mathf
return M
