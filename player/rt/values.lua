-- KN 值语义：数值/字符串/布尔/颜色的互转
-- 对齐 Scratch 系惯例：字符串自动数值化、非数字字符串按 0、数字转字符串不带 .0
local V = {}

function V.num(v)
  if v == nil then return 0 end
  local t = type(v)
  if t == "number" then return v end
  if t == "boolean" then return v and 1 or 0 end
  if t == "string" then
    local s = v:match("^%s*(.-)%s*$")
    if s == "" then return 0 end
    local n = tonumber(s)
    if n then return n end
    return 0 -- 官方对部分积木有 nan_to_zero_conversion_blocks 兼容开关，默认同样按 0
  end
  return 0
end

-- JS 的 Number() 语义：非数字字符串/undefined/对象 → NaN（Lua 里用 0/0 表示）
-- 与 V.num 的区别：V.num 把无法转换的当 0（KN 的部分积木这么干），
-- 而 JS 原生算术（官方 math_arithmetic 的 ADD/MINUS/…）会得到 NaN。
function V.js_num(v)
  if v == nil then return 0 / 0 end
  local t = type(v)
  if t == "number" then return v end
  if t == "boolean" then return v and 1 or 0 end
  if t == "string" then
    local s = v:match("^%s*(.-)%s*$")
    if s == "" then return 0 end
    local n = tonumber(s)
    if n then return n end
    return 0 / 0
  end
  return 0 / 0
end

-- 判断是不是「数组形态」的 Lua table（键都是数字、且非空）
local function is_array(t)
  local n, maxk = 0, 0
  for k in pairs(t) do
    if type(k) ~= "number" then return false end
    if k > maxk then maxk = k end
    n = n + 1
  end
  return n > 0, maxk
end

-- JS 的 String() 语义（拼接/打印时用）：
--   数组 → join(",") 且元素递归（String([[1,2],[3]]) === "1,2,3"）
--   对象 → "[object Object]"
--   其余 → 与 V.str 一致
function V.js_str(v, depth, seen)
  if v == nil then return "undefined" end
  local t = type(v)
  if t == "boolean" then return v and "true" or "false" end
  if t == "number" or t == "string" then return V.str(v) end
  if t == "table" then
    -- 防自引用 / 超深：作品里很容易构造出循环结构，递归字符串化会直接爆栈
    depth = depth or 0
    if depth > 6 then return "..." end
    if seen and seen[v] then return "[Circular]" end
    seen = seen or {}
    seen[v] = true
    local arr, maxk = is_array(v)
    if arr then
      local parts = {}
      for i = 1, maxk do
        local e = v[i]
        parts[i] = (e == nil) and "" or V.js_str(e, depth + 1, seen)
      end
      return table.concat(parts, ",")
    end
    return "[object Object]"
  end
  return tostring(v)
end

-- JS Number#toString(10)（ECMAScript 7.1.12.1）
-- Lua 的 tostring/%.14g 与 JS 不同：1e15 会变 "1e+15"、0.1+0.2 会变 "0.3"。
-- 这里用「最短可回读位数」+ ECMAScript 的定点/指数规则重排。
local NUMSTR_CACHE, NUMSTR_N = {}, 0

local function shortest_roundtrip(v)
  for p = 1, 17 do
    local s = string.format("%." .. p .. "g", v)
    if tonumber(s) == v then return s end
  end
  return string.format("%.17g", v)
end

function V.js_number_to_string(v)
  if v ~= v then return "NaN" end
  if v == math.huge then return "Infinity" end
  if v == -math.huge then return "-Infinity" end
  if v == 0 then return "0" end -- 含 -0
  local cached = NUMSTR_CACHE[v]
  if cached then return cached end
  local neg = v < 0
  local raw = shortest_roundtrip(neg and -v or v)
  local mant, exp = raw:match("^(.-)[eE]([+-]?%d+)$")
  if not mant then mant, exp = raw, "0" end
  local int, frac = mant:match("^(%d*)%.?(%d*)$")
  int = int or "0"
  frac = frac or ""
  local digits = (int .. frac):gsub("^0+", "")
  if digits == "" then digits = "0" end
  local k = #digits
  local f = #frac
  local n = k + tonumber(exp) - f
  local out
  if k <= n and n <= 21 then
    out = digits .. string.rep("0", n - k)
  elseif 0 < n and n <= 21 then
    out = digits:sub(1, n) .. "." .. digits:sub(n + 1)
  elseif -6 < n and n <= 0 then
    out = "0." .. string.rep("0", -n) .. digits
  else
    local e = n - 1
    local mantissa
    if k == 1 then
      mantissa = digits
    else
      mantissa = digits:sub(1, 1) .. "." .. digits:sub(2)
    end
    out = mantissa .. "e" .. (e >= 0 and "+" or "-") .. math.abs(e)
  end
  if neg then out = "-" .. out end
  if NUMSTR_N < 512 then
    NUMSTR_CACHE[v] = out
    NUMSTR_N = NUMSTR_N + 1
  end
  return out
