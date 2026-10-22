-- variables_ui: 变量类型/style/位置/实体前缀/Qz
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local V = require("rt.values")
local host = Headless.new(); rt.set_host(host)
local g = rt.load(assert(loadfile("works/variables_ui.lua"))(), host)
local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1; print(("  FAIL %-44s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else print(("  ok   %-44s %s"):format(desc, tostring(got))) end
end
local ids = {
  l = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e",
  a = "907c2988-26f0-4b65-9041-df903b58a71f",
  b = "b9a5fde6-b9ce-49f7-938d-44d616365eb7",
  c = "700e56c3-cac3-40b9-afe0-e000081bf5eb",
  d = "fdeb2504-08b6-4cc5-af26-2b8eb55e0ee6",
  e = "14610c97-1d7d-476c-b981-0f433b2688ce",
  f = "f0e08235-a1f0-4e60-9dbe-00c141374da2",
  g = "35a2941d-fad4-4107-b05e-c5a62768c266",
  h = "b96e63cd-f270-4f51-802d-87624e4611df",
}
for name, id in pairs(ids) do
  local m = g.var_meta[id]
  check(name .. " meta", m ~= nil, true)
  if m then
    check(name .. " visible", m.visible, true)
    check(name .. " pos", m.position.y, ({l=0,a=80,b=160,c=240,d=320,e=400,f=496,g=20,h=100})[name])
  end
end
check("b entity name", g.var_meta[ids.b].entity_name, "编程猫")
check("g is local list", g.var_meta[ids.g].is_global, false)
check("e icon style", g.var_meta[ids.e].style, "icon_coin")
check("c public", g.var_meta[ids.c].type, "public")
check("d private", g.var_meta[ids.d].type, "private")
check("h private_list", g.var_meta[ids.h].type, "private_list")
check("Qz nested", V.list_display({1,{2},true}), "[1,[...],true]")
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
