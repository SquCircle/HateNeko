-- M2 闭环测试：作品(.bcmkn) → 编译成 Lua → 在运行时里跑 → 断言行为
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local Helper = require("tests.helper")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

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


print("== 编译 ==")
local src = Helper.source("mini")
local report = Helper.report("mini")
local lines = select(2, src:gsub("\n", "\n")) + 1
check("生成了 Lua 源码", lines > 20, true)
check("识别出 3 个 hat", (report.hats["on_running_group_activated"] or 0) + (report.hats["self_listen"] or 0), 3)
check("规格表里查不到的块 = 0", (function()
  local n = 0
  for _ in pairs(report.unknown) do n = n + 1 end
  return n
end)(), 0)

-- 把生成结果写出来，便于人工查看。
-- Android/Termux 上 /tmp 不可写（issue：io.open 返回 nil 直接把测试崩在 setup 阶段），
-- 所以落到仓库内 .tmp（可用 KN_TMPDIR 覆盖）。
local dumpdir = os.getenv("KN_TMPDIR") or ".tmp"
os.execute('mkdir -p "' .. dumpdir .. '"')
local dump = dumpdir .. "/mini_compiled.lua"
do
  local o = assert(io.open(dump, "wb"), "无法写入测试产物: " .. dump)
  o:write(src)
  o:close()
  print("  -- 生成源码已写入 " .. dump)
end

print("== 载入运行时 ==")
local host = Headless.new()
rt.set_host(host)
local chunk = assert((loadstring or load)(src, "@mini_compiled"))
local compiled_work = chunk()
check("编译产物有元数据", type(compiled_work.actors), "table")
check("编译产物声明了 requires", #(compiled_work.requires or {}) > 0, true)

local game = rt.load(compiled_work, host)
check("加载期自检：无缺失原语", game.missing_primitives == nil, true)
check("角色实体已创建", #game.entities, 3) -- 1 屏幕 + 2 角色

rt.start()
local function run(n)
  for _ = 1, n do rt.step(1 / 60) end
end

print("== 跑起来 ==")
run(1)
check("第 1 帧：计数已加 1（循环第 1 轮）", game.vars["v_count"], 1)
check("第 1 帧：广播尚未发出", game.vars["v_flag"], 0)

run(20)
check("重复 3 次循环跑完（计数=3）", game.vars["v_count"], 3)
check("广播发出后 a1 收到（标志=1）", game.vars["v_flag"], 1)
check("广播发出后 a2 收到（总计=1）", game.vars["v_total"], 1)
check("循环结束后 else 分支外的赋值执行（完成=1）", game.vars["v_done"], 1)
check("如果条件成立 → 猫前进了 10", game:find("a1").x, 10)

print("")
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
