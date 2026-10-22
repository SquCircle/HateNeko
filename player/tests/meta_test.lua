-- 元数据完整性测试：编译器给角色的元数据，必须**全部**落到实体上。
-- （这条坑踩过三次：order 漏了→图层空转；img_w 漏了→碰撞恒假；scene/scenes 漏了→角色不随屏幕显隐）
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local Helper = require("tests.helper")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local KEYS = { "order", "layer", "scene", "scenes", "is_global" }
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

for _, path in ipairs({ "switch", "now" }) do
  local work = Helper.compiled(path)
  local host = Headless.new()
  rt.set_host(host)
  local game = rt.load(work, host)
  host:preload(game)

  local dropped, checked = {}, 0
  for _, spec in ipairs(work.actors or {}) do
    local e = game:find(spec.id)
    if e then
      checked = checked + 1
      for _, k in ipairs(KEYS) do
        if spec[k] ~= nil and e[k] == nil then dropped[#dropped + 1] = spec.id:sub(1, 8) .. "." .. k end
      end
    end
  end
  local name = path
  check(("%s：所有角色的元数据都落到了实体（检查 %d 个）"):format(name, checked), #dropped == 0, true)
  if #dropped > 0 then print("     丢失:", table.concat(dropped, ", "):sub(1, 160)) end
end

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
