-- P0 语义回归：每条期望值都来自官方实现（逐字取证见 analysis/、work/bundle_impls.txt）
--
--   textSelect @1618671 / textLength @1618983 / convertType @1619126
--   mathModulo @1615652 / logicOperation @1614282 / logicNegate @1614379
--   checkKey @1563644 / mouseDown @1562946 / distanceTo @1562155
--   calculate: lex().toPostfix().postfixEval()（math-expression-evaluator 1.4.0，isDegree=true）
--   sprite_on_tap：sprite_on_tap 动作状态 + isMouseClickTarget；mouse_up 自动回 ""（官方 action spec）
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  local ok
  if type(got) == "number" and type(want) == "number" and got ~= got and want ~= want then
    ok = true
  else
    ok = (got == want)
  end
  if not ok then
    fails = fails + 1
    print(("  FAIL %-52s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-52s %s"):format(desc, tostring(got)))
  end
end

-- ---------------------------------------------------------------- 最小游戏
local host = Headless.new()
rt.set_host(host)
host.style_size = function() return 100, 100 end
local game = {
  host = host, entities = {}, vars = {}, lists = {}, frame = 1,
  screens = {}, cur_screen = nil,
  stage_w = 900, stage_h = 562, last_click_frame = -1,
  timer = 0,
}
game.find = function(self, id)
  for _, e in ipairs(self.entities) do
    if e.id == id or e.name == id then return e end
  end
  return nil
end
game.pointer_world = function(self)
  local h = self.host
  if h.pointer_valid == false then return 0 / 0, 0 / 0 end
  return (h.mouse_x or 0) - self.stage_w / 2, self.stage_h / 2 - (h.mouse_y or 0)
end
host.game = game
local th = { sched = { game = game }, script_vars = {} }
rt.build_f()
local f = rt.f

local actor = { id = "actor-1", name = "A", kind = "actor", x = 0, y = 0, img_w = 100, img_h = 100,
  style_id = function() return "s1" end, styles = { "s1" }, style_index = 1, visible = true, effects = {} }
game.entities = { actor }

-- ---------------------------------------------------------------- 文本（UTF-16）
check("text_select 中文 2..4", f.text_select(nil, { text = "你好世界", start_index = 2, end_index = 4 }, th), "好世界")
check("text_select 单字符（无 end）", f.text_select(nil, { text = "你好世界", start_index = 3 }, th), "世")
check("text_select start>end 反向", f.text_select(nil, { text = "abcde", start_index = 4, end_index = 2 }, th), "dcb")
check("text_select 越界", f.text_select(nil, { text = "abc", start_index = 5 }, th), "")
check("text_length 中文", f.text_length(nil, { text = "你好世界" }, th), 4)
check("text_length emoji(UTF-16=2)", f.text_length(nil, { text = "😀" }, th), 2)
check("text_length 数字", f.text_length(nil, { text = 123 }, th), 3)

-- ---------------------------------------------------------------- 类型转换
check("convert_type '0'→boolean", f.convert_type(nil, { text = "0", type = "boolean" }, th), true)
check("convert_type 'false'→boolean", f.convert_type(nil, { text = "false", type = "boolean" }, th), true)
check("convert_type ''→boolean", f.convert_type(nil, { text = "", type = "boolean" }, th), false)
check("convert_type '12'→number", f.convert_type(nil, { text = "12", type = "number" }, th), 12)
check("convert_type 'abc'→number（官方返回原串）", f.convert_type(nil, { text = "abc", type = "number" }, th), "abc")
check("convert_type 'NaN'→number", (function()
  local v = f.convert_type(nil, { text = "NaN", type = "number" }, th)
  return (type(v) == "number" and v ~= v) and "NaN" or v
end)(), "NaN")
check("convert_type true→number（官方返回字符串）", f.convert_type(nil, { text = true, type = "number" }, th), "true")
check("convert_type 12→string", f.convert_type(nil, { text = 12, type = "string" }, th), "12")

