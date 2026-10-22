-- 单位一致性测试：每个原语的入参/出参单位必须与官方一致（见 docs/units.md）
package.path = "./?.lua;" .. package.path
local ML = require("rt.impl.motion_looks")
local S = require("rt.impl.op_sensing")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  local ok
  if type(got) == "number" and type(want) == "number" then
    ok = math.abs(got - want) < 1e-6
  else
    ok = got == want
  end
  if not ok then
    fails = fails + 1
    print(("  FAIL %-44s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-44s %s"):format(desc, tostring(got)))
  end
end

-- 假环境：appearance_of_sprite 只需要 sched.game
local g = { find = function(_, id) return nil end }
local th = { sched = { game = g } }
local function actor(t)
  local e = { scale_x = 1, scale_y = 1, dir = 90, visible = true, x = 0, y = 0, img_w = 100, img_h = 50 }
  for k, v in pairs(t or {}) do
    -- 兼容旧写法 scale=63（百分比）→ 两轴倍数
    if k == "scale" then e.scale_x, e.scale_y = v / 100, v / 100 else e[k] = v end
  end
  return e
end

-- ① appearance：scale = 百分比（作品 (115 - appearance) 的依据）
check("appearance(scale) 默认 = 100", S.appearance_of_sprite(actor(), { appearance = "scale" }, th), 100)
check("appearance(scale) scale=63 → 63", S.appearance_of_sprite(actor{scale = 63}, { appearance = "scale" }, th), 63)

-- ② width/height 也是**百分比**（100 = 原尺寸）；用户确认：获取/更改角色大小都是百分数
check("appearance(width) 100×100% = 100", S.appearance_of_sprite(actor(), { appearance = "width" }, th), 100)
check("appearance(width) 100×50% = 50", S.appearance_of_sprite(actor{scale = 50}, { appearance = "width" }, th), 50)
check("appearance(height) 200% = 200", S.appearance_of_sprite(actor{scale = 200}, { appearance = "height" }, th), 200)
check("appearance(width) 用 scale_x", S.appearance_of_sprite(actor{scale_x = 2}, { appearance = "width" }, th), 200)

-- ③ direction = 度
check("appearance(direction) = 90", S.appearance_of_sprite(actor{dir = 90}, { appearance = "direction" }, th), 90)

-- ④ change_scale：支持减少
local e = actor{ scale = 100 }
ML.self_change_scale(e, { increase = "increase", scale = 10 })
check("change_scale 增加 10 → 110", (e.scale_x or 0) * 100, 110)
ML.self_change_scale(e, { increase = "decrease", scale = 10 })
check("change_scale 减少 10 → 100", (e.scale_x or 0) * 100, 100)

-- ⑤ set_scale：百分比 → 内部倍数一致
local e2 = actor{}
ML.set_scale(e2, { scale = 63 })
check("set_scale(63) 两轴 0.63", ((e2.scale_x or 0) * 100), 63)
check("set_scale(63) 绘制用 0.63", (e2.scale_x or 1), 0.63)

-- ⑥ 宽高缩放：设置/增加/减少，且按轴独立
local e3 = actor{}
ML.set_width_height_scale(e3, { type = "width", value = 200 })
check("宽 200% → scale_x=2", e3.scale_x, 2)
ML.add_width_height_scale(e3, { type = "width", increase = "increase", value = 50 })
check("宽 +50% → 2.5", e3.scale_x, 2.5)
ML.add_width_height_scale(e3, { type = "width", increase = "decrease", value = 50 })
check("宽 -50% → 2.0", e3.scale_x, 2)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
