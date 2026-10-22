-- Decimal 四则（base-1e7 limb，precision=16，ROUND_HALF_UP）。
-- value = sign * sum(d[i] * BASE^(i-1)) * 10^exp
local D = {}
D.PRECISION = 16
D.BASE = 10000000
D.LOG_BASE = 7
local BASE, LOG = D.BASE, D.LOG_BASE

local function z() return { sign = 1, d = { 0 }, e = 0 } end
local function nan() return { sign = 1, d = { 0 }, e = 0, nan = true } end
local function inf(sign) return { sign = sign < 0 and -1 or 1, d = { 0 }, e = 0, inf = true } end
D.is_nan = function(x) return type(x) == "table" and x.nan or false end
D.is_inf = function(x) return type(x) == "table" and x.inf or false end

local function trim(d)
  while #d > 1 and d[#d] == 0 do d[#d] = nil end
  return d
end

local function digits_of(d)
  if #d == 1 and d[1] == 0 then return "0" end
  local p = { tostring(d[#d]) }
  for i = #d - 1, 1, -1 do p[#p + 1] = string.format("%07d", d[i]) end
  return table.concat(p)
end

local function limbs_from(s)
  s = s:gsub("^0+", "")
  if s == "" then return { 0 } end
  local d, n = {}, #s
  while n > 0 do
    local a = math.max(1, n - LOG + 1)
    d[#d + 1] = tonumber(s:sub(a, n))
    n = a - 1
  end
  return d
end

local function round(sign, d, e)
  trim(d)
  if #d == 1 and d[1] == 0 then return z() end
  local s = digits_of(d)
  local L = #s
  if L > D.PRECISION then
    local cut = s:sub(1, D.PRECISION)
    local nextd = tonumber(s:sub(D.PRECISION + 1, D.PRECISION + 1)) or 0
    e = e + (L - D.PRECISION)
    if nextd >= 5 then
      local out, carry = {}, 1
      for i = #cut, 1, -1 do
        local n = tonumber(cut:sub(i, i)) + carry
        if n >= 10 then n = n - 10; carry = 1 else carry = 0 end
        out[i] = tostring(n)
      end
      cut = table.concat(out)
      if carry > 0 then cut = "1" .. cut end
    end
    s = cut
  end
  s = s:gsub("^0+", "")
  if s == "" then return z() end
  local tz = 0
  while #s > 1 and s:sub(-1) == "0" do s = s:sub(1, -2); tz = tz + 1 end
  return { sign = sign < 0 and -1 or 1, d = limbs_from(s), e = e + tz }
end

function D.parse(text)
  local s = tostring(text or "0"):gsub("^%s+", ""):gsub("%s+$", "")
  local sign = 1
  if s:sub(1, 1) == "-" then sign = -1; s = s:sub(2)
  elseif s:sub(1, 1) == "+" then s = s:sub(2) end
  local mant, ex = s:match("^([^eE]+)[eE]([+-]?%d+)$")
  local exv = 0
  if mant then s = mant; exv = tonumber(ex) or 0 end
  local ip, fp = s:match("^(%d*)%.?(%d*)$")
  if not ip then return nan() end
  ip, fp = ip or "", fp or ""
  if ip == "" and fp == "" then return nan() end
  local digits = ip .. fp
  local e = exv - #fp
  digits = digits:gsub("^0+", "")
  if digits == "" then return z() end
  return round(sign, limbs_from(digits), e)
end

local function shortest_number(n)
  if n == 0 then return "0" end
  if n == math.floor(n) and math.abs(n) < 1e15 then return string.format("%d", n) end
  local s
  for p = 1, 17 do
    s = string.format("%." .. p .. "g", n)
    if tonumber(s) == n then return s end
  end
  return s
end

local num_cache, num_cache_n = {}, 0
function D.new(v)
  if type(v) == "table" and v.d then return v end
  if type(v) == "number" then
    if v ~= v then return nan() end
    if v == math.huge then return inf(1) end
    if v == -math.huge then return inf(-1) end
    local c = num_cache[v]
    if c then return c end
    c = D.parse(shortest_number(v))
    if num_cache_n < 256 then num_cache[v] = c; num_cache_n = num_cache_n + 1 end
    return c
  end
  return D.parse(tostring(v or 0))
end

local function scale10(d, k)
  if k <= 0 then return d end
  local sh, rem = math.floor(k / LOG), k % LOG
  local mul = 1
  for _ = 1, rem do mul = mul * 10 end
  local out, carry = {}, 0
  for i = 1, #d do
    local v = d[i] * mul + carry
    out[i] = v % BASE
    carry = math.floor(v / BASE)
  end
  if carry > 0 then out[#out + 1] = carry end
  for _ = 1, sh do table.insert(out, 1, 0) end
  return trim(out)
end

local function cmp(a, b)
  if #a ~= #b then return #a < #b and -1 or 1 end
  for i = #a, 1, -1 do if a[i] ~= b[i] then return a[i] < b[i] and -1 or 1 end end
  return 0
end

local function add_d(a, b)
  local out, carry = {}, 0
  local n = math.max(#a, #b)
  for i = 1, n do
    local v = (a[i] or 0) + (b[i] or 0) + carry
    out[i] = v % BASE
    carry = math.floor(v / BASE)
  end
  if carry > 0 then out[#out + 1] = carry end
  return out
end

local function sub_d(a, b)
  local out, borrow = {}, 0
  for i = 1, #a do
    local v = a[i] - (b[i] or 0) - borrow
    if v < 0 then v = v + BASE; borrow = 1 else borrow = 0 end
    out[i] = v
  end
  return trim(out)
end

local function mul_d(a, b)
  local out = {}
  for i = 1, #a + #b do out[i] = 0 end
  for i = 1, #a do
    local x, carry = a[i], 0
    for j = 1, #b do
      local idx = i + j - 1
      local v = out[idx] + x * b[j] + carry
      out[idx] = v % BASE
      carry = math.floor(v / BASE)
    end
    local idx = i + #b
    while carry > 0 do
      local v = out[idx] + carry
      out[idx] = v % BASE
      carry = math.floor(v / BASE)
      idx = idx + 1
    end
  end
  return trim(out)
end

local function align(a, b)
  local e = math.min(a.e, b.e)
  return scale10(a.d, a.e - e), scale10(b.d, b.e - e), e
end

function D.add(a, b)
  a, b = D.new(a), D.new(b)
  if D.is_nan(a) or D.is_nan(b) then return nan() end
  if D.is_inf(a) or D.is_inf(b) then
    if D.is_inf(a) and D.is_inf(b) and a.sign ~= b.sign then return nan() end
    return D.is_inf(a) and a or b
  end
  local ad, bd, e = align(a, b)
  local d, sign
  if a.sign == b.sign then d, sign = add_d(ad, bd), a.sign
  else
    local c = cmp(ad, bd)
    if c == 0 then return z() end
    if c > 0 then d, sign = sub_d(ad, bd), a.sign
    else d, sign = sub_d(bd, ad), b.sign end
  end
  return round(sign, d, e)
end

function D.sub(a, b)
  b = D.new(b)
  if D.is_nan(b) then return nan() end
  if D.is_inf(b) then return inf(b.sign == 1 and -1 or 1) end
  return D.add(D.new(a), { sign = -b.sign, d = b.d, e = b.e })
end

function D.mul(a, b)
  a, b = D.new(a), D.new(b)
  if D.is_nan(a) or D.is_nan(b) then return nan() end
  if D.is_inf(a) or D.is_inf(b) then
    if (not D.is_inf(a) and a.d[1] == 0) or (not D.is_inf(b) and b.d[1] == 0) then return nan() end
    return inf(a.sign * b.sign)
  end
  return round(a.sign * b.sign, mul_d(a.d, b.d), a.e + b.e)
end

-- base-1e7 长除：高端数组，补 extra 个 0 limb。
local function high(d)
  local h = {}
  for i = #d, 1, -1 do h[#h + 1] = d[i] end
  return h
end
local function htrim(a)
  while #a > 1 and a[1] == 0 do table.remove(a, 1) end
  return a
end
local function hcmp(a, b)
  if #a ~= #b then return #a < #b and -1 or 1 end
  for i = 1, #a do if a[i] ~= b[i] then return a[i] < b[i] and -1 or 1 end end
  return 0
end
local function hsub(a, b)
  local out, borrow = {}, 0
  local i, j = #a, #b
  while i >= 1 do
    local v = a[i] - (j >= 1 and b[j] or 0) - borrow
    if v < 0 then v = v + BASE; borrow = 1 else borrow = 0 end
    out[i] = v
    i = i - 1; j = j - 1
  end
  return htrim(out)
end
local function hmul(b, q)
  if q == 0 then return { 0 } end
  local out, carry = {}, 0
  for i = #b, 1, -1 do
    local v = b[i] * q + carry
    out[i] = v % BASE
    carry = math.floor(v / BASE)
  end
  if carry > 0 then table.insert(out, 1, carry) end
  return htrim(out)
end
local function div_limbs(a, b, extra)
  local A, B = high(a), high(b)
  for _ = 1, extra do A[#A + 1] = 0 end
  local q, rem = {}, { 0 }
  for i = 1, #A do
    rem[#rem + 1] = A[i]
    rem = htrim(rem)
    local bh = B[1]
    local qd = 0
    if bh > 0 then
      -- 二分求 0..BASE-1 的商 limb；不能从估值逐格下调（会巨大循环）。
      local lo, hi = 0, BASE - 1
      while lo < hi do
        local mid = math.floor((lo + hi + 1) / 2)
        local t = hmul(B, mid)
        if hcmp(rem, t) >= 0 then lo = mid else hi = mid - 1 end
      end
      qd = lo
      rem = hsub(rem, hmul(B, qd))
    end
    q[#q + 1] = qd
  end
  local low = {}
  for i = #q, 1, -1 do low[#low + 1] = q[i] end
  return trim(low)
end

function D.div(a, b)
  a, b = D.new(a), D.new(b)
  if D.is_nan(a) or D.is_nan(b) then return nan() end
  if D.is_inf(a) or D.is_inf(b) then
    if D.is_inf(a) and D.is_inf(b) then return nan() end
    if D.is_inf(b) then return z() end
    return inf(a.sign * b.sign)
  end
  if b.d[1] == 0 and #b.d == 1 then
    if a.d[1] == 0 and #a.d == 1 then return nan() end
    return inf(a.sign * b.sign)
  end
  if a.d[1] == 0 and #a.d == 1 then return z() end
  local extra = 4
  local q = div_limbs(a.d, b.d, extra)
  return round(a.sign * b.sign, q, a.e - b.e - extra * LOG)
end

function D.to_number(x)
  x = D.new(x)
  if D.is_nan(x) then return 0 / 0 end
  if D.is_inf(x) then return x.sign > 0 and math.huge or -math.huge end
  if #x.d == 1 and x.d[1] == 0 then return 0 end
  return tonumber((x.sign < 0 and "-" or "") .. digits_of(x.d) .. "e" .. tostring(x.e)) or 0
end

function D.to_string(x)
  x = D.new(x)
  if D.is_nan(x) then return "NaN" end
  if D.is_inf(x) then return x.sign > 0 and "Infinity" or "-Infinity" end
  if #x.d == 1 and x.d[1] == 0 then return "0" end
  local s = digits_of(x.d)
  local point = #s + x.e
  local out
  if point <= 0 then out = "0." .. string.rep("0", -point) .. s
  elseif point >= #s then out = s .. string.rep("0", point - #s)
  else out = s:sub(1, point) .. "." .. s:sub(point + 1) end
  if x.sign < 0 then out = "-" .. out end
  return out
end

function D.round_digits(sign, digits, e) return round(sign, limbs_from(tostring(digits)), e) end
return D
