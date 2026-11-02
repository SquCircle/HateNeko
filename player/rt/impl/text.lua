-- 文本（连接/切分/取段/长度/类型转换）（来自 op_sensing.lua）


local V = require("rt.values")
local M = {}


function M.text(self, args)
  return V.str(args.TEXT or args.text)
end

M.shadow_text = M.text

function M.default_value(self, args)
  -- 官方 default_value：`i=e.TEXT; a=Number(i); return isNaN(a) ? i : a`
  -- （数字文本 → Number，非数字 → 原样；原来读 args.VALUE 永远拿不到 TEXT）
  local raw = args.TEXT
  if raw == nil then raw = args.text end
  if raw == nil then raw = args.value end
  if raw == nil then return nil end
  local n = V.js_number(raw)
  if V.js_number_is_nan(n) then return raw end
  return n
end

---------------------------------------------------------------- 运算
-- 本任务要求：四则使用 Lua 原生；保留 JS 字符串 add/NaN/Infinity 语义。

-- 预生成的连续键名（ADD0/ITEM0…），避免每次 pairs+match+sort
local ADD_KEYS = {}
for i = 1, 512 do ADD_KEYS[i] = "ADD" .. (i - 1) end
local join_key_cache = setmetatable({}, { __mode = "k" }) -- 常量 args 表复用

local function join_any(args)
  local items = args.items
  if type(items) == "table" then
    local out = {}
    for i = 1, #items do out[i] = V.str(items[i]) end
    return table.concat(out)
  end
  -- 快路径 1：常量表缓存
  local cached = join_key_cache[args]
  if cached then
    local out = {}
    for i = 1, #cached do out[i] = V.str(args[cached[i]]) end
    return table.concat(out)
  end
  -- 快路径 2：ADD0..ADD(n-1) 连续且没有其它键（编译产物绝大多数如此）
  local n = 0
  while args[ADD_KEYS[n + 1]] ~= nil do n = n + 1 end
  if n > 0 then
    local cnt = 0
    for _ in pairs(args) do cnt = cnt + 1 end
    if cnt == n then
      local keys, out = {}, {}
      for i = 1, n do keys[i] = ADD_KEYS[i]; out[i] = V.str(args[ADD_KEYS[i]]) end
      join_key_cache[args] = keys
      return table.concat(out)
    end
  end
  -- 通用路径：收集所有「前缀+数字」形态的键，按数字排序
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

-- 官方 text_split（heart）player.main:2154100：
--   `String(TEXT_TO_SPLIT).split(SPLIT_TEXT).map(chunk => Number(chunk) || chunk)`
--   ★ 分隔符为空串时 `split("")` 是**按 UTF-16 码元**切（不是按 Lua 字节）：
--     "ab中文" → 4 项；"a😀b" → 4 项（emoji 占 2 个码元）。
--     旧实现 `text:sub(i,i)` 按字节切，中文会碎成 6 个坏字节、emoji 碎成 4 段。
--   切分后仍把"trim 后非空"的片段转数值（"1"→1，"a"→"a"，空白原样）。
function M.text_split(self, args)
  local text = args.TEXT_TO_SPLIT
  if text == nil then text = args.text end
  text = V.str(text)
  local sep = V.str(args.SPLIT_TEXT or args.sep)
  local raw = {}
  if sep == "" then
    raw = V.utf16_split_units(text)
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
  -- 官方 text_contain（player.main:4651647 一带的 domain 表）：
  --   `void 0!==A && void 0!==B && null!==A && null!==B
  --    && !Number.isNaN(A) && !Number.isNaN(B) && A.toString().includes(B)`
  -- → 任一侧是 NaN / 缺失都返回 false（不能把 NaN 转成 "NaN" 再互相包含）。
  local a = args.text
  if a == nil then a = args.A end
  if a == nil then a = args.a end
  local b = args.substring
  if b == nil then b = args.B end
  if b == nil then b = args.b end
  if a == nil or b == nil then return false end
  if V.js_number_is_nan(a) or V.js_number_is_nan(b) then return false end
  return V.str(a):find(V.str(b), 1, true) ~= nil
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

return M
