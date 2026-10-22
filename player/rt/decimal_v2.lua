-- Decimal v2：上一轮排名胜出的 cond_identity。
-- add/sub/div 用 fixed3；mul 用 limb；安全整数/0/1 走原生。
local A = require("rt.decimal_fixed3")
local L = require("rt.decimal_limb")

local V = {}
local SAFE = 9007199254740991

local function is_int(n)
  return type(n) == "number" and n == math.floor(n) and math.abs(n) <= SAFE
end

local function fast(a, b, op)
  if is_int(a) and is_int(b) then
    local r
    if op == "add" then r = a + b
    elseif op == "sub" then r = a - b
    elseif op == "mul" then r = a * b
    elseif op == "div" then
      if b ~= 0 and a % b == 0 then r = a / b end
    end
    if r and r == math.floor(r) and math.abs(r) <= SAFE then return r end
  end
  if op == "add" then
    if b == 0 then return a end
  elseif op == "sub" then
    if b == 0 then return a end
  elseif op == "mul" then
    if a == 0 or b == 0 then return 0 end
    if a == 1 then return b end
    if b == 1 then return a end
  elseif op == "div" then
    if b == 1 then return a end
    if a == 0 and b ~= 0 then return 0 end
  end
end

function V.add(a, b)
  local r = fast(a, b, "add"); if r ~= nil then return r end
  return A.add(a, b)
end
function V.sub(a, b)
  local r = fast(a, b, "sub"); if r ~= nil then return r end
  return A.sub(a, b)
end
function V.mul(a, b)
  local r = fast(a, b, "mul"); if r ~= nil then return r end
  return L.mul(a, b)
end
function V.div(a, b)
  local r = fast(a, b, "div"); if r ~= nil then return r end
  return A.div(a, b)
end
V.new = A.new
V.to_number = A.to_number
V.to_string = A.to_string
return V
