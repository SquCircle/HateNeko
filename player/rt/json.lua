-- 纯 Lua JSON 解码器（只解码，不需要编码）
--
-- 为什么自己写：本项目在 Lua 侧唯一真正缺的库就是 JSON（作品文件是 JSON），
-- 而我们只需要 decode —— 一百多行纯 Lua 就够，Lua5.1 / LuaJIT 都能跑，零依赖。
--
-- 支持：对象 / 数组 / 字符串（含 \uXXXX 与代理对）/ 数字（含指数）/ true/false/null
local json = {}

local char, byte, sub, find, concat = string.char, string.byte, string.sub, string.find, table.concat
local floor = math.floor

local ESCAPE = {
  n = "\n", t = "\t", r = "\r", b = "\b", f = "\f",
  ['"'] = '"', ["\\"] = "\\", ["/"] = "/",
}

local function utf8_encode(cp)
  if cp < 0x80 then
    return char(cp)
  elseif cp < 0x800 then
    return char(0xC0 + floor(cp / 64), 0x80 + cp % 64)
  elseif cp < 0x10000 then
    return char(0xE0 + floor(cp / 4096), 0x80 + floor(cp / 64) % 64, 0x80 + cp % 64)
  end
  return char(
    0xF0 + floor(cp / 262144),
    0x80 + floor(cp / 4096) % 64,
    0x80 + floor(cp / 64) % 64,
    0x80 + cp % 64
  )
end

local QUOTE = 34 -- '"'

function json.decode(text)
  local s = text
  local pos = 1

  local function err(msg)
    local line = 1
    for _ in find(sub(s, 1, pos), "\n", 1, true) and sub(s, 1, pos):gmatch("\n") do line = line + 1 end
    error(("JSON 解析失败：%s（第 %d 行，偏移 %d）"):format(msg, line, pos), 0)
  end

  local function skip()
    local _, e = find(s, "^[ \t\r\n]+", pos)
    if e then pos = e + 1 end
  end

  local parse_value

  local function parse_string()
    -- 进入时 pos 指向开引号之后；退出时 pos 指向闭引号之后
    local parts, np = {}, 0
    local i = pos
    while true do
      local j = find(s, '["\\]', i)
      if not j then err("字符串未闭合") end
      if j > i then
        np = np + 1
        parts[np] = sub(s, i, j - 1)
      end
      if byte(s, j) == QUOTE then
        pos = j + 1
        break
      end

      local e = sub(s, j + 1, j + 1)
      local chunk
      if e == "u" then
        local cp = tonumber(sub(s, j + 2, j + 5), 16)
        if not cp then err("非法 \\u 转义") end
        i = j + 6
        -- 代理对（emoji 等多字节字符）
        if cp >= 0xD800 and cp <= 0xDBFF and sub(s, i, i + 1) == "\\u" then
          local lo = tonumber(sub(s, i + 2, i + 5), 16)
          if lo and lo >= 0xDC00 and lo <= 0xDFFF then
            cp = 0x10000 + (cp - 0xD800) * 0x400 + (lo - 0xDC00)
            i = i + 6
          end
        end
        chunk = utf8_encode(cp)
      else
        chunk = ESCAPE[e]
        if not chunk then err("非法转义 \\" .. tostring(e)) end
        i = j + 2
      end
      np = np + 1
      parts[np] = chunk
    end
    if np == 0 then return "" end
    if np == 1 then return parts[1] end
    return concat(parts)
  end

  local function parse_number()
    local num = s:match("^-?%d+%.?%d*[eE]?[-+]?%d*", pos)
    if not num then err("非法数字") end
    pos = pos + #num
    return tonumber(num)
  end

  local function parse_array()
    pos = pos + 1
    local out, k = {}, 0
    skip()
    if sub(s, pos, pos) == "]" then
      pos = pos + 1
      return out
    end
    while true do
      k = k + 1
      out[k] = parse_value()
      skip()
      local c = sub(s, pos, pos)
      if c == "," then
        pos = pos + 1
        skip()
      elseif c == "]" then
        pos = pos + 1
        return out
      else
        err("数组里期待 , 或 ]")
      end
    end
  end

  local function parse_object()
    pos = pos + 1
    local out = {}
    skip()
    if sub(s, pos, pos) == "}" then
      pos = pos + 1
      return out
    end
    while true do
      if sub(s, pos, pos) ~= '"' then err("对象的键必须是字符串") end
      pos = pos + 1
      local key = parse_string()
      skip()
      if sub(s, pos, pos) ~= ":" then err("对象里期待 :") end
      pos = pos + 1
      out[key] = parse_value()
      skip()
      local c = sub(s, pos, pos)
      if c == "," then
        pos = pos + 1
        skip()
      elseif c == "}" then
        pos = pos + 1
        return out
      else
        err("对象里期待 , 或 }")
      end
    end
  end

  parse_value = function()
    skip()
    local c = sub(s, pos, pos)
    if c == '"' then
      pos = pos + 1
      return parse_string()
    elseif c == "{" then
      return parse_object()
    elseif c == "[" then
      return parse_array()
    elseif c == "t" then
      if sub(s, pos, pos + 3) == "true" then
        pos = pos + 4
        return true
      end
      err("非法字面量")
    elseif c == "f" then
      if sub(s, pos, pos + 4) == "false" then
        pos = pos + 5
        return false
      end
      err("非法字面量")
    elseif c == "n" then
      if sub(s, pos, pos + 3) == "null" then
        pos = pos + 4
        return nil
      end
      err("非法字面量")
    elseif c == "" then
      err("内容意外结束")
    end
    return parse_number()
  end

  local v = parse_value()
  return v
end

return json
