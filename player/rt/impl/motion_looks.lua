-- 兼容层（2026-10-24 模块化）：原语已按域拆到 common/motion/looks/pen。
-- 运行期注册看 rt/init.lua；本文件保留给旧 require（测试、rt/host 的 draw_rotation 等）。
-- 注意：common 里的 clamp_scale/round_to/MAX_SCALE_PCT 等旧字段仍从这里可见。
local M = {}
for _, name in ipairs({ "common", "motion", "looks", "pen" }) do
  for k, v in pairs(require("rt.impl." .. name)) do M[k] = v end
end
return M
