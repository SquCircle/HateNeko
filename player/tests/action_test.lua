-- 运动积木盒 + action 作品 headless
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local ML = require("rt.impl.motion_looks")

local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/action.lua"))(), host)
local cat, ad
for _, e in ipairs(g.entities) do
  if e.name == "编程猫" then cat = e elseif e.name == "阿短" then ad = e end
end

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-48s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-48s %s"):format(desc, tostring(got)))
  end
end
local function near(desc, got, want, eps)
  checks = checks + 1
  if math.abs((got or 0) - want) > (eps or 0.01) then
    fails = fails + 1
    print(("  FAIL %-48s got=%s want≈%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-48s %s"):format(desc, tostring(got)))
  end
end

check("舞台宽", g.stage_w, 900)
check("舞台高", g.stage_h, 562)
check("编程猫存在", cat ~= nil, true)
check("阿短存在", ad ~= nil, true)

-- 屏幕外按下：不受理；内按下后外移：保持按下
host:on_mouse_pressed(-1, 0)
check("屏幕外按下不按下", host.mouse_is_down, false)
host:on_mouse_released(-1, 0)
host:on_mouse_pressed(450, 281)
check("屏幕内按下", host.mouse_is_down, true)
host:on_mouse(1000, 281)
check("内按下外移仍按下", host.mouse_is_down, true)
host:on_mouse_released(1000, 281)
check("外移后释放", host.mouse_is_down, false)

rt.start()
for _ = 1, 2600 do rt.step(1 / 60) end

check("最终 i/流程完成：坐标 x", cat.x, 200)
check("最终坐标 y", cat.y, 0)
check("编程猫黄色阵营", cat.camp, "camp_yellow")
check("阿短显示", ad.visible, true)
check("阿短红色阵营", ad.camp, "camp_red")
check("旋转方式恢复0", cat.rotation_type, 0)
check("方向为有限值", cat.dir == cat.dir and math.abs(cat.dir) < 1e9, true)

-- 没有纹理像素：官方 get_texture_internal_points_vertices 为 nil → 不反弹
host.style_pixels = nil
host._pixels_cache = {}
host._alpha_bounds_cache = nil
cat.x, cat.y, cat.dir = g.stage_w / 2, 0, 0
ML.self_bounce_off_edge(cat, {}, { sched = { game = g } })
check("无像素不反弹", cat.dir, 0)
check("无像素不推回", cat.x, g.stage_w / 2)

-- 有纹理像素：官方 bounce_if_collision_with_edge 的舞台边界反射
local cw, ch = cat.img_w or 100, cat.img_h or 100
local cat_style = cat:style_id()
host.style_pixels = function(_, id, game2)
  if id ~= cat_style or not game2 then return nil end
  return { w = cw, h = ch, alpha = string.rep("\255", cw * ch) }
end
host._pixels_cache = {}
host._alpha_bounds_cache = nil
cat.x, cat.y, cat.dir = g.stage_w / 2, 0, 0
ML.self_bounce_off_edge(cat, {}, { sched = { game = g } })
check("右边界反弹方向", cat.dir, 180)
check("反弹后 x 回到舞台", cat.x < g.stage_w / 2, true)

-- 绕阿短旋转
ad.x, ad.y = 0, 0
cat.x, cat.y, cat.dir = 100, 0, 0
ML.self_rotate_around(cat, { sprite = ad.id, degrees = 90 }, { sched = { game = g } })
near("绕阿短 x=0", cat.x, 0, 0.01)
near("绕阿短 y=100", cat.y, 100, 0.01)
near("绕阿短 dir=90", cat.dir, 90, 0.01)

-- face_to 目标角色 / 随机
cat.x, cat.y = 0, 0
ad.x, ad.y = 100, 0
ML.self_face_to(cat, { sprite = ad.id }, { sched = { game = g } })
near("face_to 右侧 0", cat.dir, 0, 0.01)
ad.x, ad.y = 0, 100
ML.self_face_to(cat, { sprite = ad.id }, { sched = { game = g } })
near("face_to 上方 90", cat.dir, 90, 0.01)
ML.self_face_to(cat, { sprite = "--random" }, { sched = { game = g } })
check("face_to random 有限", cat.dir == cat.dir and math.abs(cat.dir) <= 360, true)

