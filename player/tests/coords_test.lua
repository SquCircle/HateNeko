-- 坐标系一致性测试：舞台画布内部必须一律用"舞台坐标"（画布像素），
-- fit（窗口缩放）只能在"画布 → 窗口"那一步乘一次。
package.path = "./?.lua;" .. package.path
-- 绝对换算（不能只测往返：两边同错也会"往返一致"）
local Coords = require("rt.host.coords")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if type(got) == "number" and type(want) == "number" then
    if math.abs(got - want) > 1e-6 then
      fails = fails + 1
      print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
    else
      print(("  ok   %-46s %s"):format(desc, tostring(got)))
    end
  elseif got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-46s %s"):format(desc, tostring(got)))
  end
end

local g = { stage_w = 900, stage_h = 562 }
local H = Coords

-- ① 舞台中心 (0,0) → 画布中心
local x, y = H.canvas_pos(g, 0, 0)
check("舞台中心 → 画布中心 x", x, 450)
check("舞台中心 → 画布中心 y", y, 281)

-- ② 左上角 / 右下角
local x1, y1 = H.canvas_pos(g, -450, 281)
check("舞台左上角 → 画布 (0,0) x", x1, 0)
check("舞台左上角 → 画布 (0,0) y", y1, 0)
local x2, y2 = H.canvas_pos(g, 450, -281)
check("舞台右下角 → 画布 (900,562) x", x2, 900)
check("舞台右下角 → 画布 (900,562) y", y2, 562)

-- ③ y 轴向上
local _, yUp = H.canvas_pos(g, 0, 100)
local _, yDown = H.canvas_pos(g, 0, -100)
check("y 向上（y=100 在画布更上方）", yUp < yDown, true)

-- ④ 画布坐标与窗口尺寸无关（这是 bug 的核心）
local m = H.canvas_pos(g, 123, -45)
check("画布坐标不受窗口影响 x", m, 573)
local _, my = H.canvas_pos(g, 123, -45)
check("画布坐标不受窗口影响 y", my, 326)

-- ⑤ fit：画布 → 窗口只乘一次，且居中留黑边
local s1, cx1, cy1 = H.fit(g, 900, 562)
check("窗口=舞台时 fit=1", s1, 1)
check("窗口=舞台时无黑边 x", cx1, 0)
local s2 = H.fit(g, 562, 900)
check("竖屏窗口 fit≈0.624", s2, 562/900)
local _, cx3, cy3 = H.fit(g, 562, 900)
check("竖屏窗口黑边居中 x", cx3, 0)
check("竖屏窗口黑边居中 y", cy3, (900 - 562 * (562/900)) / 2)

-- ⑥ 静态审计：H:draw 的画布绘制段里不应再出现 world_to_screen / "* s"
local f = assert(io.open("rt/host/love.lua", "rb"))
local src = f:read("*a"); f:close()
local body = src:match("function H:draw%(g%)(.-)\nfunction H:") or ""
local bad = {}
for line in body:gmatch("[^\n]+") do
  if line:find("world_to_screen", 1, true) then bad[#bad + 1] = "world_to_screen: " .. line:sub(1, 60) end
end
check("H:draw 内不再用 world_to_screen", #bad, 0)
if #bad > 0 then for _, b in ipairs(bad) do print("      ", b) end end

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end

-- 绝对换算：窗口=舞台时，屏幕中心 = 舞台 (0,0)，左上角 = (-450, 281)
local g2 = { stage_w = 900, stage_h = 562 }
local C2 = require("rt.host.coords")
local wx, wy = C2.screen_to_world(g2, 450, 281, 900, 562)
check("屏幕中心 = 舞台(0,0)", string.format("%.1f,%.1f", wx, wy), "0.0,0.0")
local wx2, wy2 = C2.screen_to_world(g2, 0, 0, 900, 562)
check("屏幕左上 = 舞台(-450,281)", string.format("%.1f,%.1f", wx2, wy2), "-450.0,281.0")
local sx2, sy2 = C2.world_to_screen(g2, 0, 0, 900, 562)
check("舞台(0,0) = 屏幕中心", string.format("%.0f,%.0f", sx2, sy2), "450,281")
