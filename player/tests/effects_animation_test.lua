-- 特效块：所有未选选项的动画构建/文字/全局/进出场状态
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local host = Headless.new(); rt.set_host(host)
local g = rt.load(assert(loadfile("works/effects_new.lua"))(), host)
local e = nil
for _, x in ipairs(g.entities) do if x.kind == "actor" then e = x break end end
local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then fails = fails + 1; print(("  FAIL %-38s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else print(("  ok   %-38s %s"):format(desc, tostring(got))) end
end
local th = { sched = g.sched, block = function() end }
local function clear() g._effect_anims = {}; g._global_anim = nil end

for _, a in ipairs({ "shake", "scale", "bounce" }) do
  clear(); e.visible = true
  rt.impl.self_stress_animation(e, { animation = a }, th)
  check(a .. " emphasis built", g._effect_anims[e] ~= nil, true)
end
for _, a in ipairs({ "slideIn", "bounceIn", "flyIn" }) do
  clear(); e.visible = false
  rt.impl.self_appear_animation(e, { appear = "appear", direction = "left", animation = a }, th)
  check(a .. " appear built", g._effect_anims[e] ~= nil, true)
  check(a .. " visible on appear", e.visible, true)
end
for _, a in ipairs({ "slideOut", "flyOut", "bounceOut" }) do
  clear(); e.visible = true
  rt.impl.self_appear_animation(e, { appear = "disappear", direction = "down", animation = a }, th)
  check(a .. " disappear built", g._effect_anims[e] ~= nil, true)
end
clear(); rt.impl.global_animation(e, { animation = "animation_firework" }, th)
check("global built", g._global_anim ~= nil, true)
check("global name", g._global_anim and g._global_anim.name, "animation_firework")
rt.impl.self_text_effect_text(e, { text = "  effect  " }, th)
check("text trim", e.text_effect.text, "effect")
rt.impl.self_text_effect_size(e, { size = 5000 }, th)
check("text size clamp", e.text_effect.size, 2000)
rt.impl.self_text_effect_color(e, { color = "#ffb029" }, th)
check("text color", e.text_effect.color, "#ffb029")
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
