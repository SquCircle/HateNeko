-- 笔层不能跨屏：切屏后旧笔迹不得继续存在
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
h.play_audio = function(_, _, loop) return loop and 0 or 100000 end
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()
local game = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
local settle = "1c387224-c473-489b-aaad-782662b8860e"
g.cur_screen = game
g.sched:fire_green_flag(game)
for _ = 1, 20 do rt.step(1 / 60) end
assert(#(h.pen_lines or {}) > 0, "游戏屏没有笔迹")
local before = h.pen_clears or 0
local th = g.sched:system_thread()
rt.f.switch_to_screen(nil, { screen_id = settle }, th)
assert(g.cur_screen == settle, "未切换到结算屏")
assert((h.pen_clears or 0) == before, "切屏不应清空任何屏幕的笔层")
h.pen_lines = {}
for _ = 1, 10 do rt.step(1 / 60) end
assert(#(h.pen_lines or {}) == 0, "旧屏笔迹穿透到新屏")
print(("pen screen ok per-screen layers, clears=%d"):format(h.pen_clears))
