-- 变量/列表 monitor 的渲染参数：值框不越界、长文本省略、列表箭头用 ↓
package.path = "./?.lua;" .. package.path
local Mon = require("rt.host.monitors_at")

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

-- 假 At：只实现 monitors_at 用到的构造/字体测量；getWidth 按 8px/UTF-8 字节。
local F = {}
function F:getWidth(s)
  -- 按 UTF-8 码点计数（近似真实字体），别把 “…” 的 3 字节当 3 个字符宽
  local _, n = tostring(s):gsub("[^\128-\191]", "")
  return n * 8
end
local fakeAt = {
  font = { get = function() return F end },
  Panel = function(o) o.draw = function() end return o end,
  Label = function(o) o.draw = function() end return o end,
  Button = function(o) o.draw = function() end return o end,
  add = function() end,
  remove = function() end,
}
package.loaded["At.At"] = fakeAt

local g = { stage_w = 900, stage_h = 562, var_meta = {}, vars = {} }
function g:get_var(id) return self.vars[id] end
function g:get_list(id) return self.vars[id] end
local host = {}
function host:world_to_screen(x, y) return 450 + x, 281 - y end

g.var_meta.v = { id = "v", name = "score", type = "any",
  position = { x = 0, y = 0 }, scale = 1, visible = true }
g.vars.v = 123.456
g.var_meta.vlong = { id = "vlong", name = string.rep("LongName", 20), type = "any",
  position = { x = 0, y = 100 }, scale = 1, visible = true }
g.vars.vlong = string.rep("9", 120)
g.var_meta.l = { id = "l", name = "items", type = "list",
  position = { x = 0, y = 200 }, scale = 1, visible = true }
g.vars.l = {}

local mon = Mon.new(host)
mon:build(g)
local p = mon.parts
check("部件总数（变量4×2 + 列表5）", #p, 13)

-- 普通变量：值框、值文字都在面板内
local root1, lab1, box1, val1 = p[1], p[2], p[3], p[4]
check("变量名", lab1.text, "score")
check("值文本", val1.text, "123.456")
check("值框不越出面板", box1.x + box1.w <= root1.x + root1.w + 0.001, true)
check("值框留出左内边距", box1.x >= root1.x + 24 + F:getWidth(lab1.text) - 0.001, true)
check("值文字不越出值框", val1.x + F:getWidth(val1.text) <= box1.x + box1.w - 8 + 0.001, true)

-- 超长名称/值：面板被舞台宽度钳住后，名称和值都要省略，值框仍收在面板内
local root2, lab2, box2, val2 = p[5], p[6], p[7], p[8]
check("长名称有省略或为空", lab2.text == "" or lab2.text:find("…", 1, true) ~= nil, true)
check("长值用省略号", val2.text:find("…", 1, true) ~= nil, true)
check("长值框不越出面板", box2.x + box2.w <= root2.x + root2.w + 0.001, true)
check("长值框右边界=面板-10", math.abs((box2.x + box2.w) - (root2.x + root2.w - 10)) <= 0.51, true)
check("长值文字不越出值框", val2.x + F:getWidth(val2.text) <= box2.x + box2.w - 8 + 0.001, true)
check("面板不越出舞台", root2.x + root2.w <= 900.001, true)

-- 列表：箭头改成 ↓，且名称/箭头不互相压住
local root3, _pill3, lab3, arrow3, btn3 = p[9], p[10], p[11], p[12], p[13]
check("列表箭头是 ▽", arrow3.text, "▽")
check("不再使用旧箭头", (tostring(lab3.text) .. tostring(arrow3.text)):find("▾", 1, true) == nil, true)
check("列表名", lab3.text, "items")
check("箭头在面板内", arrow3.x + F:getWidth("▽") <= root3.x + root3.w + 0.001, true)
check("列表名不压箭头", lab3.x + F:getWidth(lab3.text) <= arrow3.x - 6 + 0.001, true)
check("列表按钮覆盖整行", btn3.w, root3.w)

package.loaded["At.At"] = nil
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
