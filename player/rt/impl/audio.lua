-- 声音相关原语（实际播放交给宿主）
-- 统一签名：function(self, args, th)
local V = require("rt.values")

local M = {}

local function game(th) return th.sched.game end

-- 音频 id 优先（uuid）；名字仅作兜底
local function audio_key(args)
  return args.audio_id or args.audio or args.sound_id or args.name
end

-- 把 id/名字统一解析成作品音频清单里的键（先 id，再名字）
local function resolve_audio_id(g, key)
  if key == nil then return nil end
  if g.audios and g.audios[key] then return key end
  for id, a in pairs(g.audios or {}) do
    if a.name ~= nil and tostring(a.name) == tostring(key) then return id end
  end
  return key
end

-- 播放声音：返回时长（毫秒）供"播放直到结束"用
function M.play_audio(self, args, th)
  local g = game(th)
  local id = resolve_audio_id(g, audio_key(args))
  local loop = false
  if args.loop ~= nil then loop = V.bool(args.loop) end
  local vol = V.num(args.volume or 100)
  if vol > 1 then vol = vol / 100 end
  g.host:play_audio(id, loop, vol)
end

function M.play_audio_and_wait(self, args, th)
  -- 官方 playAudioAndWait @1622617：拿 thread_lock，等 PLAY_END / PLAY_FAIL / PLAY_TIMEOUT；
  -- 循环音不会自己结束 → 线程一直等到 stop_audio（不能用固定时长解阻塞）。
  local g = game(th)
  local id = resolve_audio_id(g, audio_key(args))   -- 名字也要能解析（歌词角色传的是 obj_xxx 名字）
  local vol = V.num(args.volume or 100)
  if vol > 1 then vol = vol / 100 end
  local loop = V.bool(args.loop)
  local ms = g.host:play_audio(id, loop, vol) or 0
  if g.host.audio_playing then
    local guard = 0
    while g.host:audio_playing(id) do
      if not th or type(th.block) ~= "function" then break end
      th:block(16)
      guard = guard + 1
      if guard > 60 * 60 * 10 then break end -- 10 分钟安全上限（避免坏资源永久卡线程）
    end
  elseif ms > 0 then
    th:block(ms)
  end
end

-- 播放声音并返回「播放器的声音」句柄（KN 的声音控制积木都吃这个句柄；我们直接用音频 id 当句柄）
function M.get_play_audio(self, args, th)
  local g = game(th)
  local id = resolve_audio_id(g, audio_key(args))
  local loop = false
  if args.loop ~= nil then loop = V.bool(args.loop) end
  local vol = V.num(args.volume or 100)
  if vol > 1 then vol = vol / 100 end
  g.host:play_audio(id, loop, vol)
  return id or ""
end

function M.stop_audio(self, args, th)
  local g = game(th)
  local key = audio_key(args)
  -- 「全部声音」：官方是停掉所有正在播的声音
  local k = tostring(key or ""):lower()
  if k == "all" or k == "all_audio" or k == "全部声音" or k == "全部" then
    g.host:stop_audio("all")
    return
  end
  g.host:stop_audio(resolve_audio_id(g, key))
end

-- 语音/TTS 类：没有 TTS 时就当普通声音或忽略
function M.play_words_audio(self, args, th) end
function M.play_word_audio_wait(self, args, th) end
function M.voice_recognition(self, args, th) end

-- 官方 sound_color（0.18，设置语音音色）：{per,speed,pitch,volume} 交给 TTS。
-- 离线 LÖVE 没有语音合成；这里保存配置并调用宿主的可选钩子，绝不假装能发声。
function M.sound_color(self, args, th)
  local g = game(th)
  local conf = {
    per = V.num(args.sound_color_per or args.per or 0),
    speed = V.num(args.sound_color_speed or args.speed or 10),
    pitch = V.num(args.sound_color_pitch or args.pitch or 10),
    volume = V.num(args.sound_color_volume or args.volume or 10),
  }
  g.voice_color = conf
  if g.host and g.host.set_voice_color then g.host:set_voice_color(conf) end
end

-- 旧版「播放的声音」影子：作为输入时编译器通常已内联为字面量；运行期兜底返回 id。
function M.get_play_audio(self, args)
  return args.audio_id or args.TEXT or args.variable
end

return M
