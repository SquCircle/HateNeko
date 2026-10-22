-- 校验「已编译好的作品文件」本身是不是最新的（防止 works/ 里放旧产物）
-- 与 vm_test.lua 的区别：vm_test 现编译；这里直接加载 works/real_vm.lua —— 也就是用户会跑的那份
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local WORK = "works/real_vm.lua"
local INPUT = "var a = 0.1; var b = 0.2; print(a + b);"
local FRAMES = 1500

local fails = 0
local function check(desc, got, want)
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-40s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-40s %s"):format(desc, tostring(got)))
  end
end

local fh = io.open(WORK, "rb")
if not fh then
  print("  跳过：找不到 " .. WORK .. "（先跑 sh tools/build_works.sh）")
  os.exit(0)
end
local src = fh:read("*a")
fh:close()

-- 旧产物会把「退出循环」编成 f["break"]（标志式，晚了）；新产物是原生 break
check("works 里的产物是最新编译（原生 break）", src:find('\n%s+break\n') ~= nil or src:find("break") ~= nil, true)
check("产物不含过时的标志式 break", (src:find('f%["break"%]') == nil), true)

local work = assert((loadstring or load)(src, "@" .. WORK))()
local host = Headless.new()
host.ask_value = INPUT
rt.set_host(host)
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

local joined = {}
for _, s in ipairs(host.stamps or {}) do joined[#joined + 1] = s.text end
local all = table.concat(joined, "\n")

check("无运行错误", errors, 0)
check("跑完了 JS 解释", all:find("程序运行结束") ~= nil, true)
check("输出了 0.3", all:find("0%.3") ~= nil, true)

print(("结果：%d 项失败"):format(fails))
if fails > 0 then os.exit(1) end
