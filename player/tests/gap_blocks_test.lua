-- 阶段 4：补齐块的语义回归（script_variables_set/change、get_sprite_property、
-- math_trig_rad、sound_color、get_play_audio）+ 编译期离线分类。
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  local ok = (got == want)
  if type(got) == "number" and type(want) == "number" and got ~= got and want ~= want then ok = true end
  if not ok then
    fails = fails + 1
    print(("  FAIL %-52s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-52s %s"):format(desc, tostring(got)))
  end
end
local function nan(v) return type(v) == "number" and v ~= v end

local h = Headless.new(); rt.set_host(h)
local g = rt.load({
  stage_w = 900, stage_h = 562, vars = {}, screens = {}, assets = {}, audios = {},
  actors = {
    { id = "root", name = "R", x = 0, y = 0, styles = { "s1" }, style_index = 1 },
    { id = "far", name = "F", x = 30, y = 40, styles = { "s1" }, style_index = 1 },
  },
}, h)
rt.build_f()
local f = rt.f
local th = { sched = { game = g }, script_vars = {} }
local root, far = g:find("root"), g:find("far")
root.x, root.y = 10, -5
root.style_index = 2
root.scale_x, root.scale_y = 1.5, 0.5
root.dir = 30
root.effects = { color = 25, opacity = 80, brightness = 10, pixelate = 3, ripple = 1, distortion = 2, grayscale = 40 }
g.script_var_alias = { sv = "id-sv" }

-- 设置/改变脚本变量（名字 → alias → 线程 script_vars）
f.script_variables_set(nil, { variable = "sv", value = 7 }, th)
check("script_variables_set 写线程变量", th.script_vars["id-sv"], 7)
f.change_script_variables(nil, { variable = "sv", method = "increase", value = 2 }, th)
check("change_script_variables 增加", th.script_vars["id-sv"], 9)
f.change_script_variables(nil, { variable = "sv", method = "decrease", value = 4 }, th)
check("change_script_variables 减少", th.script_vars["id-sv"], 5)

-- 脚本变量 JSON 字段（官方编辑器写 {"type":NEKO...,"name":"sv"}）
local jsvar = '{"type":"NEKO_SCRIPT_VARIABLE_TYPE-x","name":"sv"}'
f.script_variables_set(nil, { variable = jsvar, value = 11 }, th)
check("script_variables_set 解析 JSON 名字", th.script_vars["id-sv"], 11)
f.change_variables(nil, { variable = jsvar, method = "increase", value = 3 }, th)
check("change_variables 脚本 JSON 路径（id 修复）", th.script_vars["id-sv"], 14)

-- get_sprite_property：坐标/造型/外观/特效/距离
check("get_sprite_property x", f.get_sprite_property(root, { sprite = "--self", attribute = "x" }, th), 10)
check("get_sprite_property y", f.get_sprite_property(root, { sprite = "--self", attribute = "y" }, th), -5)
check("get_sprite_property style_index", f.get_sprite_property(root, { sprite = "--self", attribute = "style_index" }, th), 2)
check("get_sprite_property width", f.get_sprite_property(root, { sprite = "--self", attribute = "width" }, th), 150)
check("get_sprite_property height", f.get_sprite_property(root, { sprite = "--self", attribute = "height" }, th), 50)
check("get_sprite_property direction", f.get_sprite_property(root, { sprite = "--self", attribute = "direction" }, th), 30)
check("get_sprite_property color", f.get_sprite_property(root, { sprite = "--self", attribute = "color" }, th), 25)
check("get_sprite_property opacity", f.get_sprite_property(root, { sprite = "--self", attribute = "opacity" }, th), 80)
check("get_sprite_property grayscale", f.get_sprite_property(root, { sprite = "--self", attribute = "grayscale" }, th), 40)
check("get_sprite_property distance", f.get_sprite_property(root, { sprite = "far", attribute = "distance" }, th), 49.24)
check("get_sprite_property 未知属性=NaN", nan(f.get_sprite_property(root, { sprite = "--self", attribute = "bogus" }, th)), true)
check("get_sprite_property 数字属性 3=pixelate", f.get_sprite_property(root, { sprite = "--self", attribute = "3" }, th), 3)

-- math_trig_rad：弧度制，不转角度、不 round2
local near = function(a, b) return math.abs(a - b) < 1e-9 end
check("math_trig_rad sin(pi/2)", near(f.math_trig_rad(nil, { type = "sin", num = math.pi / 2 }, th), 1), true)
check("math_trig_rad cos(0)", f.math_trig_rad(nil, { type = "cos", num = 0 }, th), 1)
check("math_trig_rad asin(1)=pi/2", near(f.math_trig_rad(nil, { type = "asin", num = 1 }, th), math.pi / 2), true)
check("math_trig_rad 未知=NaN", nan(f.math_trig_rad(nil, { type = "bogus", num = 1 }, th)), true)

-- sound_color：保存语音音色配置，不假装能发声
f.sound_color(nil, { sound_color_per = 3, speed = 4, pitch = 5, volume = 6 }, th)
check("sound_color per", g.voice_color.per, 3)
check("sound_color speed", g.voice_color.speed, 4)
check("sound_color pitch", g.voice_color.pitch, 5)
check("sound_color volume", g.voice_color.volume, 6)

-- get_play_audio：影子下拉的兜底值
check("get_play_audio 返回 audio_id", f.get_play_audio(nil, { audio_id = "abc" }), "abc")

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
