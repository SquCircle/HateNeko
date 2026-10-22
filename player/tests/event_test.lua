-- 事件/广播语义测试
-- 覆盖：当收到广播是否触发、消息不匹配是否不触发、广播并等待的阻塞顺序、带内容广播取值
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
    print(("  FAIL %-40s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-40s %s"):format(desc, tostring(got)))
  end
end

local src = Helper.source("events")

local host = Headless.new()
rt.set_host(host)
local work = assert((loadstring or load)(src, "@events"))()
local game = rt.load(work, host)
rt.start()

for _ = 1, 3 do rt.step(1 / 60) end
local V = game.vars
check("「当收到广播」被触发", V["v_go"], 1)
check("消息不匹配时不触发", V["v_other"], 0)
check("广播后的语句继续执行", V["v_after"], 1)
check("带内容广播取到参数", V["v_got"], "hello")
check("「广播并等待」期间发送者被阻塞", V["v_afterwait"], 0)

for _ = 1, 20 do rt.step(1 / 60) end
check("听者执行完毕", V["v_waited"], 1)
check("发送者在听者结束后继续", V["v_afterwait"], 1)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
