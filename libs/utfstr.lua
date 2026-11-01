-- utfstr：通用 UTF-8 字符串索引库（播放器 / AtLua 共用）
--
-- 目标：把「按 UTF-16 码元 / 码点 取字符、切片、求长度」从 O(下标×字符串长度)
--       降到 O(log 块数 + 块内字符数)，并且**第一次使用某字符串时才建索引**，之后缓存。
--
-- 语义（与播放器官方 JS 一致）：
--   * UTF-16 码元视图：中文 1 码元、emoji 2 码元；代理对中间取字符 → U+FFFD；
--   * 码点视图：UTF-8 码点计数（AtLua 用）；
--   * 非法 UTF-8：每个坏字节记 1 码元 / 1 码点，显示为 U+FFFD（宽容解码）。
--
-- 索引结构（每个字符串一份，LRU 缓存）：
--   entry = { s, ascii, units, cps, block,
--             chk_u = {0, ...}, chk_cp = {0, ...}, chk_b = {1, ...} }
--   chk_* 记录每个块起点的「码元下标 / 码点下标 / 字节位置」，块内最多 block 个字符。
--   纯 ASCII 字符串不建任何表（units = cps = #s，字节 == 码元）。
--
-- 依赖：纯 Lua 5.1；若宿主提供 _G.utf8（LÖVE 自带），建表时用它加速，出错自动回落。

local U = { VERSION = "1.0.0" }

local REPLACEMENT = "\239\191\189" -- U+FFFD

local BLOCK_MIN, BLOCK_MAX = 32, 256
local cache = {}                   -- MRU 在前
local cache_n = 0
local cache_size = 16
local stats = { builds = 0, hits = 0, misses = 0, evictions = 0 }

local utf8lib = rawget(_G, "utf8")
if not utf8lib then
  local ok_utf, mod = pcall(require, "utf8") -- LÖVE 自带 utf8 是通过 require("utf8") 导入
  if ok_utf and type(mod) == "table" then utf8lib = mod end
end

-- 宽容 UTF-8 解码：返回 (codepoint, next_byte_pos)；非法序列 → (U+FFFD, i+1)
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

-- 严格 RFC 3629 校验（与 At.components.Label.safe_utf8 相同的规则）
local function strict_len_at(s, i)
  local c = s:byte(i)
  if c == nil then return 0 end
  local function cont(j)
    local x = s:byte(j)
    return x ~= nil and x >= 0x80 and x <= 0xBF
  end
  local function range(j, lo, hi)
    local x = s:byte(j)
    return x ~= nil and x >= lo and x <= hi
  end
  if c < 0x80 then return 1 end
  if c >= 0xC2 and c <= 0xDF then
    if cont(i + 1) then return 2 end
  elseif c == 0xE0 then
    if range(i + 1, 0xA0, 0xBF) and cont(i + 2) then return 3 end
  elseif c >= 0xE1 and c <= 0xEC then
    if cont(i + 1) and cont(i + 2) then return 3 end
  elseif c == 0xED then
    if range(i + 1, 0x80, 0x9F) and cont(i + 2) then return 3 end
  elseif c >= 0xEE and c <= 0xEF then
    if cont(i + 1) and cont(i + 2) then return 3 end
  elseif c == 0xF0 then
    if range(i + 1, 0x90, 0xBF) and cont(i + 2) and cont(i + 3) then return 4 end
  elseif c >= 0xF1 and c <= 0xF3 then
    if cont(i + 1) and cont(i + 2) and cont(i + 3) then return 4 end
  elseif c == 0xF4 then
    if range(i + 1, 0x80, 0x8F) and cont(i + 2) and cont(i + 3) then return 4 end
  end
  return 0
end

local function strict_valid(s)
  local i, n = 1, #s
  while i <= n do
    local len = strict_len_at(s, i)
    if len == 0 then return false end
    i = i + len
  end
  return true
end

