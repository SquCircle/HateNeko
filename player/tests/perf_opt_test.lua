-- 性能优化的行为等价性回归（不测 FPS，只保证优化没有改变语义/顺序）
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")
local Hit = require("rt.hit")
local Scene = require("rt.scene")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-52s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-52s %s"):format(desc, tostring(got)))
  end
end

-- ---------------------------------------------------------------- 1. alpha_at 两种格式
local rgba = string.char(10, 20, 30, 0, 40, 50, 60, 255)
local px_new = { w = 2, h = 1, rgba = rgba }
local px_old = { w = 2, h = 1, alpha = string.char(0, 255) }
check("alpha_at 新格式 第1像素", Hit.alpha_at(px_new, 1), 0)
check("alpha_at 新格式 第2像素", Hit.alpha_at(px_new, 2), 255)
check("alpha_at 旧格式兼容", Hit.alpha_at(px_old, 2), 255)
check("alpha_at 空值", Hit.alpha_at(nil, 1), 0)

-- ---------------------------------------------------------------- 2. render_list 复用 + 顺序变化
local h = Headless.new()
rt.set_host(h)
local game = { host = h, entities = {}, vars = {}, lists = {}, screens = {}, cur_screen = nil,
  stage_w = 900, stage_h = 562 }
local function ent(id, layer, order, seq)
  return { id = id, kind = "actor", visible = true, layer = layer, order = order, seq = seq,
    styles = { "s" }, style_index = 1 }
end
local a = ent("a", 0, 1, 1)
local b = ent("b", 0, 2, 2)
game.entities = { a, b }
local l1 = Scene.render_list(game)
check("render_list 自下而上", l1[1].id .. "," .. l1[2].id, "a,b")
local l2 = Scene.render_list(game)
check("render_list 复用同一张表", l1 == l2, true)
b.layer = -1
local l3 = Scene.render_list(game)
check("render_list 顺序变化后重排", l3[1].id .. "," .. l3[2].id, "b,a")
a.visible = false
local l4 = Scene.render_list(game)
check("render_list 隐藏后长度", #l4, 1)
check("render_list 隐藏后内容", l4[1].id, "b")
a.visible = true
local l5 = Scene.render_list(game)
check("render_list 恢复后长度", #l5, 2)

-- ---------------------------------------------------------------- 3. clones_of 缓存与失效
local h2 = Headless.new()
rt.set_host(h2)
local work = {
  stage_w = 900, stage_h = 562, vars = {}, screens = {},
  actors = { { id = "root", name = "R", x = 0, y = 0, styles = { "s1" }, style_index = 1 } },
  assets = {}, audios = {},
}
local g = rt.load(work, h2)
rt.start()
local root = g:find("root")
check("clones_of 初始", #g:clones_of(root), 0)
local c1 = root:clone_self(); g.entities[#g.entities + 1] = c1
local c2 = root:clone_self(); g.entities[#g.entities + 1] = c2
root.clones = 2
check("clones_of 两个克隆", #g:clones_of(root), 2)
g.sched:dispose_clone(c1)
check("clones_of 删除后立即失效", #g:clones_of(root), 1)
local c3 = root:clone_self(); g.entities[#g.entities + 1] = c3
root.clones = 2
check("clones_of 新增后重建", #g:clones_of(root), 2)
g.sched:apply_deferred()
check("clones_of 帧末删除后", #g:clones_of(root), 2)

-- ---------------------------------------------------------------- 4. 颜色作品标记（PERF-2）
local function flag_of(name)
  local hh = Headless.new(); rt.set_host(hh)
  local gg = rt.load(require("works." .. name), hh)
  return gg.uses_color_touch
end
check("now 不需要颜色底图", flag_of("now"), false)
check("sensing_new 需要颜色底图", flag_of("sensing_new"), true)

-- ---------------------------------------------------------------- 5. 快路径结果一致
local h3 = Headless.new(); rt.set_host(h3)
local fake = { host = h3, entities = {}, vars = {}, lists = {}, screens = {}, cur_screen = nil,
  stage_w = 900, stage_h = 562, frame = 1 }
fake.find = function(self, id)
  for _, e in ipairs(self.entities) do if e.id == id or e.name == id then return e end end
end
local selfE = { id = "e1", name = "E", x = 12, y = -7, kind = "actor", img_w = 100, img_h = 100,
  style_id = function() return "s1" end, styles = { "s1" }, style_index = 1, visible = true,
  effects = {}, alpha = 100 }
fake.entities = { selfE }
h3.game = fake
local th = { sched = { game = fake } }
rt.build_f(); local f = rt.f
check("coordinate fast x", f.coordinate_of_sprite(selfE, { sprite = "--self", coordinate = "x" }, th), 12)
check("coordinate fast y", f.coordinate_of_sprite(selfE, { sprite = "--self", coordinate = "y" }, th), -7)
check("math fast add", f.math_arithmetic(nil, { A = 2, B = 3, type = "add" }, th), 5)
check("math fast div0 NaN", (function()
  local v = f.math_arithmetic(nil, { A = 0, B = 0, type = "divide" }, th)
  return (type(v) == "number" and v ~= v) and "NaN" or v
end)(), "NaN")
check("math string add 仍走 JS 语义", f.math_arithmetic(nil, { A = "a", B = 1, type = "add" }, th), "a1")

-- ---------------------------------------------------------------- 6. 效果画布池 / 笔层批量（伪 love）
local LoveH = require("rt.host.love")
local old_love = love
local made, pushes, pops, sets, clears = 0, 0, 0, 0, 0
love = {
  graphics = {
    newCanvas = function(w, h)
      made = made + 1
      return { w = w, h = h,
        getWidth = function(self) return self.w end,
        getHeight = function(self) return self.h end,
        setFilter = function() end }
    end,
    push = function() pushes = pushes + 1 end,
    pop = function() pops = pops + 1 end,
    setCanvas = function() sets = sets + 1 end,
    origin = function() end,
    clear = function() clears = clears + 1 end,
  },
}

local inst = setmetatable({ _fx_pool = {} }, LoveH)
local c1 = inst:_fx_get_canvas(64, 64)
check("fx 首次新建", made, 1)
inst:_fx_put_canvas(c1)
local c2 = inst:_fx_get_canvas(64, 64)
check("fx 复用同尺寸画布", made, 1)
check("fx 复用同一对象", c2, c1)
local c3 = inst:_fx_get_canvas(32, 32)
check("fx 新尺寸才新建", made, 2)
inst._fx_clone_cache = { k = { canvas = c1, w = 64, h = 64 } }
inst._fx_frame_cache = { k2 = { canvas = c3, w = 32, h = 32 } }
inst:_fx_release_caches()
check("fx 释放后缓存清空", next(inst._fx_clone_cache), nil)
check("fx 释放后画布回池", made, 2)

local inst2 = setmetatable({}, LoveH)
local A = { id = "A" }
local B = { id = "B" }
inst2:_pen_batch_begin(A, false)
inst2:_pen_batch_begin(A, false)
check("笔层批量：同 canvas 只 push 一次", pushes, 1)
check("笔层批量：只 setCanvas 一次", sets, 1)
inst2:_pen_batch_begin(B, false)
check("笔层批量：换屏 canvas 先 pop 再 push", pops, 1)
check("笔层批量：两次 push", pushes, 2)
local m = inst2:_pen_batch_begin(A, true)
inst2:_pen_batch_end(m)
check("笔层绘制阶段用局部 push/pop", pops, 2)
inst2:end_frame(0)
check("笔层帧末 pop", pops, 3)
check("笔层帧末清 active", inst2._pen_active, false)

love = old_love

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
