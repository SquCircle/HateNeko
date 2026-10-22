-- 画笔积木盒 headless：颜色 HSV/粗细/落笔/文字印章/图片印章/笔层/清空
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/pen.lua"))(), host)
local cat
for _, e in ipairs(g.entities) do if e.name == "编程猫" then cat = e end end

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-46s %s"):format(desc, tostring(got)))
  end
end
local function has(s, sub) return type(s) == "string" and s:find(sub, 1, true) ~= nil end

check("舞台宽", g.stage_w, 900)
check("舞台高", g.stage_h, 562)
check("编程猫存在", cat ~= nil, true)
rt.start()
for _ = 1, 200 do rt.step(1 / 60) end

check("循环变量 i 已增长", g.vars["d5e2984f-0be4-4324-bd68-107d3ab89339"] > 0, true)
check("画笔颜色离开初始红", cat.pen.color ~= "#ff0000", true)
check("HSV 色相已变化", cat.pen.hsl and cat.pen.hsl[1] > 0, true)
check("笔粗已变化", cat.pen.size > 1, true)
check("笔粗不超过 1000", cat.pen.size <= 1000, true)
check("落笔 dot 已产生", #(host.pen_events or {}) > 0, true)

local stamps = host.stamps or {}
check("文字印章有 M/L--/--R/█", #stamps >= 4, true)
if stamps[1] then
  check("M 居中/50", stamps[1].text .. "/" .. tostring(stamps[1].align) .. "/" .. tostring(stamps[1].size), "M/center/50")
  check("L-- 右对齐/75", stamps[2].text .. "/" .. tostring(stamps[2].align) .. "/" .. tostring(stamps[2].size), "L--/right/75")
  check("--R 左对齐/25", stamps[3].text .. "/" .. tostring(stamps[3].align) .. "/" .. tostring(stamps[3].size), "--R/left/25")
  check("█ 居中/100", stamps[4].text .. "/" .. tostring(stamps[4].align) .. "/" .. tostring(stamps[4].size), "█/center/100")
  check("印章颜色为画笔色", has(stamps[1].color, "#"), true)
  check("文字印章方向随角色", stamps[1].dir, 1)
  check("▓方向为0", stamps[4].dir, 0)
end

local pstamps = host.pen_stamps or {}
check("图片印章已调用", #pstamps > 0, true)
if pstamps[1] then
  check("图片印章有 style", pstamps[1].style ~= nil, true)
end

local layers = host.pen_layer_events or {}
check("笔层切换已发生", #layers >= 2, true)
if layers[1] and layers[2] then
  check("笔层出现 bottom", layers[1].mode, "bottom")
  check("笔层出现 peak", layers[2].mode, "peak")
end

-- 点击屏幕：clear_drawing
host:click(0, 0)
host:on_mouse_released(0, 0)
for _ = 1, 3 do rt.step(1 / 60) end
check("点击清空画笔", (host.pen_clears or 0) > 0, true)

-- 画笔属性口径：alpha 是透明度；size clamp 1..1000
local ML = require("rt.impl.motion_looks")
ML.self_set_pen_color_property(cat, { scope = "alpha", val = 100 })
check("透明度100→alpha 0", cat.pen.alpha, 0)
ML.self_set_pen_color_property(cat, { scope = "alpha", val = 0 })
check("透明度0→alpha 1", cat.pen.alpha, 1)
ML.self_set_pen_color_property(cat, { scope = "alpha", val = 50 })
check("透明度50→alpha .5", cat.pen.alpha, 0.5)
ML.self_change_pen_color_property(cat, { scope = "alpha", steps = 10, increase = "increase" })
check("透明度增加→alpha 减", cat.pen.alpha, 0.4)
ML.self_set_pen_size(cat, { size = 2000 })
check("笔粗上限1000", cat.pen.size, 1000)
ML.self_set_pen_size(cat, { size = 0 })
check("笔粗下限1", cat.pen.size, 1)
ML.self_set_pen_color(cat, { color = "#ff0000" })
check("红色 HSL 色相0", cat.pen.hsl and cat.pen.hsl[1], 0)
ML.self_set_pen_color_property(cat, { scope = "brightness", val = 50 })
check("HSV 亮度50→深红", cat.pen.color, "#800000")
ML.self_set_pen_color(cat, { color = "#ff0000" })
ML.self_set_pen_color_property(cat, { scope = "saturation", val = 0 })
check("HSV 饱和度0→白", cat.pen.color, "#ffffff")
ML.self_set_pen_size(cat, { size = 1000 })
ML.self_change_pen_size(cat, { steps = 5, increase = "increase" })
check("笔粗增加 clamp 1000", cat.pen.size, 1000)
ML.self_set_pen_size(cat, { size = 1 })
ML.self_change_pen_size(cat, { steps = 5, increase = "decrease" })
check("笔粗减少 clamp 1", cat.pen.size, 1)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
