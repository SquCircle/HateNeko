-- 歌曲结束 → stop 2/3 → 结算页
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
h.play_audio = function(_, _, loop) return loop and 0 or 100 end
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()
local function set(id, v) g:set_var(id, v) end
set("0e5b8264-119d-4030-8b02-ac263239ad6b", 0)
set("a5318ba4-122b-4ffb-977c-cc82ec6318bb", 1)
set("ad9ad2e0-bf30-48fd-9a36-cc64092abce3", 200)
set("3ded2f9d-1a42-43bc-b34d-4b202ef6cca7", 12)
local game = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
local settle = "1c387224-c473-489b-aaad-782662b8860e"
g.cur_screen = game
g.sched:fire_green_flag(game)
for _ = 1, 240 do
  rt.step(1 / 60)
  if g.cur_screen == settle then break end
end
assert(g.cur_screen == settle, "未进入结算页，当前=" .. tostring(g.cur_screen))
print("settlement ok screen=" .. settle)
