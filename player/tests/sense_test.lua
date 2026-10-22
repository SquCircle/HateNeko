-- 侦测积木的直接单元测试：碰到角色/边缘、鼠标按下、按键按下、鼠标坐标
-- 不走作品脚本，直接调用运行时原语，专门验证"几何 + 输入状态"这两层
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local Helper = require("tests.helper")
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local Core = require("rt.core")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-40s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-40s %s"):format(desc, tostring(got)))
  end
end

-- 用一个真实作品跑起来当底座（有舞台、有宿主、有调度器）
local host = Headless.new()
rt.set_host(host)
local work = Helper.compiled("motion")
local game = rt.load(work, host)
rt.start()
local th = game.sched:system_thread()
local F = rt.f
local function step(n) for _ = 1, (n or 1) do rt.step(1 / 60) end end
step(2)

-- 造两个可控实体（尺寸直接给定，不依赖资源）
local A = Core.Entity.new { id = "A", name = "甲", x = 0, y = 0, img_w = 100, img_h = 100, order = 10, seq = 1 }
local B = Core.Entity.new { id = "B", name = "乙", x = 0, y = 0, img_w = 100, img_h = 100, order = 20, seq = 2 }
game.entities[#game.entities + 1] = A
game.entities[#game.entities + 1] = B

local function bump(target) return F.bump_into(A, { sprite = target }, th) end

check("重合时 碰到<乙>? = 真", bump("B"), true)
B.x = 200
check("拉开后 碰到<乙>? = 假", bump("B"), false)
B.x = 80
check("边缘相切附近 碰到 = 真", bump("B"), true)
B.y = 500
check("纵向上离开后 碰到 = 假", bump("B"), false)

-- 旋转后的 AABB：A 旋转 45° 会变大
B.x, B.y = 120, 0
check("旋转前 碰到 = 假", bump("B"), false)
A.dir = 45
check("A 旋转 45° 后（包围盒变大）碰到 = 真", bump("B"), true)
A.dir = 0

-- 碰到边缘
A.x, A.y = 0, 0
check("在中心 碰到边缘? = 假", F.out_of_boundary(A, {}, th), false)
A.x = game.stage_w / 2 + 100
check("移出舞台 碰到边缘? = 真", F.out_of_boundary(A, {}, th), true)
A.x = 0

-- 指针压在角色上（bump_into(--self)）
host.mouse_x, host.mouse_y = game.stage_w / 2, game.stage_h / 2 -- 世界(0,0)
check("指针压在甲身上 = 真", F.bump_into(A, { sprite = "--self" }, th), true)
host.mouse_x, host.mouse_y = game.stage_w / 2 + 300, game.stage_h / 2
check("指针离开后 = 假", F.bump_into(A, { sprite = "--self" }, th), false)

-- 鼠标按下 / 按键按下（轮询）
host.mouse_is_down = false
check("鼠标未按下 = 假", F.mouse_down(A, { type = "down" }, th), false)
host.mouse_is_down = true
check("鼠标按下 = 真", F.mouse_down(A, { type = "down" }, th), true)

host.keys = host.keys or {}
host.keys["65"] = true
check("按键 a(65) 按下 = 真", F.check_key(A, { key = "65" }, th), true)
host.keys["65"] = nil
check("松开后 = 假", F.check_key(A, { key = "65" }, th), false)

-- 鼠标坐标（舞台坐标）
host.mouse_x, host.mouse_y = game.stage_w / 2 + 50, game.stage_h / 2 - 30
check("鼠标 x 读回 50", F.get_mouse_info(A, { type = "x" }, th), 50)
check("鼠标 y 读回 30（y 向上）", F.get_mouse_info(A, { type = "y" }, th), 30)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