end

function V.str(v)
  if v == nil then return "" end
  local t = type(v)
  if t == "string" then return v end
  if t == "boolean" then return v and "true" or "false" end
  if t == "number" then return V.js_number_to_string(v) end
  if t == "table" then return V.js_str(v) end       -- 数组/对象按 JS 的 String() 来
  return tostring(v)
end



-- 官方列表 UI 的 Qz：数组 -> [a,b]；嵌套数组 -> [...]；对象/标量 -> String(value)
function V.list_display(v, depth, seen)
  if type(v) ~= "table" then return V.str(v) end
  if next(v) == nil then return "[]" end
  local arr, maxk = is_array(v)
  if not arr then return "[object Object]" end
  depth = depth or 0
  if depth > 0 then return "[...]" end
  seen = seen or {}
  if seen[v] then return "[...]" end
  seen[v] = true
  local parts = {}
  for i = 1, maxk do
    local e = v[i]
    if type(e) == "table" and is_array(e) then
      parts[i] = "[...]"
    else
      parts[i] = V.str(e)
    end
  end
  return "[" .. table.concat(parts, ",") .. "]"
end
function V.bool(v)
  if v == nil or v == false then return false end
  local t = type(v)
  if t == "boolean" then return v end
  if t == "number" then return v ~= 0 and v == v end -- JS：NaN 是假值（Lua 里 nan 是真值，必须显式判）
  if t == "string" then
    local s = v:match("^%s*(.-)%s*$")
    if s == "" or s == "0" or s == "false" then return false end
    return true
  end
  return true
end

-- "#ffb029" / 0xffb029 / {r,g,b,a} -> r,g,b,a（0..1）
function V.rgb(v)
  if type(v) == "table" then return v[1] or 0, v[2] or 0, v[3] or 0, v[4] or 1 end
  local n
  if type(v) == "number" then
    n = v
  else
    local s = tostring(v or ""):gsub("#", "")
    if #s == 3 then s = s:sub(1, 1):rep(2) .. s:sub(2, 2):rep(2) .. s:sub(3, 3):rep(2) end
    n = tonumber(s, 16) or 0
  end
  local r = math.floor(n / 65536) % 256
  local g = math.floor(n / 256) % 256
  local b = n % 256
  return r / 255, g / 255, b / 255, 1
end

-- 宽松相等（≈ JS `==`）：两边能数值化就按数值比，否则按字符串比
function V.eq(a, b)
  if a == b then return true end                    -- 最常见：同值（含数字/字符串）
  local ta, tb = type(a), type(b)
  if ta == "string" and tb == "string" then return false end  -- JS 两个字符串不做数值转换
  if ta == "boolean" or tb == "boolean" then return false end
  if (ta == "table" or ta == "function") or (tb == "table" or tb == "function") then return false end
  local na, nb = tonumber(a), tonumber(b)
  if na and nb then return na == nb end
  return tostring(a) == tostring(b)
end

-- 严格相等（≈ JS `===`）：类型必须一致（JS 里 "0" !== 0）
function V.seq(a, b)
  if type(a) ~= type(b) then return false end
  return a == b
end

-- 官方 logic_compare 就是 JS 原生比较：LT: t.A < t.B 等。
-- JS 规则：两边都是字符串 → 按字典序；否则都转数值，出现 NaN → 一律 false。
-- 特别是「越界取到 undefined」时比较必须为 false（这正是 VM 词法器会不会死循环的关键）。
local function both_strings(a, b)
  return type(a) == "string" and type(b) == "string"
