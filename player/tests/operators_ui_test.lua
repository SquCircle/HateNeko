-- operators 作品：变量/列表元数据、列表值、Qz 字符串化
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local V = require("rt.values")
local Data = require("rt.impl.data")

local host = Headless.new(); rt.set_host(host)
local g = rt.load(assert(loadfile("works/operators.lua"))(), host)
local id = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e"
local m = g.var_meta[id]
local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else print(("  ok   %-46s %s"):format(desc, tostring(got))) end
end
check("列表元数据存在", m ~= nil, true)
check("类型 list", m and m.type, "list")
check("默认可见", m and m.visible, true)
check("默认位置", m and m.position.x, 0)
check("Qz 普通数组", V.list_display({1, 2, 3}), "[1,2,3]")
check("Qz 嵌套数组", V.list_display({1, {2, 3}, true}), "[1,[...],true]")
check("Qz 空数组", V.list_display({}), "[]")
check("JS String 数组", V.js_str({1, 2, 3}), "1,2,3")

rt.start()
for _ = 1, 3 do rt.step(1 / 60) end
local l = g:get_list(id, nil, nil)
check("列表长度", #l, 20)
check("列表首项", l[1], 0.1 + 0.2)
check("列表文本项", l[15], "abc")
check("嵌套列表项 Qz", V.list_display(l[19]), "[a,b,c]")

-- show/hide 元数据
Data.show_hide_variables(nil, { variable = id, show_hide = "hide" }, { sched = g.sched })
check("hide 后 visible", m.visible, false)
Data.show_hide_variables(nil, { variable = id, show_hide = "show" }, { sched = g.sched })
check("show 后 visible", m.visible, true)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
