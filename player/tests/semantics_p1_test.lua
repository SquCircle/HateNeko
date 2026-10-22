-- P1 语义 + H 宿主回归（期望值来自官方实现 / ECMAScript 规范）
--
--   V.str ← JS Number#toString（node 生成 oracle）
--   list* ← aV.list*：index=Math.round，<1 自动取 1；list_item >len → NaN
--   get_mouse_info ← round(坐标,2)
--   bump_into(--mouse) ← 官方不要求按下；指针 NaN 才为假
--   background NONE ← update_adaptive_scale：两轴都小于 view 才 max 放大
--   文本特效 ← 官方 thread_lock 等 set_* 应用后继续（本运行时让出一帧）
--   rotation_type ← restart 必须回到初始值
--   音频等待 ← 等 isPlaying 结束，不是固定时长
--   失焦释放 ← release_all_input 清键/鼠标状态并补 keyup 事件
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")
local V = require("rt.values")
local Hit = require("rt.hit")
local Keymap = require("rt.host.keymap")

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

-- ---------------------------------------------------------------- 1. JS 数字转字符串
local NUMSTR = {
  { 0, "0" }, { -0.0, "0" }, { 1, "1" }, { -1, "-1" },
  { 0.1 + 0.2, "0.30000000000000004" },
  { 1e15, "1000000000000000" }, { 1e16, "10000000000000000" },
  { 1e20, "100000000000000000000" }, { 1e21, "1e+21" },
  { 1e-6, "0.000001" }, { 1e-7, "1e-7" },
  { 1 / 3, "0.3333333333333333" },
  { 123456789012345680000, "123456789012345680000" },
  { 2 ^ 53, "9007199254740992" }, { 2 ^ 53 + 2, "9007199254740994" },
  { 1.5, "1.5" }, { 1.25, "1.25" }, { 100.5, "100.5" },
  { 0.000001234, "0.000001234" }, { 5e-324, "5e-324" },
  { 1.7976931348623157e308, "1.7976931348623157e+308" },
  { 0 / 0, "NaN" }, { math.huge, "Infinity" }, { -math.huge, "-Infinity" },
  { 1234.5678, "1234.5678" },
}
for _, c in ipairs(NUMSTR) do
  check("V.str " .. tostring(c[1]), V.str(c[1]), c[2])
end

-- ---------------------------------------------------------------- 假游戏
local host = Headless.new()
rt.set_host(host)
host.style_size = function() return 100, 100 end
local game = {
  host = host, entities = {}, vars = {}, lists = { L = { "a", "b", "c" } },
  screens = {}, cur_screen = nil, frame = 1, stage_w = 900, stage_h = 562,
}
game.find = function(self, id)
  for _, e in ipairs(self.entities) do if e.id == id or e.name == id then return e end end
  return nil
end
game.get_list = function(self, key) return self.lists[key] or {} end
game.get_var = function(self, key) return self.vars[key] or 0 end
game.set_var = function(self, key, v) self.vars[key] = v end
game.scope_of = function(self) return self.vars end
game.resolve_var_key = function(self, k) return k end
game.pointer_world = function(self)
  if self.host.pointer_valid == false then return 0 / 0, 0 / 0 end
  return (self.host.mouse_x or 0) - self.stage_w / 2, self.stage_h / 2 - (self.host.mouse_y or 0)
end
host.game = game
local th = { sched = { game = game }, script_vars = {} }
rt.build_f()
local f = rt.f

local actor = {
  id = "actor-1", name = "A", kind = "actor", x = 0, y = 0, img_w = 100, img_h = 100,
  style_id = function() return "s1" end, styles = { "s1" }, style_index = 1, visible = true,
  alpha = 100, effects = {}, pen = { down = false, size = 1, color = "#000000", alpha = 1 },
}
game.entities = { actor }

-- ---------------------------------------------------------------- 2. 列表语义
check("list_item 1", f.list_item(nil, { list = "L", item = "any", list_index = 1 }, th), "a")
check("list_item 3", f.list_item(nil, { list = "L", item = "any", list_index = 3 }, th), "c")
check("list_item 2.4→round 2", f.list_item(nil, { list = "L", item = "any", list_index = 2.4 }, th), "b")
check("list_item 2.6→round 3", f.list_item(nil, { list = "L", item = "any", list_index = 2.6 }, th), "c")
check("list_item 0→夹到 1", f.list_item(nil, { list = "L", item = "any", list_index = 0 }, th), "a")
check("list_item -3→夹到 1", f.list_item(nil, { list = "L", item = "any", list_index = -3 }, th), "a")
check("list_item 越界=NaN", (function()
  local v = f.list_item(nil, { list = "L", item = "any", list_index = 4 }, th)
  return (type(v) == "number" and v ~= v) and "NaN" or v
end)(), "NaN")
check("list_item last", f.list_item(nil, { list = "L", item = "last" }, th), "c")