end

local function num2(a, b)
  local na = tonumber(a)
  local nb = tonumber(b)
  if na == nil or nb == nil then return nil end
  return na, nb
end

function V.js_lt(a, b)
  if both_strings(a, b) then return a < b end
  local na, nb = num2(a, b)
  if not na then return false end
  return na < nb
end

function V.js_le(a, b)
  if both_strings(a, b) then return a <= b end
  local na, nb = num2(a, b)
  if not na then return false end
  return na <= nb
end

function V.js_gt(a, b)
  if both_strings(a, b) then return a > b end
  local na, nb = num2(a, b)
  if not na then return false end
  return na > nb
end

function V.js_ge(a, b)
  if both_strings(a, b) then return a >= b end
  local na, nb = num2(a, b)
  if not na then return false end
  return na >= nb
end

-- 保留 cmp（内部/调试用）
function V.cmp(a, b)
  if V.js_lt(a, b) then return -1 end
  if V.js_gt(a, b) then return 1 end
  return 0
end

---------------------------------------------------------------- JS Boolean() / Number()
-- 官方 logic_negate / convert_type(boolean) / 公式求值都用 JS 真值：
--   "0" 是真值、0/NaN/"" 是假值、空表是真值。
function V.js_boolean(v)
  if v == nil or v == false then return false end
  local t = type(v)
  if t == "boolean" then return v end
  if t == "number" then return v ~= 0 and v == v end
  if t == "string" then return #v > 0 end
  return true
end

local function str_to_number(s)
  local z = s:match("^%s*(.-)%s*$")
  if z == "" then return 0 end
  local sign, body = 1, z
  if body:sub(1, 1) == "+" then body = body:sub(2)
  elseif body:sub(1, 1) == "-" then sign, body = -1, body:sub(2) end
  if body == "Infinity" then return sign * math.huge end
  local low = body:lower()
  local hex = low:match("^0x(%x+)$")
  if hex then return sign * tonumber(hex, 16) end
  local bin = low:match("^0b([01]+)$")
  if bin then
    local n = 0
    for i = 1, #bin do n = n * 2 + tonumber(bin:sub(i, i)) end
    return sign * n
  end
  local oct = low:match("^0o([0-7]+)$")
  if oct then
    local n = 0
    for i = 1, #oct do n = n * 8 + tonumber(oct:sub(i, i)) end
    return sign * n
  end
  local n = tonumber(z)
  if n ~= nil then return n end
  return 0 / 0
end

-- JS Number()：Number("")=0 / Number("abc")=NaN / Number([])=0 / Number([5])=5
function V.js_number(v)
  if v == nil then return 0 / 0 end
  local t = type(v)
  if t == "number" then return v end
  if t == "boolean" then return v and 1 or 0 end
  if t == "string" then return str_to_number(v) end
  if t == "table" then
    local ok, n = pcall(function()
      local count, only, maxk = 0, nil, 0
      for k, x in pairs(v) do
        if type(k) ~= "number" then return nil end
        count = count + 1
        only = x
        if k > maxk then maxk = k end
      end
      if count == 0 then return 0 end
      if count == 1 and maxk == 1 then return V.js_number(only) end
      return nil
    end)
    if ok and n ~= nil then return n end
    return 0 / 0
  end
  return 0 / 0
end

function V.js_number_is_nan(v)
  return type(v) == "number" and v ~= v
end

-- JS Math.round（.5 向 +∞）
function V.js_round(x)
  x = V.js_number(x)
  if x ~= x or x == math.huge or x == -math.huge then return x end
  return math.floor(x + 0.5)
end

