-- 命中检测几何测试（对应官方 PIXI containsPoint：精灵局部矩形 + 朝向）
package.path = "./?.lua;" .. package.path
local Hit = require("rt.hit")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-42s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-42s %s"):format(desc, tostring(got)))
  end
end

local function mk(spec)
  -- 官方几何口径：尺寸 = texture(img_w/img_h) × scale（scale_x/scale_y 为独立轴缩放）
  local e = { kind = "actor", visible = true, x = spec.x or 0, y = spec.y or 0,
              dir = spec.dir or 0, scale_x = (spec.scale or 100)/100, scale_y = (spec.scale or 100)/100,
              scale_x = spec.scale_x, scale_y = spec.scale_y, flip_x = spec.flip_x, flip_y = spec.flip_y,
              img_w = spec.img_w or 100, img_h = spec.img_h or 50, id = spec.id }
  return e
end

-- 正放：100x50 的造型
local g = { entities = { mk { id = "a" } } }
check("中心命中", Hit.test(g, 0, 0) ~= nil, true)
check("边界内 (49,24) 命中", Hit.test(g, 49, 24) ~= nil, true)
check("横向超出 (51,0) 不命中", Hit.test(g, 51, 0) ~= nil, false)
check("纵向超出 (0,26) 不命中", Hit.test(g, 0, 26) ~= nil, false)
check("远处不命中", Hit.test(g, 500, 500) ~= nil, false)

-- 旋转 90°（逆时针，y 向上）→ 盒子变 50 宽 x 100 高
local g2 = { entities = { mk { id = "b", dir = 90 } } }
check("旋转90 后 (0,49) 命中", Hit.test(g2, 0, 49) ~= nil, true)
check("旋转90 后 (49,0) 不命中", Hit.test(g2, 49, 0) ~= nil, false)

-- 宽高积木覆盖尺寸（轴对齐拉伸）
local g3 = { entities = { mk { id = "c", scale_x = 2 } } } -- 官方口径：texture 100 × scale.x 2 = 200
check("设定宽 200 后 (99,0) 命中", Hit.test(g3, 99, 0) ~= nil, true)
check("设定宽 200 后 (101,0) 不命中", Hit.test(g3, 101, 0) ~= nil, false)

-- 最上层优先（列表后面的实体在上面）
local top = mk { id = "top" }
local g4 = { entities = { mk { id = "bottom" }, top } }
check("重叠时取最上层", Hit.test(g4, 0, 0), top)

-- 隐藏的角色不参与命中
local g5 = { entities = { { kind = "actor", visible = false, x = 0, y = 0, img_w = 100, img_h = 50 } } }
check("隐藏角色不命中", Hit.test(g5, 0, 0) ~= nil, false)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
