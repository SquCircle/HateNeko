-- perf_layers: 300 mirror clones + set_top_bottom_layer(peak)
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local host = Headless.new()
rt.set_host(host)
local g = rt.load(assert(loadfile("works/perf_layers.lua"))(), host)
rt.start()

local base
for _, e in ipairs(g.entities) do if e.name == "编程猫" and not e.is_clone then base = e end end
for _ = 1, 320 do rt.step(1 / 60) end

local clones = 0
for _, e in ipairs(g.entities) do if e.is_clone then clones = clones + 1 end end
local maxl, minl = -1e9, 1e9
for _, e in ipairs(g.entities) do
  if e.kind == "actor" then
    maxl = math.max(maxl, e.layer or 0); minl = math.min(minl, e.layer or 0)
  end
end
local rl = require("rt.scene").render_list(g)
local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-46s %s"):format(desc, tostring(got)))
  end
end
check("克隆数量", clones, 300)
check("基础角色 peak 图层", base and base.layer or 0, maxl)
check("顶层为编程猫本体", rl[#rl] == base, true)
check("实体总数", #g.entities, 302)
check("无线程错误", (function()
  for _, l in ipairs(host.logs or {}) do if tostring(l):find("线程错误", 1, true) then return false end end
  return true
end)(), true)
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
