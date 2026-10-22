package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
-- 让游戏结束音频等待足够长，避免测试在检查 note 前已切到结算页。
h.play_audio = function(_, _, loop, vol) return loop and 0 or 100000 end
-- play_audio_and_wait 现在按官方语义轮询“是否还在播”（P1-12）；mock 也要给出这个状态。
h.audio_playing = function() return true end
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()
local function set(id, v) g:set_var(id, v) end
set("0e5b8264-119d-4030-8b02-ac263239ad6b", 0)
set("a5318ba4-122b-4ffb-977c-cc82ec6318bb", 1)
set("ad9ad2e0-bf30-48fd-9a36-cc64092abce3", 200)
set("3ded2f9d-1a42-43bc-b34d-4b202ef6cca7", 12)
local s = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
g.cur_screen = s
g.sched:fire_green_flag(s)
for _ = 1, 40 do rt.step(1 / 60) end
local down = g:get_list("19b1dec6-5fb5-4e67-b31c-e63f1070d435")
assert(#down == 676, "下坠列表长度 " .. #down)
assert(down[1] == 500, "下坠列表[1]=" .. tostring(down[1]))
assert(down[#down] == -175, "下坠列表[last]=" .. tostring(down[#down]))
local function first_circle()
  for _, e in ipairs(g.entities) do
    if e.is_clone and e.name == "circle" and not e.deleted then return e end
  end
end
local e = first_circle()
assert(e, "没有 circle clone")
local y1 = e.y
for _ = 1, 6 do rt.step(1 / 60) end
local y2 = first_circle() and first_circle().y or e.y
assert(y2 < y1, ("note 未向下移动: %s -> %s"):format(tostring(y1), tostring(y2)))
print(("note fall ok list=%d..%d y=%s->%s"):format(down[1], down[#down], y1, y2))