local function strict_sanitize(s)
  local out = {}
  local i, n = 1, #s
  while i <= n do
    local len = strict_len_at(s, i)
    if len == 0 then
      out[#out + 1] = "?"
      i = i + 1
    else
      out[#out + 1] = s:sub(i, i + len - 1)
      i = i + len
    end
  end
  return table.concat(out)
end

-- 纯 ASCII 判定：逐字节；590KB 约 0.7ms（比 string.find 的 C 模式快一个量级）
local function scan_ascii(s)
  local byte = string.byte
  for i = 1, #s do
    if byte(s, i) >= 128 then return false end
  end
  return true
end

-- 在一个块里从 (units, pos) 开始找包含下标 idx 的码点
-- 返回 sb, u1, u2, eb（u2 = u1 + 码元数）
local function locate_unit(e, idx)
  local cu, cb = e.chk_u, e.chk_b
  local lo, hi = 1, #cu
  while lo < hi do
    local mid = math.floor((lo + hi + 1) / 2)
    if cu[mid] <= idx then lo = mid else hi = mid - 1 end
  end
  local units, pos = cu[lo], cb[lo]
  local s = e.s
  while true do
    local cp, ni = utf8_next(s, pos)
    local u = (cp >= 0x10000) and 2 or 1
    if idx < units + u then return pos, units, units + u, ni - 1 end
    units = units + u
    pos = ni
  end
end

local function locate_cp(e, cp0)
  local cc, cb = e.chk_cp, e.chk_b
  local lo, hi = 1, #cc
  while lo < hi do
    local mid = math.floor((lo + hi + 1) / 2)
    if cc[mid] <= cp0 then lo = mid else hi = mid - 1 end
  end
  local cps, pos = cc[lo], cb[lo]
  local s = e.s
  while true do
    local cp, ni = utf8_next(s, pos)
    if cps == cp0 then
      local u = (cp >= 0x10000) and 2 or 1
      return pos, ni - 1, u
    end
    cps = cps + 1
    pos = ni
  end
end

-- 建索引（首次使用时调用）
local function build(s)
  local n = #s
  if scan_ascii(s) then
    stats.builds = stats.builds + 1
    return { s = s, ascii = true, units = n, cps = n, block = BLOCK_MAX, valid = true }
  end

  local block = math.max(BLOCK_MIN, math.min(BLOCK_MAX, math.ceil(n / 4096)))
  local chk_u, chk_cp, chk_b = { 0 }, { 0 }, { 1 }
  local units, cps, i = 0, 0, 1
  local next_u = block

  -- 有 utf8 库且字符串合法时，用 C 层迭代建表（否则走宽容解码）
  local fast = false
  if utf8lib and utf8lib.codes and utf8lib.len then
    local oklen, lenv = pcall(utf8lib.len, s)
    if oklen and lenv then fast = true end
  end

  if fast then
    local ok = pcall(function()
      local pend_pos, pend_cp = nil, nil
      for p, cp in utf8lib.codes(s) do
        if pend_pos then
          local u = (pend_cp >= 0x10000) and 2 or 1
          while units + u >= next_u do
            chk_u[#chk_u + 1] = units + u
            chk_cp[#chk_cp + 1] = cps + 1
            chk_b[#chk_b + 1] = p
            next_u = next_u + block
          end
          units = units + u
          cps = cps + 1
        end
        pend_pos, pend_cp = p, cp
      end
      if pend_pos then
        local u = (pend_cp >= 0x10000) and 2 or 1
        while units + u >= next_u do
          chk_u[#chk_u + 1] = units + u
          chk_cp[#chk_cp + 1] = cps + 1
          chk_b[#chk_b + 1] = n + 1
          next_u = next_u + block
        end
        units = units + u
        cps = cps + 1
      end
    end)
    if not ok then fast = false end
  end

  if not fast then
    chk_u, chk_cp, chk_b = { 0 }, { 0 }, { 1 }
    units, cps, i = 0, 0, 1
    next_u = block
    while i <= n do
      local cp, ni = utf8_next(s, i)
      local u = (cp >= 0x10000) and 2 or 1
      while units + u >= next_u do
        chk_u[#chk_u + 1] = units + u
        chk_cp[#chk_cp + 1] = cps + 1
        chk_b[#chk_b + 1] = ni
        next_u = next_u + block
      end
      units = units + u
      cps = cps + 1
      i = ni
    end
  end

  stats.builds = stats.builds + 1
  return { s = s, ascii = false, units = units, cps = cps, block = block,
           valid = strict_valid(s), chk_u = chk_u, chk_cp = chk_cp, chk_b = chk_b }
end

-- 取缓存项（MRU 提升；未命中则建）
local function get(s)
  for i = 1, cache_n do
    local e = cache[i]
    if e.s == s then
      if i > 1 then
        table.remove(cache, i)
        table.insert(cache, 1, e)
      end
      stats.hits = stats.hits + 1
      return e
    end
  end
  stats.misses = stats.misses + 1
  local e = build(s)
  table.insert(cache, 1, e)
  if #cache > cache_size then
    cache[#cache] = nil
    stats.evictions = stats.evictions + 1
  end
  cache_n = #cache
  return e
end

local function str_of(v)
  if type(v) == "string" then return v end
  if v == nil then return "" end
  return tostring(v)
end

function U.units(v) return get(str_of(v)).units end
function U.codepoints(v) return get(str_of(v)).cps end
function U.byte_len(v) return #str_of(v) end
function U.is_ascii(v) return get(str_of(v)).ascii end

function U.char_at_unit(v, idx0)
  local s = str_of(v)
  if type(idx0) ~= "number" or idx0 ~= idx0 then return nil end
  idx0 = math.floor(idx0)
  local e = get(s)
  if idx0 < 0 or idx0 >= e.units then return nil end
  if e.ascii then return s:sub(idx0 + 1, idx0 + 1) end
  local sb, u1, u2, eb = locate_unit(e, idx0)
  if idx0 == u1 then return s:sub(sb, eb) end
  return REPLACEMENT
end

local function clamp_int(x, units)
  if type(x) ~= "number" or x ~= x then return 0 end
  if x == math.huge then return units end
  if x == -math.huge then return -units end
  if x >= 0 then x = math.floor(x) else x = math.ceil(x) end
  if x < 0 then return 0 end
  if x > units then return units end
  return x
end

function U.substr_units(v, start0, end0)
  local s = str_of(v)
  local e = get(s)
  local a = clamp_int(start0, e.units)
  local b = clamp_int(end0, e.units)
  if a > b then a, b = b, a end
  if e.ascii then
    if a >= b then return "" end
    return s:sub(a + 1, b)
  end
  if a >= e.units then return "" end

  local out = {}
  local pos, u1, u2, eb = locate_unit(e, a)
  local ucur = u1
  if a > u1 then
    out[#out + 1] = REPLACEMENT
    ucur = u2
    pos = eb + 1
  end
  while ucur < b do
    local cp, ni = utf8_next(s, pos)
    local cu = (cp >= 0x10000) and 2 or 1
    if ucur + cu <= b then
      out[#out + 1] = s:sub(pos, ni - 1)
    else
      out[#out + 1] = REPLACEMENT
    end
    ucur = ucur + cu
    pos = ni
  end
  return table.concat(out)
end

function U.char_at_cp(v, cp0)
  local s = str_of(v)
  if type(cp0) ~= "number" or cp0 ~= cp0 then return nil end
  cp0 = math.floor(cp0)
  local e = get(s)
  if cp0 < 0 or cp0 >= e.cps then return nil end
  if e.ascii then return s:sub(cp0 + 1, cp0 + 1) end
  local sb, eb = locate_cp(e, cp0)
  return s:sub(sb, eb)
end

function U.substr_cp(v, start0, end0)
  local s = str_of(v)
  local e = get(s)
  local a = clamp_int(start0, e.cps)
  local b = clamp_int(end0, e.cps)
  if a > b then a, b = b, a end
  if a >= b then return "" end
  if e.ascii then return s:sub(a + 1, b) end
  local sb = select(1, locate_cp(e, a))
  local eb = select(2, locate_cp(e, b - 1))
  return s:sub(sb, eb)
end

-- 删除最后一个码点（AtLua 输入框退格）
function U.remove_last_cp(v)
  local s = str_of(v)
  if #s == 0 then return s end
  local e = get(s)
  if e.cps == 0 then return "" end
  if e.ascii then return s:sub(1, #s - 1) end
  local sb = select(1, locate_cp(e, e.cps - 1))
  return s:sub(1, sb - 1)
end

function U.reverse_units(v)
  local s = str_of(v)
  if #s == 0 then return s end
  local e = get(s)
  if e.ascii then return s:reverse() end
  local parts = {}
  local pos = 1
  while pos <= #s do
    local _, ni = utf8_next(s, pos)
    parts[#parts + 1] = s:sub(pos, ni - 1)
    pos = ni
  end
  local out = {}
  for i = #parts, 1, -1 do out[#out + 1] = parts[i] end
  return table.concat(out)
end

function U.split_units(v)
  local s = str_of(v)
  local e = get(s)
  local out = {}
  if e.ascii then
    for i = 1, #s do out[i] = s:sub(i, i) end
    return out
  end
  local pos, units = 1, 0
  while pos <= #s do
    local cp, ni = utf8_next(s, pos)
    local u = (cp >= 0x10000) and 2 or 1
    out[units + 1] = s:sub(pos, ni - 1)
    if u == 2 then out[units + 2] = "" end
    units = units + u
    pos = ni
  end
  for i = 1, e.units do
    if out[i] == nil then out[i] = "" end
  end
  return out
end

function U.valid(v)
  local s = str_of(v)
  return get(s).valid == true
end

-- 严格清洗：非法字节替换为 "?"（与 At.components.Label.safe_utf8 行为一致）
function U.sanitize(v)
  local s = str_of(v)
  if #s == 0 then return s end
  if get(s).valid then return s end
  return strict_sanitize(s)
end

-- 码点索引（0 基）→ 起始字节偏移（0 基，落在末尾时返回 #s）
function U.cp_byte_offset(v, cp0)
  local s = str_of(v)
  if type(cp0) ~= "number" or cp0 ~= cp0 then return 0 end
  cp0 = math.floor(cp0)
  if cp0 <= 0 then return 0 end
  local e = get(s)
  if cp0 >= e.cps then return #s end
  if e.ascii then return cp0 end
  local sb = select(1, locate_cp(e, cp0))
  return sb - 1
end

-- 字节偏移（0 基）之前有多少个完整码点（落在码点中间时向下取整）
function U.cp_index_at_byte(v, byte0)
  local s = str_of(v)
  byte0 = tonumber(byte0) or 0
  if byte0 <= 0 then return 0 end
  local e = get(s)
  if byte0 >= #s then return e.cps end
  if e.ascii then return byte0 end
  local cb, cc = e.chk_b, e.chk_cp
  local lo, hi = 1, #cb
  while lo < hi do
    local mid = math.floor((lo + hi + 1) / 2)
    if cb[mid] <= byte0 + 1 then lo = mid else hi = mid - 1 end
  end
  local cps, pos = cc[lo], cb[lo]
  local limit = byte0
  while pos <= limit do
    local cp, ni = utf8_next(s, pos)
    if ni - 1 > limit then break end
    cps = cps + 1
    pos = ni
  end
  return cps
end

-- 码点迭代器（有效 UTF-8 时逐码点）
function U.cps(v)
  local s = str_of(v)
  local e = get(s)
  local i, n = 0, e.cps
  return function()
    if i >= n then return nil end
    i = i + 1
    return U.char_at_cp(s, i - 1)
  end
end

function U.preindex(v) get(str_of(v)) end

function U.configure(opts)
  if type(opts) == "table" then
    if type(opts.cache) == "number" and opts.cache >= 1 then
      cache_size = math.floor(opts.cache)
      while cache_n > cache_size do
        cache[cache_n] = nil
        cache_n = cache_n - 1
      end
    end
    if type(opts.block_min) == "number" then BLOCK_MIN = math.max(4, math.floor(opts.block_min)) end
    if type(opts.block_max) == "number" then BLOCK_MAX = math.max(BLOCK_MIN, math.floor(opts.block_max)) end
  end
end

function U.clear_cache()
  cache = {}
  cache_n = 0
  stats = { builds = 0, hits = 0, misses = 0, evictions = 0 }
end

function U.stats()
  return { builds = stats.builds, hits = stats.hits, misses = stats.misses,
           evictions = stats.evictions, cache = cache_n }
end

return U
