-- G6-3 图层序单测：render 自下而上，hit 严格反序；克隆体在父体之后/之上。
package.path = "./?.lua;" .. package.path

local Core = require("rt.core")
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

local function mk(id, order)
  local e = Core.Entity.new {
    id = id, name = id, order = order, styles = {}, style_index = 1,
    visible = true, x = 0, y = 0, img_w = 10, img_h = 10,
  }
  return e
end

local function names(list)
  local out = {}
  for i = 1, #list do out[i] = list[i].name end
  return table.concat(out, ",")
end

-- ① order 大 = 上层：render 底部先、hit 顶部先
local bottom = mk("bottom", 1)
local top = mk("top", 2)
local g = { entities = { bottom, top }, cur_screen = nil, stage_w = 100, stage_h = 100 }
check("render 底部→顶部", names(Scene.render_list(g)), "bottom,top")
check("hit  顶部→底部", names(Scene.hit_list(g)), "top,bottom")

-- ② 克隆体：同 order 时排在父体之后（更上层）
local parent = mk("parent", 5)
local clone = parent:clone_self()
clone.name = "clone"
local g2 = { entities = { parent, clone }, cur_screen = nil, stage_w = 100, stage_h = 100 }
check("克隆体 seq 大于父体", (clone.seq or 0) > (parent.seq or 0), true)
check("render 父体→克隆", names(Scene.render_list(g2)), "parent,clone")
check("hit  克隆→父体", names(Scene.hit_list(g2)), "clone,parent")

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
