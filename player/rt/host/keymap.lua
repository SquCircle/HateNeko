-- JS keyCode <-> LÖVE KeyConstant（两个宿主共用，避免 H-3 的键位表分叉）
--
-- KN 的按键积木存的是浏览器 KeyboardEvent.keyCode（数字字符串）。
-- LÖVE 的键名是 KeyConstant；一个 keyCode 可能对应多个物理键（Shift/Ctrl/Alt/Enter）。
local M = {}

-- code -> { LÖVE 键名, … }（第一个用于反向映射/日志）
M.by_code = {
  ["8"] = { "backspace" },
  ["9"] = { "tab" },
  ["13"] = { "return", "kpenter" },
  ["16"] = { "lshift", "rshift" },
  ["17"] = { "lctrl", "rctrl" },
  ["18"] = { "lalt", "ralt" },
  ["19"] = { "pause" },
  ["20"] = { "capslock" },
  ["27"] = { "escape" },
  ["32"] = { "space" },
  ["33"] = { "pageup" },
  ["34"] = { "pagedown" },
  ["35"] = { "end" },
  ["36"] = { "home" },
  ["37"] = { "left" },
  ["38"] = { "up" },
  ["39"] = { "right" },
  ["40"] = { "down" },
  ["45"] = { "insert" },
  ["46"] = { "delete" },
  ["96"] = { "kp0" }, ["97"] = { "kp1" }, ["98"] = { "kp2" }, ["99"] = { "kp3" },
  ["100"] = { "kp4" }, ["101"] = { "kp5" }, ["102"] = { "kp6" }, ["103"] = { "kp7" },
  ["104"] = { "kp8" }, ["105"] = { "kp9" },
  ["106"] = { "kp*" }, ["107"] = { "kp+" }, ["108"] = { "kp." },
  ["109"] = { "kp-" }, ["110"] = { "kp." },
  ["111"] = { "kp/" },
  ["144"] = { "numlock" },
  ["145"] = { "scrolllock" },
  ["186"] = { ";" }, ["187"] = { "=" }, ["188"] = { "," }, ["189"] = { "-" },
  ["190"] = { "." }, ["191"] = { "/" }, ["192"] = { "`" },
  ["219"] = { "[" }, ["220"] = { "\\" }, ["221"] = { "]" }, ["222"] = { "'" },
}
for i = 0, 9 do M.by_code[tostring(48 + i)] = { tostring(i) } end
for c = string.byte("a"), string.byte("z") do
  M.by_code[tostring(c - 32)] = { string.char(c) }
end
for i = 1, 12 do M.by_code[tostring(111 + i)] = { "f" .. i } end

M.name_to_code = {}
for code, names in pairs(M.by_code) do
  for _, name in ipairs(names) do
    if M.name_to_code[name] == nil then M.name_to_code[name] = code end
  end
end
-- kpenter 与 return 同码；显式保留（上面的循环遇到同名不会覆盖）
M.name_to_code["kpenter"] = "13"

function M.primary_name(code)
  local names = M.by_code[tostring(code)]
  return names and names[1] or nil
end

return M
