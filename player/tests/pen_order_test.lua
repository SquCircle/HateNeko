-- HP 血条：轨道 clear 之后，HP 的笔迹仍应落到笔层
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()
g:set_var("a5318ba4-122b-4ffb-977c-cc82ec6318bb", 1)
local s = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
g.cur_screen = s
g.sched:fire_green_flag(s)
for _ = 1, 30 do rt.step(1 / 60) end
local hp, total = nil, 0
for _, ev in ipairs(h.pen_lines or {}) do
  if ev.owner == "HP" then
    total = total + 1
    hp = hp or ev
  end
end
assert(total > 0, "没有 HP 笔迹")
assert(hp.x1 == -450 and hp.y1 == 281, ("HP 笔迹起点错误 %s,%s"):format(tostring(hp.x1), tostring(hp.y1)))
assert(hp.x2 > hp.x1, "HP 笔迹没有向右绘制")
assert(hp.size == 15, "HP 笔迹宽度错误 " .. tostring(hp.size))
assert((h.pen_clears or 0) > 0, "轨道没有 clear")
print(("pen order ok HP lines=%d clear=%d"):format(total, h.pen_clears))
