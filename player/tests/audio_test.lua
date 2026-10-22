-- 音频语义测试：播放 / 播放直到结束（阻塞）/ 停止
-- 用 tests/fixtures/audio.bcmkn（声音文件是本地放好的 works/assets/snd1.mp3）
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

local src = Helper.source("audio")

local host = Headless.new()
rt.set_host(host)
local work = assert((loadstring or load)(src, "@audio"))()
local game = rt.load(work, host)
check("声音资源已编入作品", work.audios["snd1"] ~= nil, true)
check("声音文件指向 assets/snd1.mp3", work.audios["snd1"].file, "assets/snd1.mp3")

local function played_count()
  local n = 0
  for _ in ipairs(host.audios or {}) do n = n + 1 end
  return n
end

rt.start()
for _ = 1, 3 do rt.step(1 / 60) end
check("播放了一次", played_count() >= 1, true)
check("音量按 100 → 1.0 归一", host.audios[1] and host.audios[1].volume, 1)
check("阻塞在『播放直到结束』上（还没设置完成标记）", game.vars["v_done"], 0)

for _ = 1, 30 do rt.step(1 / 60) end
check("等待结束后继续执行", game.vars["v_done"], 1)
check("最后调用了停止", game.vars["v_stopped"], 1)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