-- ---------------------------------------------------------------- 数学/逻辑
check("math_modulo(-7,3)", f.math_modulo(nil, { A = -7, B = 3 }, th), -1)
check("math_modulo(7,-3)", f.math_modulo(nil, { A = 7, B = -3 }, th), 1)
check("math_modulo(7,0)=NaN", (function()
  local v = f.math_modulo(nil, { A = 7, B = 0 }, th)
  return (type(v) == "number" and v ~= v) and "NaN" or v
end)(), "NaN")
check("logic_negate('0')（JS 字符串真值）", f.logic_negate(nil, { logic = "0" }, th), false)
check("logic_negate('')", f.logic_negate(nil, { logic = "" }, th), true)
check("logic_operation and 返回操作数", f.logic_operation(nil, { A = 3, B = 5, type = "and" }, th), 5)
check("logic_operation or 返回操作数", f.logic_operation(nil, { A = 0, B = "x", type = "or" }, th), "x")

-- ---------------------------------------------------------------- 公式计算（官方 oracle）
local FORMULA = {
  { "1+2*3", 7 },
  { "2^3^2", 64 },
  { "sin(30)", 0.5 },
  { "cos(60)", 0.5 },
  { "asin(0.5)", 30.000000000000004 },
  { "log(100)", 2 },
  { "ln(e)", 1 },
  { "root(9)", 3 },
  { "2!", 2 },
  { "pow(2,3)", 8 },
  { "0.1+0.2", 0.3 },
  { "0.1+0.2*3", 0.7 },
  { "2pi", 6.283185307179586 },
  { "3 Mod 2", 1 },
  { "-7 Mod 3", -1 },
  { "2(3+4)", 14 },
  { "int(3.7)", 3 },
  { "Sigma(1,3,n)", 6 },
  { "Pi(1,4,n)", 24 },
  { "10-2-3", 5 },
  { "8/2/2", 2 },
  { "sin 30", 0.5 },
}
for _, c in ipairs(FORMULA) do
  check("calculate " .. c[1], f.calculate(nil, { input = c[1] }, th), c[2])
end
check("calculate 1/0（官方返回字符串 Infinity）", f.calculate(nil, { input = "1/0" }, th), "Infinity")
check("calculate 非法公式必须报错", (function()
  return (pcall(f.calculate, nil, { input = "1+2*" }, th)) and "no error" or "error"
end)(), "error")

-- ---------------------------------------------------------------- 距离
local b = { id = "actor-2", name = "B", kind = "actor", x = 3, y = 4, img_w = 1, img_h = 1,
  style_id = function() return "s1" end }
