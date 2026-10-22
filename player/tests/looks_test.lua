-- 造型/外观积木 + looks 作品 headless
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/looks.lua"))(), host)
rt.start()
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
local function near(desc, got, want, eps)
  checks = checks + 1
  if math.abs((got or 0) - want) > (eps or 0.01) then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want≈%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-46s %s"):format(desc, tostring(got)))
  end
end
local function contains(t, sub)
  for _, v in ipairs(t or {}) do if tostring(v):find(sub, 1, true) then return true end end
  return false
end

check("舞台宽", g.stage_w, 900)
check("编程猫存在", cat ~= nil, true)
check("初始有 5 个造型", #cat.styles, 5)

-- 让无限造型循环命中 mouse_down 后 break
host:on_mouse_pressed(450, 281)
for _ = 1, 10 do rt.step(1 / 60) end
host:on_mouse_released(450, 281)
for _ = 1, 1000 do rt.step(1 / 60) end

check("最终造型 ID", cat:style_id(), "106119db-7ea0-4d47-a33c-65f3d2a560e1")
check("最终 visible", cat.visible, true)
near("最终 alpha", cat.alpha, 100, 0.01)
near("最终 scale_x", cat.scale_x, 1, 0.0001)
near("最终 scale_y", cat.scale_y, 1, 0.0001)
check("effect hue", cat.effects.color, 60)
check("effect opacity", cat.effects.opacity, 50)
check("effect brightness", cat.effects.brightness, 150)
check("effect pixelate", cat.effects.pixelate, 8)
check("effect displacement/ripple", cat.effects.ripple, 20)
check("effect twist/distortion", cat.effects.distortion, 20)
check("effect grey", cat.effects.grayscale, 50)
check("无线程错误", contains(host.logs, "线程错误"), false)

-- 边界/舍入口径（直接调用原语，避免只测最终态）
local ML = require("rt.impl.motion_looks")
check("get_styles 返回字段", ML.get_styles(cat, { style_id = "style-x" }), "style-x")
ML.set_scale(cat, { scale = 0 })
near("set_scale 下限 1%", cat.scale_x, 0.01, 1e-9)
ML.set_scale(cat, { scale = 100000 })
near("set_scale 上限 9999%", cat.scale_x, 99.99, 1e-9)
ML.set_width_height_scale(cat, { type = "width", value = 50 })
near("set_width 50%", cat.scale_x, 0.5, 1e-9)
ML.add_width_height_scale(cat, { type = "width", value = 10, increase = "increase" })
near("add_width 10%", cat.scale_x, 0.6, 1e-9)
cat.scale_x, cat.scale_y = 0.5, 0.8
ML.self_change_scale(cat, { scale = 10, increase = "increase" })
near("change_scale 保留 x", cat.scale_x, 0.6, 1e-9)
near("change_scale 保留 y", cat.scale_y, 0.9, 1e-9)
ML.add_width_height_scale(cat, { type = "width", value = 100000, increase = "increase" })
near("add_width 上限 99.99", cat.scale_x, 99.99, 1e-9)
ML.clear_all_effects(cat, {})
check("clear_all_effects 清空", cat.effects.color + cat.effects.opacity + cat.effects.brightness
  + cat.effects.pixelate + cat.effects.ripple + cat.effects.distortion + cat.effects.grayscale, 0)
ML.self_set_effect(cat, { scope = "1", value = 200 })
check("opacity 上限 100", cat.effects.opacity, 100)
ML.self_set_effect(cat, { scope = "0", value = 400 })
check("hue 环绕 400→40", cat.effects.color, 40)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