game.lists.L = { "a", "b", "c" }
f.list_insert_value(nil, { list = "L", list_item_value = "x", list_index = 0 }, th)
check("insert 0→夹到 1", table.concat(game.lists.L, ","), "x,a,b,c")
game.lists.L = { "a", "b", "c" }
f.list_insert_value(nil, { list = "L", list_item_value = "x", list_index = 2.6 }, th)
check("insert 2.6→round 3", table.concat(game.lists.L, ","), "a,b,x,c")
game.lists.L = { "a", "b", "c" }
f.list_insert_value(nil, { list = "L", list_item_value = "x", list_index = 9 }, th)
check("insert 越界→追加", table.concat(game.lists.L, ","), "a,b,c,x")

game.lists.L = { "a", "b", "c" }
f.delete_list_item(nil, { list = "L", item = "any", list_index = 0 }, th)
check("delete 0→删除第 1 项", table.concat(game.lists.L, ","), "b,c")
game.lists.L = { "a", "b", "c" }
f.delete_list_item(nil, { list = "L", item = "any", list_index = 9 }, th)
check("delete 越界→不操作", table.concat(game.lists.L, ","), "a,b,c")

game.lists.L = { "a", "b", "c" }
f.replace_list_item(nil, { list = "L", item = "any", list_index = 0, list_item_value = "z" }, th)
check("replace 0→替换第 1 项", table.concat(game.lists.L, ","), "z,b,c")
game.lists.L = { "a", "b", "c" }
f.replace_list_item(nil, { list = "L", item = "any", list_index = 9, list_item_value = "z" }, th)
check("replace 越界→追加", table.concat(game.lists.L, ","), "a,b,c,z")

-- ---------------------------------------------------------------- 3. 鼠标坐标两位小数
host:set_pointer(450 + 10.123, 281 - (-4.567), true) -- world (10.123, -4.567)
check("get_mouse_info x 两位小数", f.get_mouse_info(nil, { type = "x" }, th), 10.12)
check("get_mouse_info y 两位小数", f.get_mouse_info(nil, { type = "y" }, th), -4.57)

-- ---------------------------------------------------------------- 4. 碰到鼠标（不需要按下）
host:set_pointer(450, 281, true) -- world 0,0
host.mouse_is_down = false
check("bump_into(--mouse) 悬停即真（不要求按下）",
  f.bump_into(actor, { sprite = "--self", sprite1 = "--mouse" }, th), true)
host:clear_pointer()
check("bump_into(--mouse) 指针无效=假",
  f.bump_into(actor, { sprite = "--self", sprite1 = "--mouse" }, th), false)

