-- monitor 布局纯函数：舞台→窗口，只乘一次 fit 和一次 widget scale
package.path = "./?.lua;" .. package.path
local L = require("rt.host.monitor_layout")
local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if type(got) == "number" then got = math.floor(got * 1000 + 0.5) / 1000 end
  if type(want) == "number" then want = math.floor(want * 1000 + 0.5) / 1000 end
  if got ~= want then fails = fails + 1; print(("  FAIL %-34s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else print(("  ok   %-34s %s"):format(desc, tostring(got))) end
end
local g = { stage_w = 900, stage_h = 562 }
local host = { fit = 0.5, ox = 100, oy = 50 }
function host:world_to_screen(x, y)
  return self.ox + (x + g.stage_w / 2) * self.fit, self.oy + (g.stage_h / 2 - y) * self.fit
end
local m = { position = { x = 0, y = 0 }, scale = 1 }
local x, y, w, h, font, fit = L.stage_rect(host, g, m, 120, 64, 16)
check("fit", fit, 0.5)
check("origin x", x, 100)
check("origin y", y, 50)
check("width fit", w, 60)
check("height fit", h, 32)
check("font fit", font, 8)
m.scale = 2
x, y, w, h, font = L.stage_rect(host, g, m, 120, 64, 16)
check("scale 2 width (no double)", w, 120)
check("scale 2 height", h, 64)
check("scale 2 font", font, 16)
m.position = { x = 880, y = 500 }; m.scale = 1
x, y, w, h = L.stage_rect(host, g, m, 120, 64, 16)
check("clamp right", x + w <= 100 + 900 * 0.5 + 0.001, true)
check("clamp bottom", y + h <= 50 + 562 * 0.5 + 0.001, true)

-- 变量行：名称让位、值框不越出面板右边界
local name_w, vx, vw = L.variable_columns(0, 200, 40, 32, 1)
check("columns name", name_w, 40)
check("columns vx", vx, 158)
check("columns vw", vw, 32)
name_w, vx, vw = L.variable_columns(100, 200, 500, 32, 1)
check("long name shrinks", name_w, 134)
check("long name vx", vx, 258)
check("long name vw", vw, 32)
check("long name right edge", vx + vw, 200 + 100 - 10)
-- 内边距按最终缩放走（与 stage_rect 的 s 一致）
name_w, vx, vw = L.variable_columns(0, 100, 20, 32, 0.5)
check("scaled name", name_w, 20)
check("scaled vx", vx, 63)
check("scaled vw", vw, 32)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
