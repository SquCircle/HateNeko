package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new(); rt.set_host(h)
local g = rt.load(assert(loadfile("works/events_new2.lua"))(), h)
rt.start()
local function step(n) for _ = 1, (n or 1) do rt.step(1/60) end end
local function fail(msg) error(msg, 0) end
step(3)
local orig
for _, e in ipairs(g.entities) do if e.name == "编程猫" then orig = e end end
if not orig then fail("no original actor") end
h:click(0, 0, orig.id); step(3)
local c1
for _, e in ipairs(g.entities) do if e.is_clone then c1 = e end end
if not c1 then fail("clone #1 missing") end
if c1.id ~= orig.id .. "#1" then fail("clone #1 id: " .. tostring(c1.id)) end
h:click(0, 0, c1.id); step(3)
local c2
for _, e in ipairs(g.entities) do if e.is_clone and e ~= c1 then c2 = e end end
if not c2 then fail("clone #2 missing") end
if c2.id ~= orig.id .. "#2" then fail("clone #2 id: " .. tostring(c2.id)) end
if c2.id:find("#1#", 1, true) then fail("clone-of-clone id: " .. c2.id) end
local starts = 0
for _, t in ipairs(g.sched.threads) do
  if t.hat == "start_as_a_mirror" and not t.done then starts = starts + 1 end
end
if starts < 2 then fail("clone start threads: " .. tostring(starts)) end
local bstarted = g.sched:broadcast("b", "x", orig)
local clone_listener = false
for _, t in ipairs(bstarted) do
  if t.execution_self and t.execution_self.is_clone then clone_listener = true end
end
if not clone_listener then fail("clone broadcast listener missing") end
local sys0 = g.sched:system_thread()
local cv = rt.f.get_clone_index_property(orig, { sprite = "--self", index = 1, attribute = "x" }, sys0)
if math.abs(cv - c1.x) > 0.001 then fail("clone property x") end
local bv = rt.f.on_bump_actor_value(orig, { attribute = "x" }, { event = { target = c1 } })
if math.abs(bv - c1.x) > 0.001 then fail("bump actor value x") end
g.bubbles = g.bubbles or {}
g.bubbles[c2] = { type = "talk", text = "x", owner = c2, duration = 0 }
g.sched:dispose_clone(c2)
if g.bubbles[c2] ~= nil then fail("bubble survived dispose_clone") end
g.sched:restart(); step(2)
if not g:find(orig.id) then fail("find after restart") end
for _, e in ipairs(g.entities) do
  if e.is_clone then fail("clone survived restart") end
  if e.name == "编程猫" and e.clone_seq ~= 0 then fail("clone_seq not reset") end
end
if next(g.bubbles) ~= nil then fail("bubbles survived restart") end
local sys = g.sched:system_thread()
local first, second = g.screen_order[1], g.screen_order[2]
if not first or not second then fail("screen order incomplete") end
g.cur_screen = first
if g:resolve_screen("next") ~= second then fail("resolve next") end
if g:resolve_screen("prev") ~= first then fail("resolve prev at start") end
g.cur_screen = second
if g:resolve_screen("next") ~= second then fail("resolve next at end") end
if g:resolve_screen("prev") ~= first then fail("resolve prev") end
if g:resolve_screen(2) ~= second then fail("resolve numeric 1-based") end
if g:resolve_screen("空白场景") ~= second then fail("resolve screenName") end
g.cur_screen = first
rt.f.switch_to_screen(orig, { screen_id = "next" }, sys)
if g.cur_screen ~= second then fail("switch next failed") end
rt.f.switch_to_screen(orig, { screen_id = "prev" }, sys)
if g.cur_screen ~= first then fail("switch prev failed") end
if rt.f.get_screens(orig, { screen_id = "next" }, sys) ~= "next" then fail("get_screens must be literal") end
-- 真实点击路径：点击舞台空白触发屏幕目标 hat，切换 next。
g.transition = nil
g.cur_screen = first
h.mouse_x, h.mouse_y = 0, 0
h:on_mouse_pressed(0, 0)
h:on_mouse_released(0, 0)
step(2)
if g.cur_screen ~= second then fail("stage click did not switch screen") end
g.cur_screen = first
g.transition = nil
h:on_mouse_pressed(0, 0); local down_events = h:take_events() or {}
local has_down = false
for _, ev in ipairs(down_events) do if ev.event and ev.event.type == "mouse_down" then has_down = true end end
if not has_down then fail("mouse_down event missing") end
h:on_mouse_released(0, 0); local up_events = h:take_events() or {}
local has_up = false
for _, ev in ipairs(up_events) do if ev.event and ev.event.type == "mouse_up" then has_up = true end end
if not has_up then fail("mouse_up event missing") end
print("events semantics ok")
