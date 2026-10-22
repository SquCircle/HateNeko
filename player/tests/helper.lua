-- 测试辅助：读取 Python 编译期生成的产物（Lua 侧不再有编译器）
local M = {}
local json = require("rt.json")

local function read(path)
  local f = assert(io.open(path, "rb"), "找不到编译产物: " .. path .. "（先跑 python3 tools/precompile.py）")
  local s = f:read("*a")
  f:close()
  return s
end

--- 编译后的 Lua 源码文本
function M.source(name)
  return read("tests/fixtures/compiled/" .. name .. ".lua")
end

--- 载入编译产物（返回 M 表）
function M.compiled(name)
  local chunk = assert((loadstring or load)(M.source(name), "@" .. name))
  return chunk()
end

--- Python 编译期报告（hats/calls/unknown/literals）
function M.report(name)
  return json.decode(read("tests/fixtures/compiled/" .. name .. ".report.json"))
end

return M
