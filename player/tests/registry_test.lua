-- 阶段 4：原语注册表 + schema 覆盖门。
-- 失败条件（任一）：
--   1) 同名不同实现且未登记 allow → 启动/测试失败；
--   2) 块目录里的非事件/非编译期/非离线块，没有对应运行期原语；
--   3) 运行期出现了未登记的新原语（防止加块忘 schema）。
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")
local Registry = require("rt.registry")

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

rt.set_host(Headless.new())
rt.build_f()
local S = rt.schema
check("schema 已生成", S ~= nil, true)
check("注册表冲突为 0", #rt.registry.conflicts, 0)
check("目录条目数", S and S.catalog_size or 0, 266)
check("5 个缺口块已实现", #{
  rt.f.script_variables_set, rt.f.change_script_variables, rt.f.get_sprite_property,
  rt.f.math_trig_rad, rt.f.sound_color,
}, 5)

local missing, unregistered = {}, {}
local implemented, skipped = 0, 0
for t in pairs(S.args) do
  if S.events[t] or S.compiler[t] or S.unsupported[t] then
    skipped = skipped + 1
  elseif type(rt.f[t]) == "function" then
    implemented = implemented + 1
  else
    missing[#missing + 1] = t
  end
end
for name, fn in pairs(rt.f) do
  if type(fn) == "function" and not S.args[name] and not S.known_extra[name] then
    unregistered[#unregistered + 1] = name
  end
end
table.sort(missing); table.sort(unregistered)
check("目录块无未实现", #missing, 0)
if #missing > 0 then print("   missing: " .. table.concat(missing, ", ")) end
check("运行期无未登记原语", #unregistered, 0)
if #unregistered > 0 then print("   unregistered: " .. table.concat(unregistered, ", ")) end
check("已实现目录块数量 > 150", implemented > 150, true)

-- 覆盖策略：动画最终由 effects 提供
check("动画原语归属 effects", rt.registry.providers["global_animation"], "rt.impl.effects")
-- 参数 schema：能查出未知参数键
local extra = Registry.unknown_args(S, "math_arithmetic", { A = 1, B = 2, type = "add" })
check("schema 已知参数不误报", #extra, 0)
extra = Registry.unknown_args(S, "math_arithmetic", { A = 1, B = 2, typo = 3 })
check("schema 能查出未知参数", table.concat(extra, ","), "typo")

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
