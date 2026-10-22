-- 包 L：真机 actorIds 自上而下 → order 反置；render_list 必须自下而上（order 升序）。
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local Scene = require("rt.scene")

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

local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/now.lua"))(), host)
g:switch_screen("6c9fdf0c-4483-4cd6-b886-c059b7c2b58f")
local list = Scene.render_list(g)
check("菜单 render 数", #list, 18)
check("最底是遮罩(order 1)", list[1] and list[1].name, "遮罩")
check("最顶是手指(order 30)", list[#list] and list[#list].name, "手指")
local ascending = true
for i = 2, #list do
  if (list[i - 1].order or 0) > (list[i].order or 0) then ascending = false end
end
check("order 严格升序（同 order 允许 seq）", ascending, true)
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