-- ---------------------------------------------------------------- 5. 「移到鼠标」不再让角色从命中消失
host:set_pointer(500, 300, true) -- world (50, -19)
f.self_move_specify(actor, { sprite = "--mouse" }, th)
check("self_move_specify 写入 x", actor.x, 50)
check("self_move_specify 写入 y", actor.y, -19)
check("移到鼠标后仍参与命中", #Hit.hit_list_at(game, 50, -19) >= 1, true)
check("pointer_ignore 未设置", actor.pointer_ignore, nil)

-- ---------------------------------------------------------------- 6. 背景 NONE
local LoveH = require("rt.host.love")
local sx, sy = LoveH.bg_scale("NONE", 100, 100, 900, 562)
check("NONE 小图两轴都小→max 放大 x", sx, 9)
check("NONE 小图两轴都小→max 放大 y", sy, 9)
sx, sy = LoveH.bg_scale("NONE", 1000, 100, 900, 562)
check("NONE 一轴更大→1:1 x", sx, 1)
check("NONE 一轴更大→1:1 y", sy, 1)
sx, sy = LoveH.bg_scale("CONTAIN", 1800, 562, 900, 562)
check("CONTAIN=min", sx, 0.5)
sx, sy = LoveH.bg_scale("COVER", 1800, 562, 900, 562)
check("COVER=max", sx, 1)
sx, sy = LoveH.bg_scale("STRETCH", 1800, 562, 900, 562)
check("STRETCH=x/y 独立", sx, 0.5)
check("STRETCH=y 1", sy, 1)

-- ---------------------------------------------------------------- 7. 文本特效阻塞一帧 + restart rotation_type
local vars = { { id = "v_text", name = "text", value = 0 } }
local effect_work = {
  stage_w = 900, stage_h = 562, vars = vars, screens = {}, cur_scene = nil,
  actors = { { id = "a1", name = "A1", x = 0, y = 0, styles = { "s1" }, style_index = 1 } },
  assets = {}, audios = {},
  register = function(r2, g2, ents)
    local a = ents["a1"]
    r2.on(a, "on_running_group_activated", {}, function(t2, s2)
      r2.f["self_text_effect_text"](s2, { text = "hello" }, t2)
      r2.f["variables_set"](s2, { variable = "v_text", value = 1 }, t2)
    end)
  end,
}
local h2 = Headless.new(); rt.set_host(h2)
local g2 = rt.load(effect_work, h2)
rt.start()
rt.step(1 / 60)
check("文本特效：下一帧才继续（官方 thread_lock）", g2.vars["v_text"], 0)
rt.step(1 / 60)
check("文本特效：再下一帧继续", g2.vars["v_text"], 1)

local a1 = g2:find("a1")
a1.rotation_type = 1
a1.rotation_style = "left_right"
g2.sched:restart()
check("restart 重置 rotation_type", a1.rotation_type, nil)
check("restart 重置 rotation_style", a1.rotation_style, "all")

-- ---------------------------------------------------------------- 8. 播放直到结束（轮询 isPlaying）
local audio_work = {
  stage_w = 900, stage_h = 562, vars = { { id = "v_audio", name = "audio", value = 0 } },
  screens = {}, cur_scene = nil,
  actors = { { id = "a2", name = "A2", x = 0, y = 0, styles = { "s1" }, style_index = 1 } },
  assets = {}, audios = { snd1 = { id = "snd1", file = "assets/snd1.mp3" } },
  register = function(r2, g2b, ents)
    local a = ents["a2"]
    r2.on(a, "on_running_group_activated", {}, function(t2, s2)
      r2.f["play_audio_and_wait"](s2, { audio_id = "snd1" }, t2)
      r2.f["variables_set"](s2, { variable = "v_audio", value = 1 }, t2)
    end)
  end,
}
local h3 = Headless.new(); rt.set_host(h3)
local g3 = rt.load(audio_work, h3)
rt.start()
for _ = 1, 2 do rt.step(1 / 60) end
check("play_audio_and_wait：未结束前阻塞", g3.vars["v_audio"], 0)
for _ = 1, 30 do rt.step(1 / 60) end
check("play_audio_and_wait：播放结束/停止后继续", g3.vars["v_audio"], 1)

-- ---------------------------------------------------------------- 9. 失焦释放（H-2）与键表（H-3）
local h4 = Headless.new(); rt.set_host(h4)
local g4 = rt.load({ stage_w = 900, stage_h = 562, vars = {}, screens = {}, cur_scene = nil,
  actors = { { id = "a4", name = "A4", x = 0, y = 0, styles = { "s1" }, style_index = 1 } },
  assets = {}, audios = {} }, h4)
rt.start()
h4:simulate_key_down(16)  -- Shift
h4:simulate_key_down(65)  -- A
h4:on_mouse_pressed(450, 281)
check("按下后 key_states down", h4.key_states["16"], "down")
h4:release_all_input()
check("失焦释放 Shift", h4.key_states["16"], "up")
check("失焦释放 A", h4.key_states["65"], "up")
check("失焦释放鼠标", h4.mouse_is_down, false)
check("失焦清空点击状态", h4.tap_action and h4.tap_action["a4"], nil)
local ups = 0
for _, ev in ipairs(h4.events or {}) do
  if ev.event and ev.event.type == "up" and (ev.event.key == "16" or ev.event.key == "65") then ups = ups + 1 end
end
check("失焦补发 keyup 事件", ups, 2)

check("keymap Shift", Keymap.name_to_code["lshift"], "16")
check("keymap Esc", Keymap.name_to_code["escape"], "27")
check("keymap F1", Keymap.name_to_code["f1"], "112")
check("keymap 标点 ;", Keymap.name_to_code[";"], "186")
check("keymap 方向键", Keymap.name_to_code["up"], "38")

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
