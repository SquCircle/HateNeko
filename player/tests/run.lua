-- M1 headless 验证：调度语义 / 阻塞 / warp 预算 / 广播 / 克隆 / tell / 作用域 / break / 未知块
-- 用法：cd knplayer && lua5.1 tests/run.lua   （或 luajit tests/run.lua）
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local DT = 1 / 60
local fails, checks = 0, 0

local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL  %-38s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok    %-38s %s"):format(desc, tostring(got)))
  end
end

-- 这个测试需要一个手写作品（调度语义专用）。清理时它随 works/ 一起删了，
-- 重建后放在 tests/fixtures/test_basic.lua；缺它必须硬失败，不能静默跳过。
local ok_w, work_basic = pcall(require, "tests.fixtures.test_basic")
if not ok_w or type(work_basic) ~= "table" then
  print("  FAIL：缺 tests/fixtures/test_basic.lua（调度语义专用测试作品）")
  os.exit(1)
end

local host = Headless.new()
rt.set_host(host)
local game = rt.load(work_basic)
local cat, dog = game:find("cat"), game:find("dog")
local V = rt.game.vars

local function run(n)
  for _ = 1, n do rt.step(DT) end
end

print("== 载入与绿旗 ==")
check("实体数（cat+dog）", #game.entities, 2)
rt.start()

print("== 第 1 帧 ==")
run(1)
check("主循环跑了 1 次迭代", V["v:loop"], 1)
check("帧计数", V["v:frames"], 1)
check("warp 循环跑满预算 30000 次", V["v:warpn"], 30000)
check("第 1 帧等待尚未结束（阻塞）", V["v:wait"], 0)

print("== 第 2~4 帧：warp 预算每帧重置 ==")
run(1)
check("第 2 帧 warp 累计 60000", V["v:warpn"], 60000)
check("第 2 帧仍未等到", V["v:wait"], 0)
run(1)
check("第 3 帧 warp 累计 90000", V["v:warpn"], 90000)
check("第 3 帧仍未等到", V["v:wait"], 0)

-- 此刻等待脚本应处于「阻塞」状态：调度器整帧跳过它（不 resume、不计 warp 迭代）
local blocked_now = 0
for i = 1, #game.sched.threads do
  if game.sched.threads[i].blocked_until > host:now_ms() then blocked_now = blocked_now + 1 end
end
check("第 3 帧存在被阻塞的线程", blocked_now >= 1, true)

run(1)
check("第 4 帧 warp 跑到 100000 后 break", V["v:warpn"], 100000)
check("warp 循环结束值", V["v:warp"], 100000)

print("== 继续跑到第 12 帧：等待/广播/克隆/tell 全部收尾 ==")
run(8)
check("3 次等待全部完成", V["v:wait"], 3)
check("等待脚本收尾", V["v:waitdone"], 1)

print("== 广播 / 广播并等待 ==")
check("接收者已执行", V["v:bc"], 1)
check("接收者（含等待）已执行完", V["v:bc2"], 1)
check("发送方在所有接收者结束后才继续", V["v:bcafter"], 1)

print("== 克隆 ==")
check("克隆体执行了 start_as_a_mirror", V["v:clones"], 1)
check("克隆体里 self 是克隆体本身", V["v:cloneself"], 1)
check("父体克隆计数已回收", cat.clones, 0)
local clone_left = 0
for i = 1, #game.entities do if game.entities[i].is_clone then clone_left = clone_left + 1 end end
check("克隆体已从场景移除", clone_left, 0)

print("== 告诉执行并等待 ==")
check("目标角色执行了被告诉的脚本", V["v:told"], 1)
check("被告诉的脚本里 self 是目标角色", V["v:telltarget"], 1)
check("调用方等到目标跑完才继续", V["v:syncdone"], 1)

print("== 变量作用域 / 列表 ==")
check("全局写入", V["v:g"], 1)
check("实体作用域写入", cat.vars["v:e"], 5)
check("脚本私有变量读取", V["v:scope_result"], 7)
check("列表长度", V["v:listlen"], 2)
check("列表首项", V["v:listfirst"], 42)

print("== break / 未知块 / when ==")
check("break 跳出循环", V["v:brk"], 3)
check("未知块降级后脚本继续跑", V["v:unknown"], 1)
check("未知块被记账", (rt.stats.missing["open_hide_camera"] or 0) >= 1, true)
check("when hat 被触发过", (V["v:whencount"] or 0) >= 2, true)

print("== 收尾状态 ==")
local alive = 0
for i = 1, #game.sched.threads do
  if not game.sched.threads[i].done then alive = alive + 1 end
end
check("无限循环脚本仍在跑（frames 在涨）", V["v:frames"] > 10, true)
check("存活线程只剩那个无限循环脚本", alive, 1)

print("")
print(("未实现/未知原语报告：%s"):format(table.concat(rt.missing_report(), ", ")))
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
