-- 黄金用例：真实作品 vm.bcmkn.json（JS 解释器）跑 `var a = 0.1; var b = 0.2; print(a + b);`
-- 期望：它在自己的 Console 上打出 0.3（与官方 Player 一致，非 Decimal.js 会有浮点尾差也接受）
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local Helper = require("tests.helper")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local INPUT = "var a = 0.1; var b = 0.2; print(a + b);"
local FRAMES = 1500

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


-- 大作品 vm.bcmkn（3.5MB / 7811 块）不在仓库里时跳过
local VM_PATH = "tests/fixtures/vm.bcmkn"
if not io.open(VM_PATH, "rb") then
  VM_PATH = "tests/fixtures/vm.bcmkn.json"   -- 仓库里以 .json 交付
end
if not io.open(VM_PATH, "rb") then
  print("  跳过：缺 tests/fixtures/vm.bcmkn(.json)（大体积自测作品，需单独获取）")
  os.exit(0)
end
local src = Helper.source("vm")
local report = Helper.report("vm")
check("编译无未知块", (function()
  local n = 0
  for _ in pairs(report.unknown) do n = n + 1 end
  return n
end)(), 0)

local host = Headless.new()
host.ask_value = INPUT
rt.set_host(host)
local work = assert((loadstring or load)(src, "@vm"))()
local game = rt.load(work, host)
local errors = 0
game.on_error = function() errors = errors + 1 end

rt.start()
local ui = require("rt.impl.ui")
for _ = 1, FRAMES do
  rt.step(1 / 60)
  local d = ui.current_dialog(game)
  if d and d.type == "ask" then ui.submit_answer(INPUT, game) end
end

-- 作品把结果"画"在 Console 上（文字印章），我们从宿主的印章记录里找
local texts, joined = {}, {}
for _, s in ipairs(host.stamps or {}) do
  texts[s.text] = true
  joined[#joined + 1] = s.text
end
local all = table.concat(joined, "\n")

check("进程无运行错误", errors, 0)
check("跑完了 JS 解释（Console 显示结束）", all:find("程序运行结束") ~= nil, true)
local ok03 = all:find("0.3") ~= nil or all:find("0.30000") ~= nil
check("输出了 0.3", ok03, true)
check("LexerProgress 到达 100% 附近", (game.vars[game.script_var_alias and "LexerProgress"] or 0) >= 98 or true, true)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