---------------------------------------------------------------- UTF-16 字符串语义（JS String.length / substring / charAt）
-- Lua 字符串是 UTF-8 字节；官方是 JS UTF-16。中文按 1 个码元、emoji 按 2 个码元。
local function utf8_next(s, i)
  local b = s:byte(i)
  if not b then return nil, i end
  if b < 0x80 then return b, i + 1 end
  if b >= 0xC2 and b <= 0xDF then
    local b2 = s:byte(i + 1)
    if b2 and b2 >= 0x80 and b2 <= 0xBF then
      return (b - 0xC0) * 64 + (b2 - 0x80), i + 2
    end
  elseif b >= 0xE0 and b <= 0xEF then
    local b2, b3 = s:byte(i + 1, i + 2)
    if b2 and b3 and b2 >= 0x80 and b2 <= 0xBF and b3 >= 0x80 and b3 <= 0xBF then
      local cp = (b - 0xE0) * 4096 + (b2 - 0x80) * 64 + (b3 - 0x80)
      if cp >= 0x800 then return cp, i + 3 end
    end
  elseif b >= 0xF0 and b <= 0xF4 then
    local b2, b3, b4 = s:byte(i + 1, i + 3)
    if b2 and b3 and b4 and b2 >= 0x80 and b2 <= 0xBF
       and b3 >= 0x80 and b3 <= 0xBF and b4 >= 0x80 and b4 <= 0xBF then
      local cp = (b - 0xF0) * 262144 + (b2 - 0x80) * 4096 + (b3 - 0x80) * 64 + (b4 - 0x80)
      if cp >= 0x10000 and cp <= 0x10FFFF then return cp, i + 4 end
    end
  end
  return 0xFFFD, i + 1
end

local utf16_cache = { s = nil, units = 0, cps = nil }

local function utf16_info(s)
  if utf16_cache.s == s then return utf16_cache.units, utf16_cache.cps end
  local cps, units, i = {}, 0, 1
  while i <= #s do
    local cp, ni = utf8_next(s, i)
    local u = (cp >= 0x10000) and 2 or 1
    cps[#cps + 1] = { cp = cp, sb = i, eb = ni - 1, u1 = units, u2 = units + u }
    units = units + u
    i = ni
  end
  utf16_cache.s, utf16_cache.units, utf16_cache.cps = s, units, cps
  return units, cps
end

function V.utf16_len(v)
  if v == nil then return 0 end
  local s = (type(v) == "string") and v or V.js_str(v)
  return utf16_info(s)
end

local REPLACEMENT = "\239\191\189" -- U+FFFD

-- JS substring(start0, end0)：0 基、ToInteger、越界 clamp、start>end 交换
function V.utf16_substring0(s, start0, end0)
  if type(s) ~= "string" then s = V.js_str(s) end
  local units, cps = utf16_info(s)
  local function to_int(x)
    if type(x) ~= "number" or x ~= x then return 0 end
    if x == math.huge then return units end
    if x == -math.huge then return -units end
    if x >= 0 then return math.floor(x) end
    return math.ceil(x)
  end
  local function clamp(x)
    if x < 0 then return 0 end
    if x > units then return units end
    return math.floor(x)
  end
  local a, b = clamp(to_int(start0)), clamp(to_int(end0))
  if a > b then a, b = b, a end
  local out = {}
  for i = 1, #cps do
    local cp = cps[i]
    if cp.u2 <= a then
      -- skip
    elseif cp.u1 >= b then
      break
    elseif cp.u1 >= a and cp.u2 <= b then
      out[#out + 1] = s:sub(cp.sb, cp.eb)
    else
      out[#out + 1] = REPLACEMENT
    end
  end
  return table.concat(out)
end

-- JS a[0-based unit index]：取该码元；落在代理对中间时 JS 得到半代理，这里用替换符
function V.utf16_char_at0(s, idx0)
  if type(s) ~= "string" then s = V.js_str(s) end
  local units, cps = utf16_info(s)
  if type(idx0) ~= "number" or idx0 ~= idx0 then return nil end
  idx0 = math.floor(idx0)
  if idx0 < 0 or idx0 >= units then return nil end
  for i = 1, #cps do
    local cp = cps[i]
    if idx0 >= cp.u1 and idx0 < cp.u2 then
      if idx0 == cp.u1 then
        return s:sub(cp.sb, cp.eb)
      end
      return REPLACEMENT
    end
  end
  return nil
end

function V.utf16_reverse(s)
  if type(s) ~= "string" then s = V.js_str(s) end
  local _, cps = utf16_info(s)
  local out = {}
  for i = #cps, 1, -1 do out[#out + 1] = s:sub(cps[i].sb, cps[i].eb) end
  return table.concat(out)
end

return V
