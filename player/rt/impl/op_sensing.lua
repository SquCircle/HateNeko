-- 兼容层（2026-10-24 模块化）：原语已按域拆到 math/text/sensing/time/screen。
-- 运行期注册看 rt/init.lua；本文件只保留给旧 `require("rt.impl.op_sensing")`（测试/工具）。
local M = {}
for _, name in ipairs({ "math", "text", "sensing", "time", "screen" }) do
  for k, v in pairs(require("rt.impl." .. name)) do M[k] = v end
end
return M