-- move_specify_sprite 应与 move_specify 相同
cat.x, cat.y = 0, 0
ad.x, ad.y = 50, 25
ML.self_move_specify_sprite(cat, { sprite = ad.id }, { sched = { game = g } })
check("move_specify_sprite x", cat.x, 50)
check("move_specify_sprite y", cat.y, 25)

-- position/coordinate 的 coordinate 分派
cat.x, cat.y = 0, 0
ML.self_set_position(cat, { coordinate = "y", value = 42 })
check("set_position coordinate=y", cat.y, 42)
ML.self_change_coordinate(cat, { coordinate = "y", value = 8, increase = "increase" })
check("change_coordinate coordinate=y", cat.y, 50)

-- randomNum 官方四舍五入闭区间
local r = rt.f["random_num"](cat, { A = 1.2, B = 3.8 }, { sched = { game = g } })
check("random 整数", r, math.floor(r))
check("random 下界>=1", r >= 1, true)
check("random 上界<=4", r <= 4, true)

-- appearance / camp
ML.self_appear(cat, { value = "hide" })
check("hide 隐藏", cat.visible, false)
ML.self_appear(cat, { value = "appear" })
check("appear 显示", cat.visible, true)
cat.camp = "camp_yellow"
ML.self_set_role_camp(cat, { role_camp = "no_camp" })
check("no_camp 清空", cat.camp, nil)

-- 作品中的阵营碰撞
cat.x, cat.y, cat.camp = 0, 0, "camp_yellow"
ad.x, ad.y, ad.camp, ad.visible = 0, 0, "camp_red", true
check("bump_into camp_red", rt.f["bump_into"](cat, { sprite = "--self", sprite1 = "camp_red" }, { sched = { game = g } }), true)

-- draggable：屏幕内按下，移动宿主更新位置
cat.x, cat.y = 200, 0
cat.draggable = true
host:on_mouse_pressed(650, 281)
check("draggable 命中", host.drag_ent == cat, true)
host:on_mouse(750, 281)
near("draggable 移动到 x=300", cat.x, 300, 0.01)
host:on_mouse_released(750, 281)
check("drag 结束清空", host.drag_ent, nil)

-- 拖动时手指离开舞台：角色原地不动；回到舞台后一次追上手指+偏移
cat.x, cat.y = 200, 0
cat.draggable = true
host:on_mouse_pressed(700, 281)     -- 世界 250，角色 200，偏移 50
host:on_mouse(750, 281)             -- 世界 300 → 角色 250
check("拖到舞台内跟随", cat.x, 250)
host:on_mouse(1000, 281)            -- 世界 550，舞台外
check("舞台外拖动不移动", cat.x, 250)
host:on_mouse(1100, 281)            -- 仍在舞台外
check("持续舞台外不移动", cat.x, 250)
host:on_mouse(700, 281)             -- 世界 250，回到舞台
check("回到舞台瞬移到手指+偏移", cat.x, 200)
host:on_mouse_released(700, 281)

-- 脚本在拖动中把角色移到别处：重算手指偏移，避免下一次移动瞬移
cat.x, cat.y = 200, 0
host:on_mouse_pressed(650, 281)
check("拖拽重新命中", host.drag_ent == cat, true)
cat.x, cat.y = 0, 0                 -- 脚本 move_to(0,0)
host:on_mouse(650, 281)
check("脚本移动后不瞬移回旧偏移", cat.x, 0)
host:on_mouse(700, 281)
check("脚本移动后按新偏移跟随", cat.x, 50)
host:on_mouse_released(700, 281)

-- 左右翻转：官方 LEFT_RIGHT 在 [90,270) 镜像
local function flip_of(dir)
  local _, f = ML.draw_rotation({ dir = dir, rotation_type = 1 })
  return f
end
check("左右翻转 180", flip_of(180), true)
check("左右翻转 0", flip_of(0), false)
check("左右翻转 90 含", flip_of(90), true)
check("左右翻转 270 不含", flip_of(270), false)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