game.entities[#game.entities + 1] = b
check("distance_to 3,4", f.distance_to(actor, { sprite = "actor-2" }, th), 5)
b.x, b.y = 1, 1
check("distance_to 两位小数", f.distance_to(actor, { sprite = "actor-2" }, th), 1.41)
check("distance_to 缺目标=NaN", (function()
  local v = f.distance_to(actor, { sprite = "nope" }, th)
  return (type(v) == "number" and v ~= v) and "NaN" or v
end)(), "NaN")
host:set_pointer(600, 381, true) -- 舞台坐标 (150, -100)
check("distance_to --mouse", f.distance_to(actor, { sprite = "--mouse" }, th), 180.28)

-- ---------------------------------------------------------------- 键盘状态
host:simulate_key_down(65)
check("check_key down", f.check_key(nil, { key = "65", type = "down" }, th), true)
check("check_key up（按下期间）", f.check_key(nil, { key = "65", type = "up" }, th), false)
host:simulate_key_up(65)
check("check_key down（松开后）", f.check_key(nil, { key = "65", type = "down" }, th), false)
check("check_key up（松开后，官方状态保持 up）", f.check_key(nil, { key = "65", type = "up" }, th), true)

-- ---------------------------------------------------------------- 点击帽 + 检测块
local counts = { click = 0, down = 0, up = 0, screen_click = 0, screen_down = 0,
  scene_target = 0, screen_self = 0, scene_detect = 0, actor_on_empty = 0 }
local work = {
  stage_w = 900, stage_h = 562, vars = {},
  screens = { { id = "scene-1", name = "S", styles = {}, style_index = 1 } },
  cur_scene = "scene-1",
  actors = { { id = "actor-1", name = "A", x = 0, y = 0, scenes = { "scene-1" },
    styles = { "s1" }, style_index = 1 } },
  assets = {}, audios = {},
  register = function(r2, g2, ents)
    local a = ents["actor-1"]
    r2.on(a, "sprite_on_tap", { type = "mouse_click", sprite = "--self" }, function() counts.click = counts.click + 1 end)
    r2.on(a, "sprite_on_tap", { type = "mouse_down", sprite = "--self" }, function() counts.down = counts.down + 1 end)
    r2.on(a, "sprite_on_tap", { type = "mouse_up", sprite = "--self" }, function() counts.up = counts.up + 1 end)
    r2.on(a, "sprite_on_tap", { type = "mouse_click", sprite = "--screen" }, function() counts.screen_click = counts.screen_click + 1 end)
    r2.on(a, "sprite_on_tap", { type = "mouse_down", sprite = "--screen" }, function() counts.screen_down = counts.screen_down + 1 end)
    -- 场景 id 目标：只应响应"点到舞台空白"
    r2.on(a, "sprite_on_tap", { type = "mouse_click", sprite = "scene-1" }, function() counts.scene_target = counts.scene_target + 1 end)
    -- 屏幕实体自己的 --self 点击：同样只响应空白
    r2.on(ents["scene-1"], "sprite_on_tap", { type = "mouse_click", sprite = "--self" }, function() counts.screen_self = counts.screen_self + 1 end)
    -- 在 hat 内读检测块（click 目标在帧末才清空）
    r2.on(a, "sprite_on_tap", { type = "mouse_click", sprite = "--screen" }, function(th, self)
      if rt.f["mouse_down"](self, { type = "click", sprite = "scene-1" }, th) then
        counts.scene_detect = counts.scene_detect + 1
      end
      if rt.f["mouse_down"](self, { type = "click", sprite = "actor-1" }, th) then
        counts.actor_on_empty = counts.actor_on_empty + 1
      end
    end)
  end,
}
local h2 = Headless.new()
rt.set_host(h2)
h2.style_size = function() return 100, 100 end
local g2 = rt.load(work, h2)
rt.start()
for _ = 1, 3 do rt.step(1 / 60) end

-- 点中角色：按下 → 抬起
h2:on_mouse_pressed(450, 281)
for _ = 1, 2 do rt.step(1 / 60) end
h2:on_mouse_released(450, 281)
for _ = 1, 3 do rt.step(1 / 60) end
check("单击角色：click 帽一次", counts.click, 1)
check("单击角色：down 帽一次（不得在抬起时重复）", counts.down, 1)
check("单击角色：up 帽一次", counts.up, 1)
check("单击角色：--screen click 触发一次（官方 global_click 任意点击）", counts.screen_click, 1)
check("单击角色：--screen down 触发一次", counts.screen_down, 1)
check("单击角色：场景 id 帽不触发", counts.scene_target, 0)
check("单击角色：屏幕实体 --self 不触发", counts.screen_self, 0)
check("单击角色：检测(场景 id click)=false", counts.scene_detect, 0)
check("单击角色：检测(角色 click)=true", counts.actor_on_empty, 1)

-- 点空白：click 帽不应触发；--screen click 触发一次
counts.click, counts.down, counts.up, counts.screen_click, counts.screen_down = 0, 0, 0, 0, 0
counts.scene_target, counts.screen_self, counts.scene_detect, counts.actor_on_empty = 0, 0, 0, 0
h2:on_mouse_pressed(10, 10)
for _ = 1, 2 do rt.step(1 / 60) end
h2:on_mouse_released(10, 10)
for _ = 1, 3 do rt.step(1 / 60) end
check("点空白：click 帽不触发", counts.click, 0)
check("点空白：--screen click 一次", counts.screen_click, 1)
check("点空白：场景 id 帽一次", counts.scene_target, 1)
check("点空白：屏幕实体 --self 一次", counts.screen_self, 1)
check("点空白：检测(场景 id click)=true", counts.scene_detect, 1)
check("点空白：检测(角色 click)=false", counts.actor_on_empty, 0)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
