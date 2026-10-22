-- paint 作品 headless：--mouse 跟随 + 落笔/断笔（像素绘制需 LÖVE 真机）
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-44s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-44s %s"):format(desc, tostring(got)))
  end
end
local function near(a, b) return type(a) == "number" and math.abs(a - b) < 1e-6 end

local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/paint.lua"))(), host)
local cat, screen
for _, e in ipairs(g.entities) do
  if e.name == "编程猫" then cat = e end
  if e.kind == "screen" then screen = e end
end
check("舞台宽", g.stage_w, 900)
check("舞台高", g.stage_h, 562)
check("编程猫存在", cat ~= nil, true)
check("背景 visible=false", screen and screen.visible, false)
check("角色 visible=false", cat and cat.visible, false)

rt.start()
-- 绿旗 hat 在第一步执行 self_set_pen_size 5
rt.step(1 / 60)
check("初始笔粗 5", cat.pen.size, 5)
check("初始抬笔", cat.pen.down, false)
check("初始笔色 #000000", cat.pen.color, "#000000")

-- 按下：鼠标在屏幕中心 → 世界 (0,0)，应移动并落笔
host.mouse_x, host.mouse_y = 450, 281
host.mouse_is_down = true
rt.step(1 / 60)
check("按下后 x=0", near(cat.x, 0), true)
check("按下后 y=0", near(cat.y, 0), true)
check("按下后落笔", cat.pen.down, true)
check("按下即产生 dot", #(host.pen_events or {}), 1)
check("dot 位置 x=0", host.pen_events and host.pen_events[1].x, 0)
check("dot 位置 y=0", host.pen_events and host.pen_events[1].y, 0)

-- 按住不动三帧：仍只有一个 dot
rt.step(1 / 60)
rt.step(1 / 60)
rt.step(1 / 60)
check("按住不动不重复 dot", #(host.pen_events or {}), 1)

-- 拖动到 x=100
host.mouse_x = 550
rt.step(1 / 60)
check("拖动后 x=100", near(cat.x, 100), true)
check("拖动后仍落笔", cat.pen.down, true)
check("拖动不重复 dot", #(host.pen_events or {}), 1)

-- 松开：抬笔并清 last（不接下笔）
host.mouse_is_down = false
rt.step(1 / 60)
check("松开后抬笔", cat.pen.down, false)
check("松开后 last_x 清空", cat.pen.last_x, nil)
check("松开后 last_y 清空", cat.pen.last_y, nil)

-- 再按另一处：不应沿用上一笔 last
host.mouse_x, host.mouse_y = 350, 281
host.mouse_is_down = true
rt.step(1 / 60)
check("再次按下 x=-100", near(cat.x, -100), true)
check("再次按下落笔", cat.pen.down, true)
check("再次按下产生第二个 dot", #(host.pen_events or {}), 2)
check("新 dot 位置 x=-100", host.pen_events and host.pen_events[2].x, -100)
check("新笔画 last_x 不是上一笔", cat.pen.last_x, -100)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
