-- 原语级追踪：包装若干关键原语，打印「参数 → 返回值」，用来定位语义差异
-- 用法: lua5.1 tests/trace_prims.lua <编译产物.lua> <帧数> [输入框内容文件]
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local path = arg[1] or "/tmp/vm.lua"
local frames = tonumber(arg[2]) or 3
local ask = arg[3]
local src = assert(io.open(path, "rb")):read("*a")
local work = assert((loadstring or load)(src, "@compiled"))()

local host = Headless.new()
if ask then
  local h = io.open(ask)
  if h then host.ask_value = h:read("*a") h:close() end
end
rt.set_host(host)
local game = rt.load(work, host)

-- 关键原语加日志（rt.f 与生成代码里捕获的是同一张表，改这张表即可生效）
local WATCH = {
  "text_split", "list_item", "list_get", "list_length", "list_index_of", "list_is_exist",
  "list_append", "replace_list_item", "console_log", "variables_set", "variables_get",
  "script_variables", "script_variables_value", "logic_compare", "text_select",
  -- 求值链相关（排查"节点被当成值"时很有用）
  "text_join", "math_arithmetic", "convert_type", "logic_operation", "logic_negate",
  "temporary_list", "delete_list_item", "list_insert_value", "pure_list_get", "calculate",
}
local function brief(v, depth)
  if type(v) ~= "table" then
    if type(v) == "string" then return ("%q"):format(v:sub(1, 24)) end
    return tostring(v)
  end
  if depth > 1 then return "{...}" end
  local parts, n = {}, 0
  for k, vv in pairs(v) do
    n = n + 1
    if n > 5 then parts[#parts + 1] = "…" break end
    parts[#parts + 1] = tostring(k) .. "=" .. brief(vv, depth + 1)
  end
  return "{" .. table.concat(parts, ", ") .. "}"
end

for _, name in ipairs(WATCH) do
  local orig = rt.f[name]
  if orig then
    rt.f[name] = function(self, args, th)
      local r = orig(self, args, th)
      print(("[%s] %s → %s"):format(name, brief(args, 1), brief(r, 1)))
      return r
    end
  end
end

rt.start()
local ui = require("rt.impl.ui")
for i = 1, frames do
  rt.step(1 / 60)
  local d = ui.current_dialog(game)
  if d and d.type == "ask" and host.ask_value ~= nil then ui.submit_answer(host.ask_value, game) end
end
print(("--- 跑了 %d 帧，印章 %d 条"):format(frames, #(host.stamps or {})))
