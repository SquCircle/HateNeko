-- Love2D 宿主：时间 / 输入事件 / 舞台绘制 / 音频占位
-- 舞台坐标：KN 562x900，原点在中心，+x 右、+y 上（与 Scratch 系一致，待与官方播放器比对）
local H = {}
H.__index = H

local TXT = 1 / 90 -- 1 步 = 多少像素（根据舞台高度动态计算，见 fit）

-- JS keyCode ↔ Love2D 键名（check_key / on_keydown 存的是 keyCode 数字）
-- 完整表在 rt/host/keymap.lua（与 headless 共用；H-3：Shift/Ctrl/Esc/F1/标点等都可用）
local Keymap = require("rt.host.keymap")
local KEYMAP = Keymap.by_code
local LOVE_TO_CODE = Keymap.name_to_code

function H.new(opts)
  opts = opts or {}
  local h = setmetatable({}, H)
  h.events = {}
  h.keys = {}
  h.key_states = {}   -- 按键动作状态：code -> "down" / "up"（官方 on_keydown action state）
  h.mouse_x, h.mouse_y = 0, 0
  h.mouse_is_down, h.mouse_clicked, h.mouse_up = false, false, false
  h.pointer_valid = false
  local dev = os.getenv("KN_DEVICE")
  if dev ~= "pc" and dev ~= "mobile" then
    local osname = "unknown"
    if love and love.system and love.system.getOS then
      local ok, v = pcall(love.system.getOS)
      if ok and v then osname = tostring(v) end
    end
    dev = (osname == "Android" or osname == "iOS") and "mobile" or "pc"
  end
  h.device_type, h.is_mobile = dev, dev == "mobile"
  h.logs = {}
  h.lines = {}
  h.verbose = opts.verbose or false
  h.assets = {}  -- style_id -> Image（M3 从作品目录加载）
  h.monitors = require("rt.host.monitors_at").new(h)
  h.ui_at = require("rt.host.ui_at").new(h)
  h.ui_timer = require("rt.host.ui_timer").new(h)
  h.ui_keys = require("rt.host.ui_keys").new(h)
  local probe = require("rt.host.b1_probe")
  if probe.enabled() then
    -- 探针包：只保留 overlay 的 ACTIVE 判定，不写任何文件。
    h.b1_probe = probe
    h.draw_dump = probe.overlay_dump()
  else
    local want_dump = os.getenv("KN_DRAW_DUMP") == "1"
    if not want_dump and love.filesystem and love.filesystem.getInfo then
      local ok, inf = pcall(function() return love.filesystem.getInfo("draw_dump.on") end)
      want_dump = ok and inf ~= nil
    end
    if want_dump then
      h.draw_dump = require("rt.host.draw_dump").new()
    end
  end
  return h
end

function H:_is_screen_target(want)
  if not want then return false end
  local g = self.game or require("rt.init").game
  return g and g.screens and g.screens[tostring(want)] ~= nil
end

function H:set_pointer(x, y, valid)
  if valid then
    self.mouse_x, self.mouse_y = x, y
    self.pointer_valid = true
  else
    self.pointer_valid = false
    self.mouse_x, self.mouse_y = 0 / 0, 0 / 0
  end
end

function H:clear_pointer()
  self:set_pointer(nil, nil, false)
end

function H:now_ms()
  return love.timer.getTime() * 1000
end

function H:set_assets(map)
  self.assets = map or {}
end

---------------------------------------------------------------------- 输入
function H:key_down(code)
  local key = tostring(code)
  local st = self.key_states and self.key_states[key]
  if st ~= nil then return st == "down" end
  local names = KEYMAP[key]
  if not names then return false end
  for _, name in ipairs(names) do
    if love.keyboard.isDown(name) == true then return true end
  end
  return false
end

function H:key_state(code)
  return self.key_states and self.key_states[tostring(code)] or nil
end

function H:on_key(key, down)
  if self.game and self.game.transition then return false end
  local code = LOVE_TO_CODE[key]
  if not code then return false end
  self.keys[code] = down and true or nil
  self.key_states[code] = down and "down" or "up"
  self.events[#self.events + 1] = {
    hat = "on_keydown",
    event = { type = down and "down" or "up", key = code },
    filter = function(s)
      return tostring(s.args.type or "down") == (down and "down" or "up")
        and tostring(s.args.key) == code
    end,
  }
  return true
end

function H:simulate_key_down(code)
  local names = KEYMAP[tostring(code)]
  if not names then return end
  self:on_key(names[1], true)
end

function H:simulate_key_up(code)
  local names = KEYMAP[tostring(code)]
  if not names then return end
  self:on_key(names[1], false)
end

function H:simulate_key(code)
  self:simulate_key_down(code)
  self:simulate_key_up(code)
end

function H:screen_inside(x, y)
  local w, h = love.graphics.getDimensions()
  return x >= 0 and y >= 0 and x <= w and y <= h
end

function H:stage_inside(x, y)
  local g = self.game
  if not g then return false end
  local wx, wy = self:screen_to_world(x, y, g)
  return wx >= -g.stage_w / 2 and wx <= g.stage_w / 2
     and wy >= -g.stage_h / 2 and wy <= g.stage_h / 2
end

function H:on_mouse(x, y)
  self:set_pointer(x, y, true)
  -- 官方 drag_move（crc_libs:1 1156673）：指针在 view 外时直接 return，
  -- 不更新 old_pos；回到 view 内后按 old_pos 的位移一次追上（保持手指偏移）。
  if self.drag_ent and self.mouse_is_down and self.drag_ent.draggable
     and not self.drag_ent.deleted then
    if not self:stage_inside(x, y) then return end
    local wx, wy = self:screen_to_world(x, y, self.game)
    local dx, dy = wx - (self.drag_old_x or wx), wy - (self.drag_old_y or wy)
    self.drag_ent.x = (self.drag_ent.x or 0) + dx
    self.drag_ent.y = (self.drag_ent.y or 0) + dy
    self.drag_old_x, self.drag_old_y = wx, wy
  end
end

function H:on_mouse_pressed(x, y, button)
  if not self.game then return end   -- 加载期（还没有 game）时点击直接忽略
  if self.game.transition then return end -- 切屏转场期间交互锁
  -- 官方 stage.hitArea（crc_libs:1 byte 1100503）：屏幕外按下不进入交互
  if not self:screen_inside(x, y) then return end
  self.mouse_is_down, self.mouse_clicked = true, true
  self.mouse_clicked_frame = self.game and self.game.frame or 0
  self:set_pointer(x, y, true)
  self.swipe_from = { x = x, y = y, t = love.timer.getTime() }
  -- 官方：点击在**抬起**时判定（actor:click 在 drag_end 里）；按下这里只记录状态与命中集合
  self.press_time = love.timer.getTime()
  local wx, wy = self:screen_to_world(x, y, self.game)
  local Hit = require("rt.hit")
  self.press_sprite = Hit.test(self.game, wx, wy)
  local hit_ids = {}
  for _, e in ipairs(Hit.hit_list_at(self.game, wx, wy)) do hit_ids[e.id] = true end
  self.press_hits = hit_ids
  -- 官方 StageEvent.onActorMouseDown：sprite_on_tap = mouse_down（持续按住时每帧重发）
  local taps = require("rt.host.taps")
  local ev = taps.press(self, self.game, hit_ids)
  ev.hit = self.press_sprite
  ev.sprite = self.press_sprite and self.press_sprite.id or nil
  self.events[#self.events + 1] = { hat = "sprite_on_tap", event = ev }
  self.events[#self.events + 1] = { hat = "sprite_on_click", event = ev }
  self.drag_ent = nil
  if self.press_sprite and self.press_sprite.draggable then
    self.drag_ent = self.press_sprite
    self.drag_dx = wx - (self.press_sprite.x or 0)
    self.drag_dy = wy - (self.press_sprite.y or 0)
    self.drag_old_x, self.drag_old_y = wx, wy
  end
end

function H:on_mouse_released(x, y, keep_pointer)
  if not self.game then return end
  if self.game.transition then return end
  self.mouse_is_down, self.mouse_up = false, true
  self.drag_ent = nil
  x, y = x or self.mouse_x or 0, y or self.mouse_y or 0
  self:set_pointer(x, y, true)
  local down_sprite = self.press_sprite
  self.press_sprite = nil
  local press = self.press_hits or {}
  self.press_hits = nil
  local dt_ms = (love.timer.getTime() - (self.press_time or 0)) * 1000

  -- ★ 官方 drag_end：按下→抬起 < 1000ms，且抬起时命中的对象与按下时**相同**才算点击
  --   （mouseupoutside / touchendoutside 不算 —— 官方显式排除）
  local wx, wy = self:screen_to_world(x, y, self.game)
  local Hit = require("rt.hit")
  local release_hits, release_ents = {}, {}
  for _, e in ipairs(Hit.hit_list_at(self.game, wx, wy)) do
    release_hits[e.id] = true
    release_ents[#release_ents + 1] = e
  end
  local taps = require("rt.host.taps")
  local can_click = dt_ms < 1000
  local up_ev, click_ev = taps.release(self, self.game, release_hits, can_click and press or {})
  self.click_hit = down_sprite
  self.click_hits = click_ev.hits

  up_ev.sprite = (release_ents[1] or down_sprite) and (release_ents[1] or down_sprite).id or nil
  up_ev.hit = release_ents[1] or down_sprite
  for _, hat in ipairs({ "sprite_on_tap", "sprite_on_click" }) do
    self.events[#self.events + 1] = { hat = hat, event = up_ev }
  end
  if can_click then
    click_ev.sprite = down_sprite and down_sprite.id or nil
    click_ev.hit = down_sprite
    for _, hat in ipairs({ "sprite_on_tap", "sprite_on_click" }) do
      self.events[#self.events + 1] = { hat = hat, event = click_ev }
    end
  end

  -- 滑动：按下到抬起位移超过阈值 → on_swipe（官方用 hammer 的 swipe 识别器）
  local from = self.swipe_from
  self.swipe_from = nil
  if not from then return end
  local dx, dy = x - from.x, y - from.y
  local dist = math.sqrt(dx * dx + dy * dy)
  local elapsed = math.max(1, (love.timer.getTime() - (from.t or 0)) * 1000)
  local velocity = dist / elapsed
  -- Hammer swipe 默认：distance > 10，overallVelocity > 0.3，单指，end 事件。
  if dist <= 10 or velocity <= 0.3 then return end
  local dir = (math.abs(dx) >= math.abs(dy))
    and (dx > 0 and "right" or "left")
    or (dy < 0 and "up" or "down")
  self.events[#self.events + 1] = {
    hat = "on_swipe",
    event = { type = "swipe", direction = dir, sprite = down_sprite and down_sprite.id or nil },
    filter = function(s)
      local want = s.args and (s.args.type or s.args.direction)
      return want == nil or tostring(want) == dir
    end,
  }
  if keep_pointer == false then self:clear_pointer() end
end

function H:on_touch_pressed(x, y, id)
  if not self.is_mobile then return end
  self.touch_id = id
  self:on_mouse_pressed(x, y, 1)
end

function H:on_touch_moved(x, y, id)
  if not self.is_mobile then return end
  if self.touch_id ~= nil and id ~= nil and id ~= self.touch_id then return end
  self:on_mouse(x, y)
end

function H:on_touch_released(x, y, id)
  if not self.is_mobile then return end
  if self.touch_id ~= nil and id ~= nil and id ~= self.touch_id then return end
  self:on_mouse_released(x, y, true)
  self:clear_pointer()
  self.touch_id = nil
end

-- 失去焦点/切换前后台：不派发点击，只清掉“按住”状态（H-2）
function H:cancel_pointer()
  self.mouse_is_down, self.mouse_up = false, false
  self.mouse_clicked = false
  self.drag_ent = nil
  self.press_sprite, self.press_hits, self._force_press = nil, nil, nil
  self.tap_action, self.click_targets = {}, nil
  self.global_tap, self.global_click = "", false
end

-- 释放所有按住的键（浏览器失焦不会补发 keyup，必须自己清，否则作品卡键）
function H:release_all_input()
  for code, st in pairs(self.key_states or {}) do
    if st == "down" then
      local names = KEYMAP[tostring(code)]
      self.keys[code] = nil
      self.key_states[code] = "up"
      self.events[#self.events + 1] = {
        hat = "on_keydown",
        event = { type = "up", key = tostring(code) },
        filter = function(s)
          return tostring(s.args.type) == "up" and tostring(s.args.key) == tostring(code)
        end,
      }
    end
  end
  self:cancel_pointer()
end

-- 命中测试：交给运行时（局部矩形 + 朝向 + centerPoint，取最上层）
-- 对应官方 PIXI hitTest/containsPoint 的语义
function H:hover_entity(sx, sy)
  local g = self.game
  if not g then return nil end
  local wx, wy = self:screen_to_world(sx, sy, g)
  return require("rt.hit").test(g, wx, wy, true)
end

function H:take_events()
  if #self.events == 0 then return nil end
  local e = self.events
  self.events = {}
  return e
end

function H:begin_frame(dt)
  -- 笔层画布"本帧是否已激活"的标记：每帧复位，保证每帧只切一次画布
  self._pen_active = false
  self._color_cache = {}
  self.mouse_clicked, self.mouse_up = false, false
  -- 上一帧的 effect 纹理归还池子（PERF-1），再建本帧的同帧共享缓存。
  self:_fx_release_caches()
  self._fx_pool = self._fx_pool or {}
end

function H:end_frame(dt)
  -- 帧末把笔层画布的 push 收回来（本帧笔迹批量只 push 一次）
  if self._pen_active then
    love.graphics.pop()
    self._pen_active = false
    self._pen_active_canvas = nil
  end end

-- 统一字体入口：随包字体（微软雅黑，含中文）→ 缺了才退回 LÖVE 默认字体
-- （默认字体不含 CJK，中文会画成方块）
-- 文字：LÖVE 的文字必须经过 Font 对象（不像 canvas 的 ctx.font 字符串）。
-- 官方做法是每次 fillText 现场栅格化；我们等价地只保留**一个基准字体**（128px），
-- 其它字号用**缩放绘制**。基准取大 → 绝大多数文字是"缩小"，清晰度反而更好。
H.FONT_BASE = 128
function H:make_font(size)
  if self._base_font then return self._base_font end
  local font
  if love.filesystem.getInfo("rt/fonts/font.ttf") then
    local ok, res = pcall(love.graphics.newFont, "rt/fonts/font.ttf", H.FONT_BASE)
    if ok then font = res end
  end
  if not font then
    local ok, res = pcall(love.graphics.newFont, H.FONT_BASE)
    font = ok and res or nil
  end
  if not font then
    local ok, res = pcall(love.graphics.newFont, 12)
    font = ok and res or love.graphics.getFont()
  end
  pcall(function() font:setFilter("linear", "linear") end)
  self._base_font = font
  return font
end

-- 按字号缩放绘制文字（size 为像素字号；恒用同一个基准字体）
function H:text(txt, x, y, size, align, color)
  local f = self:make_font()
  local k = math.max(0.05, math.min(16, (size or 12) / H.FONT_BASE))
  love.graphics.setFont(f)
  if color then love.graphics.setColor(color) end
  if align == "center" then x = x - f:getWidth(txt) * k / 2
  elseif align == "right" then x = x - f:getWidth(txt) * k end
  love.graphics.print(txt, x, y, 0, k, k)
end

function H:log(msg, level)
  local line = tostring(msg)
  self.logs[#self.logs + 1] = line
  if #self.logs > 200 then table.remove(self.logs, 1) end -- 屏幕叠加层只显示末尾若干行
  print("[" .. tostring(level or "info") .. "] " .. line)
end


---------------------------------------------------------------------- 资源（造型 / 声音）
function H:asset_path(g, file)
  return (g and g.assets_dir or "works") .. "/" .. file
end

-- 造型图片：按 styleId 懒加载并缓存（找不到就返回 nil，调用方退化成占位）
function H:style_image(g, style_id)
  if not style_id then return nil end
  self._images = self._images or {}
  local cached = self._images[style_id]
  if cached ~= nil then
    return cached or nil
  end
  local a = g.assets and g.assets[style_id]
  local img = nil
  if a == nil then
    self:log(("造型 %s 不在作品资源清单里"):format(tostring(style_id):sub(1, 8)), "warn")
  elseif not a.file then
    self:log(("造型 %s 没有材质文件"):format(tostring(style_id):sub(1, 8)), "warn")
  end
  if a and a.file then
    local path = self:asset_path(g, a.file)
    if not love.filesystem.getInfo(path) then
      -- 资源缺失：明确告警（而不是静默画占位圆）
      self:log(("缺造型文件: %s（造型 %s）"):format(path, tostring(style_id):sub(1, 8)), "warn")
    end
    if love.filesystem.getInfo(path) then
      local ok, res = pcall(love.graphics.newImage, path)
      if ok then
        img = res
        -- 平铺由着色器里的 fract() 自己实现，不依赖 GL_REPEAT（NPOT 纹理在 ES2 上不可靠）
        pcall(function() img:setWrap("clamp", "clamp") end)
      else
        -- 解码失败：常见于 SVG 造型（LÖVE 不支持矢量格式）。
        -- 构建期已用 rsvg-convert 生成同名 .png，这里回退尝试它。
        local alt = path:gsub("%.svg$", ".png")
        if alt ~= path and love.filesystem.getInfo(alt) then
          local ok2, res2 = pcall(love.graphics.newImage, alt)
          if ok2 then
            img = res2
            pcall(function() img:setWrap("clamp", "clamp") end)
            self:log(("SVG 造型回退到位图: %s"):format(alt))
          end
        end
        if not img then
          self:log(("造型解码失败: %s → %s"):format(path, tostring(res)), "warn")
        end
      end
    end
  end
  self._images[style_id] = img or false
  if img then self:log("载入造型 " .. tostring(style_id:sub(1, 8)) .. " ← " .. self:asset_path(g, a.file)) end
  return img
end

---------------------------------------------------------------------- 音频
-- 返回时长（毫秒），供「播放声音直到结束」用
function H:play_audio(audio_id, loop, volume)
  local g = self.game
  if not g then return 0 end
  local a = g.audios and g.audios[audio_id]
  if not a or not a.file then
    self:log(("[audio] 未找到声音 id=%s"):format(tostring(audio_id)), "warn")
    return 0
  end
  local path = self:asset_path(g, a.file)
  if not love.filesystem.getInfo(path) then
    self:log("找不到声音文件: " .. path, "warn")
    return 0
  end
  -- 官方语义：一个声音只有一个播放实例——重播就是**重启**，不是再叠一个。
  -- 之前每次 play_audio 都 newSource → 旧的不停 → 音乐叠着播（还会泄漏）。
  self._sources = self._sources or {}
  local src = self._sources[audio_id]
  if not src then
    -- 大文件用 stream：8MB 级 mp3 用 static 要整段解码进内存，手机上容易失败/OOM
    local size = 0
    pcall(function() local inf = love.filesystem.getInfo(path); size = inf and inf.size or 0 end)
    local mode = (size > 1024 * 1024) and "stream" or "static"
    -- 不再 pcall 包住：解码失败就应该当场炸出来（否则表现为"某个声音永远不响"）
    local res = love.audio.newSource(path, mode)
    if not res then
      self:log(("[audio] 解码失败(%s) %s"):format(mode, path), "error")
      return 0
    end
    src = res
    self._sources[audio_id] = src
  end
  -- 同上：播放失败直接暴露
  if loop then
    self._sources = self._sources or {}
    for id2, s2 in pairs(self._sources) do
      if id2 ~= audio_id and s2:isPlaying() and s2:isLooping() then s2:stop() end
    end
  end
  src:stop()
  src:setLooping(loop and true or false)
  src:setVolume(volume or 1)
  src:play()
  self:log(("[audio] 播放 %s vol=%s loop=%s dur=%.1fs"):format(
    tostring(a.file), tostring(volume), tostring(loop), (function() local ok2, d2 = pcall(function() return src:getDuration() end); return ok2 and (d2 or 0) or 0 end)()))
  local d = 0
  pcall(function() d = src:getDuration() end)
  return d * 1000
end

-- 「播放直到结束」轮询：官方等 PLAY_END/FAIL/TIMEOUT（循环音不会自己结束）
function H:audio_playing(audio_id)
  local src = self._sources and self._sources[audio_id]
  if not src then return false end
  local ok, v = pcall(function() return src:isPlaying() end)
  return ok and v == true
end

function H:stop_audio(audio_id)
  if audio_id == "all" then
    self._sources = self._sources or {}
    for _, s in pairs(self._sources) do pcall(function() s:stop() end) end
    return
  end
  local sources = self._sources
  if not sources then return end
  if audio_id ~= nil and sources[audio_id] then
    pcall(function() sources[audio_id]:stop() end)
    sources[audio_id] = nil
  else
    for k, s in pairs(sources) do
      pcall(function() s:stop() end)
      sources[k] = nil
    end
  end
end

---------------------------------------------------------------------- 绘制
-- 舞台坐标 → 渲染坐标：现在整个舞台先画进一张「舞台尺寸」的画布，
-- 所以画布内部一律是 1 舞台单位 = 1 像素（与窗口无关）。窗口适配只在最后 blit 时做。
local function fit(g)
  return 1, g.stage_w / 2, g.stage_h / 2
end

-- 画布 → 窗口的适配：contain(留黑边) / cover(裁切铺满) / stretch(拉伸)
local function window_fit(g)
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  local mode = (g.host and g.host.stage_fit) or "contain"
  local kx, ky = w / g.stage_w, h / g.stage_h
  if mode == "stretch" then return kx, ky, 0, 0 end
  local k = (mode == "cover") and math.max(kx, ky) or math.min(kx, ky)
  return k, k, (w - g.stage_w * k) / 2, (h - g.stage_h * k) / 2
end

-- 舞台坐标 → 屏幕坐标
-- 舞台画布内的坐标：舞台单位 → 画布像素（原点在画布左上、y 向下）。
-- 画布到窗口的 fit 只在最后"把画布画到窗口"那一步乘一次，画布内部一律用它。
local Coords = require("rt.host.coords")
function H:canvas_pos(g, x, y)
  return Coords.canvas_pos(g, x, y)
end

function H:world_to_screen(x, y, g)   -- 只用于"换算到窗口"（HUD/输入），画布内请用 canvas_pos
  local w, h = love.graphics.getDimensions()
  return Coords.world_to_screen(g, x, y, w, h)
end

function H:screen_to_world(sx, sy, g)
  g = g or self.game
  if not g then return sx or 0, sy or 0 end   -- 加载期还没有 game：按原样返回，绝不让后面崩
  local w, h = love.graphics.getDimensions()
  return Coords.screen_to_world(g, sx, sy, w, h)
end

-- 文字特效：替代角色造型绘制；保留位置/旋转/缩放/透明度。
function H:draw_text_effect(e, g)
  local t = e.text_effect
  if not t or not t.active or t.text == nil or t.text == "" then return end
  local f = self:make_font()
  local size = tonumber(t.size) or 36
  local k = math.max(0.05, size / H.FONT_BASE)
  local tw = f:getWidth(t.text) * k
  local th = f:getHeight() * k
  local cx, cy = self:canvas_pos(g, e.x, e.y)
  local ML = require("rt.impl.motion_looks")
  local dir, flip = ML.draw_rotation(e)
  local r, gg, bb = require("rt.values").rgb(t.color or "#000000")
  -- 文字特效是角色造型的替代，使用角色 HSL/特效链，而不是画笔 HSV。
  local eff = e.effects or {}
  local alpha = (e.alpha or 100) / 100
  alpha = alpha * (1 - math.min(1, math.max(0, (eff.opacity or 0) / 100)))
  local csh = self:color_shader(e)
  love.graphics.push("all")
  love.graphics.translate(cx, cy)
  love.graphics.rotate(-math.rad(dir or 0))
  love.graphics.scale(e.scale_x or 1, e.scale_y or 1)
  love.graphics.setColor(r, gg, bb, alpha)
  love.graphics.setFont(f)
  if csh then love.graphics.setShader(csh) end
  love.graphics.print(t.text, -tw / 2, -th / 2, 0, k, k)
  if csh then love.graphics.setShader() end
  love.graphics.pop()
end

-- 全局特效：舞台覆盖层（SVGA 不可直接播放时的 At/LÖVE 图形实现）
function H:draw_global_effect(g)
  local a = g and g._global_anim
  if not a then return end
  local p = math.max(0, math.min(1, (a.elapsed or 0) / math.max(1, a.duration or 1)))
  local name = tostring(a.name or "")
  local short = name:gsub("^animation_", "")
  local orient = (g.stage_w >= g.stage_h) and "hor" or "ver"
  local key = short .. "_" .. orient
  self._effect_seq = self._effect_seq or {}
  local seq = self._effect_seq[key]
  if not seq then
    seq = {}
    local dir = "rt/assets/effects/" .. key
    for i = 1, (a.frame_count or 100) do
      local path = ("%s/%03d.png"):format(dir, i)
      if not love.filesystem.getInfo(path) then break end
      local ok, img = pcall(love.graphics.newImage, path)
      if not ok or not img then break end
      seq[#seq + 1] = img
    end
    self._effect_seq[key] = seq
  end
  if #seq > 0 then
    local idx = math.max(1, math.min(#seq, math.floor(p * #seq) + 1))
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(seq[idx], 0, 0, 0, g.stage_w / seq[idx]:getWidth(), g.stage_h / seq[idx]:getHeight())
    return
  end
  -- 没有解码序列时的程序化兜底
  local alpha = math.sin(math.pi * p) * 0.7
  if short == "salvo" or short == "firework" then
    love.graphics.setColor(1, 0.8, 0.25, alpha)
    for i = 1, 12 do
      local ang = (i / 12) * math.pi * 2 + p * 2
      local rad = 30 + p * math.max(g.stage_w, g.stage_h) * 0.55
      love.graphics.circle("fill", g.stage_w / 2 + math.cos(ang) * rad,
        g.stage_h / 2 + math.sin(ang) * rad, 6 + 10 * (1 - p))
    end
  elseif short == "awkward" or short == "silent" then
    love.graphics.setColor(0.1, 0.1, 0.2, alpha * 0.5)
    love.graphics.rectangle("fill", 0, 0, g.stage_w, g.stage_h)
  end
  love.graphics.setColor(1, 1, 1, 1)
end

function H:play_effect_audio(name)
  if not name then return end
  local map = {
    animation_salvo = "animation-salvo.mp3",
    animation_firework = "animation-firework.mp3",
    animation_awkward = "animation-awkward.mp3",
    animation_silent = "animation-silent.mp3",
  }
  local file = map[name]; if not file then return end
  local path = "rt/assets/effects/" .. file
  if not love.filesystem.getInfo(path) then return end
  local ok, src = pcall(love.audio.newSource, path, "static")
  if ok and src then
    self._effect_sources = self._effect_sources or {}
    table.insert(self._effect_sources, src)
    if #self._effect_sources > 8 then table.remove(self._effect_sources, 1) end
    pcall(function() src:play() end)
  end
end

-- 保存不含角色的舞台背景，供 bump_into_color 采样（同帧缓存）。
function H:_capture_bg(g, cv)
  local w, h = g.stage_w, g.stage_h
  if not self._bg_canvas or self._bg_canvas:getWidth() ~= w or self._bg_canvas:getHeight() ~= h then
    self._bg_canvas = love.graphics.newCanvas(w, h)
    self._bg_canvas:setFilter("nearest", "nearest")
    self._bg_image = nil
  end
  love.graphics.push("all")
  love.graphics.setCanvas(self._bg_canvas)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(cv, 0, 0)
  love.graphics.setCanvas()
  love.graphics.pop()
  self._bg_image = nil
end

-- 按官方 check_bumped_color：隐藏当前角色，把背景+其它角色渲染到离屏纹理，
-- 再用当前角色纹理点采样该纹理。
function H:_color_canvas_for(g, skip)
  local W, H = g.stage_w, g.stage_h
  self._color_canvas = self._color_canvas or love.graphics.newCanvas(W, H)
  local cc = self._color_canvas
  love.graphics.push("all")
  love.graphics.setCanvas(cc)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setColor(1, 1, 1, 1)
  if self._bg_canvas then love.graphics.draw(self._bg_canvas, 0, 0) end
  -- 只绘制其它角色；当前角色不进入颜色采样纹理。
  for _, e in ipairs(g.entities or {}) do
    if e ~= skip and e.kind == "actor" and e.visible ~= false and not e.deleted then
      local sid = e.style_id and e:style_id() or nil
      local img = sid and self:style_image(g, sid) or nil
      if img then
        local iw, ih = img:getWidth(), img:getHeight()
        local x, y = W / 2 + (e.x or 0), H / 2 - (e.y or 0)
        local sx = e.scale_x or 1
        local sy = e.scale_y or 1
        if e.flip_x then sx = -sx end
        if e.flip_y then sy = -sy end
        local cp = (g.assets and g.assets[sid] and g.assets[sid].center) or e.center_point
        local ox, oy = iw / 2 + (cp and tonumber(cp.x) or 0), ih / 2 + (cp and tonumber(cp.y) or 0)
        love.graphics.setColor(1, 1, 1, (e.alpha or 100) / 100)
        love.graphics.draw(img, x, y, -math.rad(e.dir or 0), sx, sy, ox, oy)
      end
    end
  end
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setCanvas()
  love.graphics.pop()
  return cc:newImageData()
end

-- 颜色碰撞 A 方案：不渲染舞台，直接按图层纹理采样。
-- 背景按 background.glsl 的 tileTransform 反算；其它角色按纹理点 alpha 取色。
function H:_color_image_data(g, sid)
  if not sid then return nil end
  self._color_data = self._color_data or {}
  local d = self._color_data[sid]
  if d ~= nil then return d or nil end
  local path = self:style_file(g, sid)
  local ok, data = false, nil
  if path then ok, data = pcall(love.image.newImageData, path) end
  self._color_data[sid] = (ok and data) or false
  return (ok and data) or nil
end

local function frac(v) return v - math.floor(v) end

function H:_background_color_at(g, wx, wy)
  if self._bg_screen_frame ~= g.frame then
    self._bg_screen_frame = g.frame
    local screen
    for i = 1, #g.entities do
      local e = g.entities[i]
      if e.kind == "screen" and (not g.cur_screen or e.id == g.cur_screen) then screen = e; break end
    end
    local sid = screen and screen:style_id() or nil
    local data = sid and self:_color_image_data(g, sid) or nil
    if not screen or screen.visible == false or not data then
      self._bg_screen = false
    else
      local iw, ih = data:getWidth(), data:getHeight()
      local asset = g.assets and g.assets[sid]
      local cp = { x = 0, y = 0 }
      if asset and asset.center then cp.x = tonumber(asset.center.x) or 0; cp.y = tonumber(asset.center.y) or 0 end
      local sc = screen.scale_x or 1; if sc <= 0 then sc = 1 end
      local sx, sy
      if self._bg_last and self._bg_last.iw == iw and self._bg_last.ih == ih then
        sx, sy = self._bg_last.sx, self._bg_last.sy
      else
        local kx, ky = g.stage_w / iw, g.stage_h / ih
        local ad = asset and asset.adaption or nil
        local function is_none(v) return v == "NONE" or v == "none" or v == 0 or v == "0" end
        if is_none(ad) then sx, sy = 1, 1
        elseif ad == "CONTAIN" or ad == 1 or ad == "1" then sx, sy = math.min(kx, ky), math.min(kx, ky)
        elseif ad == "STRETCH" or ad == 2 or ad == "2" then sx, sy = kx, ky
        else sx, sy = math.max(kx, ky), math.max(kx, ky) end
      end
      self._bg_screen = { screen = screen, data = data, iw = iw, ih = ih,
        cp = cp, tsc_x = sc * sx, tsc_y = sc * sy }
    end
  end
  local B = self._bg_screen
  if not B then return 1, 1, 1, 1 end
  local screen, data, iw, ih, cp = B.screen, B.data, B.iw, B.ih, B.cp
  local tsc_x, tsc_y = B.tsc_x, B.tsc_y
  local sp_x, sp_y = g.stage_w / 2 + wx, g.stage_h / 2 - wy
  local qx = sp_x - g.stage_w / 2 + (screen.x or 0)
  local qy = sp_y - g.stage_h / 2 - (screen.y or 0)
  local ang = math.rad(screen.dir or 0)
  local c, sn = math.cos(ang), math.sin(ang)
  local px = (qx * c - qy * sn) / tsc_x
  local py = (qx * sn + qy * c) / tsc_y
  local u = frac((px + iw / 2 + cp.x) / iw)
  local v = frac((py + ih / 2 + cp.y) / ih)
  local tx = math.min(iw - 1, math.max(0, math.floor(u * iw)))
  local ty = math.min(ih - 1, math.max(0, math.floor(v * ih)))
  return data:getPixel(tx, ty)
end

-- 目标色 presence gate：某造型/背景的原始像素是否可能产生目标色。
function H:_image_has_color(g, sid, color, r, gg, b)
  if not sid then return false end
  local key = sid .. "|" .. color
  self._color_presence = self._color_presence or {}
  if self._color_presence[key] ~= nil then return self._color_presence[key] end
  local data = self:_color_image_data(g, sid)
  if not data then self._color_presence[key] = false; return false end
  local bytes = data:getString()
  local hit = false
  for i = 1, #bytes, 4 do
    local R, G, B = bytes:byte(i), bytes:byte(i+1), bytes:byte(i+2)
    if (R - R % 8) == (r - r % 8) and (G - G % 8) == (gg - gg % 8)
       and (B - B % 16) == (b - b % 16) then hit = true; break end
  end
  self._color_presence[key] = hit
  return hit
end

function H:_scene_has_color(g, color, r, gg, b, skip)
  -- 画笔是任意动态颜色，存在 ink 时不能做静态门禁。
  if self._pen_has_ink then return true end
  local screen
  for i = 1, #g.entities do
    local e = g.entities[i]
    if e.kind == "screen" and (not g.cur_screen or e.id == g.cur_screen) then screen = e; break end
  end
  if screen and screen.visible ~= false and self:_image_has_color(g, screen:style_id(), color, r, gg, b) then return true end
  for i = 1, #g.entities do
    local e = g.entities[i]
    if e ~= skip and e.kind == "actor" and e.visible ~= false and not e.deleted then
      local sid = e.style_id and e:style_id() or nil
      if sid and self:_image_has_color(g, sid, color, r, gg, b) then return true end
    end
  end
  return false
end

function H:_pen_color_at(g, wx, wy)
  if not self._pen_has_ink or not self._pen_canvas then return nil end
  if self._pen_color_frame ~= g.frame then
    self._pen_color_frame = g.frame
    local ok, data = pcall(function() return self._pen_canvas:newImageData() end)
    self._pen_color_data = ok and data or nil
  end
  local data = self._pen_color_data
  if not data then return nil end
  local px = math.floor(g.stage_w / 2 + wx)
  local py = math.floor(g.stage_h / 2 - wy)
  if px < 0 or py < 0 or px >= data:getWidth() or py >= data:getHeight() then return nil end
  local r, gg, b, a = data:getPixel(px, py)
  if not r or not a or a <= 0 then return nil end
  return r, gg, b, a
end

function H:_color_grid(g, list)
  if self._color_grid_frame == g.frame then return self._color_grid end
  local Hit = require("rt.hit")
  local cell = 64
  local grid = {}
  for i = 1, #list do
    local e = list[i]
    if e.kind == "actor" and e.visible ~= false and not e.deleted then
      local x1, y1, x2, y2 = Hit.aabb(e, g)
      if x1 then
        local gx1 = math.floor((x1 + g.stage_w/2) / cell)
        local gx2 = math.floor((x2 + g.stage_w/2) / cell)
        local gy1 = math.floor((g.stage_h/2 - y2) / cell)
        local gy2 = math.floor((g.stage_h/2 - y1) / cell)
        for gx = gx1, gx2 do
          for gy = gy1, gy2 do
            local k = gx .. ":" .. gy
            local arr = grid[k]
            if not arr then arr = {}; grid[k] = arr end
            arr[#arr+1] = { i = i, e = e }
          end
        end
      end
    end
  end
  self._color_grid = grid
  self._color_grid_frame = g.frame
  return grid
end

function H:_actor_color_at(other, g, wx, wy)
  local sid = other.style_id and other:style_id() or nil
  local data = self:_color_image_data(g, sid)
  if not data then return nil end
  local Hit = require("rt.hit")
  if not other.img_w then other.img_w = data:getWidth() end
  if not other.img_h then other.img_h = data:getHeight() end
  local tx, ty = Hit.coord_in_texture(other, wx, wy, g)
  if not tx or not ty or tx < 0 or ty < 0 or tx >= data:getWidth() or ty >= data:getHeight() then return nil end
  local r, gg, b, a = data:getPixel(tx, ty)
  if not r or not a or a <= 0 then return nil end
  return r, gg, b, a
end

function H:_visible_color_at(g, wx, wy, skip, list)
  -- 原方案 A：按 render_list 逆序（最上层优先）扫描角色纹理，再查背景。
  list = list or require("rt.scene").render_list(g)
  for i = #list, 1, -1 do
    local other = list[i]
    if other ~= skip and other.kind == "actor" and other.visible ~= false and not other.deleted then
      local r, gg, b, a = self:_actor_color_at(other, g, wx, wy)
      if r then return r, gg, b, a end
    end
  end
  return self:_background_color_at(g, wx, wy)
end

function H:color_touching(e, g, hex)
  if not e or e.deleted or e.visible == false then return false end
  local color = tostring(hex or ""):gsub("#", "")
  local r = tonumber(color:sub(1, 2), 16) or 0
  local gg = tonumber(color:sub(3, 4), 16) or 0
  local b = tonumber(color:sub(5, 6), 16) or 0
  local key = tostring(e.id) .. "|" .. color
  self._color_cache = self._color_cache or {}
  if self._color_cache[key] ~= nil then return self._color_cache[key] end
  local Hit = require("rt.hit")
  local pixels = Hit.style_pixels(e, g)
  if not pixels then self._color_cache[key] = false; return false end
  local sid = e.style_id and e:style_id() or nil
  local iw, ih = e.img_w or pixels.w, e.img_h or pixels.h
  local sx, sy = e.scale_x or 1, e.scale_y or 1
  if e.flip_x then sx = -sx end
  if e.flip_y then sy = -sy end
  local asset = g.assets and g.assets[sid]
  local cp = (asset and asset.center) or e.center_point
  local ox = iw / 2 + (cp and tonumber(cp.x) or 0)
  local oy = ih / 2 + (cp and tonumber(cp.y) or 0)
  local rad = math.rad(e.dir or 0)
  local co, si = math.cos(rad), math.sin(rad)
  local points = self._color_points and self._color_points[sid]
  if not points then
    points = {}
    local function a(x, y)
      if x < 0 or y < 0 or x >= pixels.w or y >= pixels.h then return 0 end
      return Hit.alpha_at(pixels, y * pixels.w + x + 1)
    end
    for y = 0, pixels.h - 1, 2 do
      for x = 0, pixels.w - 1, 2 do
        if a(x-1,y-1) > 0 and a(x,y-1) > 0 and a(x-1,y) > 0 and a(x,y) > 0 then
          points[#points+1] = { x, y }
        end
      end
    end
    for y = 0, pixels.h - 1, 5 do
      for x = 0, pixels.w - 1, 5 do
        if a(x,y) > 0 then points[#points+1] = { x, y } end
      end
    end
    self._color_points = self._color_points or {}
    self._color_points[sid] = points
  end

  local list = require("rt.scene").render_list(g)
  if self.color_debug then
    g.color_debug = { frame=g.frame, color="#"..color, bg=true, call=true, sample=0, touch=0, match=0 }
    g.test_values = { frame=g.frame, color="#"..color, bg=true, sample=0, touch=0, match=0 }
  end
  local tx1, ty1, tx2, ty2
  for i = 1, #points do
    local p = points[i]
    local lx = (p[1] + 0.5 - ox) * sx
    local ly = (oy - (p[2] + 0.5)) * sy
    local wx = e.x + lx * co - ly * si
    local wy = e.y + lx * si + ly * co
    if self.color_debug then
      g.color_debug.sample = g.color_debug.sample + 1; g.test_values.sample = g.test_values.sample + 1
      if not tx1 or wx < tx1 then tx1 = wx end
      if not ty1 or wy < ty1 then ty1 = wy end
      if not tx2 or wx > tx2 then tx2 = wx end
      if not ty2 or wy > ty2 then ty2 = wy end
      g.test_values.touch_bbox = string.format("%.1f,%.1f..%.1f,%.1f", tx1, ty1, tx2, ty2)
    end
    local cr, cg, cb = self:_visible_color_at(g, wx, wy, e, list)
    if self.color_debug then
      g.color_debug.touch = g.color_debug.touch + 1; g.test_values.touch = g.test_values.touch + 1
      if not g.test_values.first and cr then
        g.test_values.first = string.format("%.1f,%.1f=(%d,%d,%d)", wx, wy,
          math.floor(cr*255+0.5), math.floor(cg*255+0.5), math.floor(cb*255+0.5))
      end
    end
    if cr then
      local R, G, B = math.floor(cr*255+0.5), math.floor(cg*255+0.5), math.floor(cb*255+0.5)
      if (R - R % 8) == (r - r % 8) and (G - G % 8) == (gg - gg % 8)
         and (B - B % 16) == (b - b % 16) then
        if self.color_debug then g.color_debug.match = g.color_debug.match + 1; g.test_values.match = g.test_values.match + 1 end
        self._color_cache[key] = true
        return true
      end
    end
  end
  self._color_cache[key] = false
  return false
end

function H:draw_test_values(g)
  if not self.test_values or not g.test_values then return end
  local t = g.test_values
  local lines = {
    "TEST VALUES",
    "color="..tostring(t.color).." bg="..tostring(t.bg),
    "sample="..tostring(t.sample).." touch="..tostring(t.touch).." match="..tostring(t.match),
    "first="..tostring(t.first or "-"),
    "touchBBox="..tostring(t.touch_bbox or "-"),
  }
  for i, line in ipairs(lines) do self:text(line, 8, 8 + (i-1)*14, 12, nil, {0,0,0,1}) end
end

function H:_snapshot_stage(cv, g)
  if not cv then return end
  -- 转场期间必须保留切屏前的旧画面，不能被新画面覆盖。
  if g and g.transition then return end
  if not self._prev_stage or self._prev_stage:getWidth() ~= g.stage_w or self._prev_stage:getHeight() ~= g.stage_h then
    self._prev_stage = love.graphics.newCanvas(g.stage_w, g.stage_h)
  end
  love.graphics.push("all")
  love.graphics.setCanvas(self._prev_stage)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(cv, 0, 0)
  love.graphics.setCanvas()
  love.graphics.pop()
end

-- 官方 update_adaptive_scale（player.main.63b4a46c.js）：
--   CONTAIN = min(r,i)；COVER = max(r,i)；STRETCH = (r,i)；
--   NONE = 纹理两轴都小于 view 时 max(r,i)，否则 1:1。
-- 纯函数，headless 可单测（P1-5）。
function H.bg_scale(mode, iw, ih, sw, sh)
  if not iw or not ih or iw <= 0 or ih <= 0 then return 1, 1 end
  local r, i = sw / iw, sh / ih
  if mode == "CONTAIN" then
    local k = math.min(r, i)
    return k, k
  elseif mode == "STRETCH" then
    return r, i
  elseif mode == "NONE" then
    if iw < sw and ih < sh then
      local k = math.max(r, i)
      return k, k
    end
    return 1, 1
  end
  local k = math.max(r, i)
  return k, k
end

function H:draw(g, opts)
  opts = opts or {}
  local render_only, skip = opts.render_only, opts.skip
  -- 每帧绘制状态护栏：任何未复位的 scissor/画布/着色器都不会泄漏到下一帧
  -- （竖屏下舞台外"花屏"就是状态泄漏的典型表现）
  love.graphics.push("all")
  love.graphics.setScissor()
  self.game = g
  local dump = self.draw_dump
  if dump then dump:begin_frame(g) end
  -- 探针放到 begin_frame 之后，错误页里的 draw_dump.active 才是当前帧的真实状态。
  if self.b1_probe then self.b1_probe.maybe_throw(g, self) end

  -- ① 先把整个舞台画进「舞台尺寸」的画布（画布内 1 舞台单位 = 1 像素）
  local cv = opts.canvas or self:stage_canvas(g)
  love.graphics.setCanvas(cv)
  -- 官方舞台 renderer 的底色：backgroundColor:16777215（main.15ba0757.js:1 byte 5611571）。
  -- 背景 visible=false 时不绘制，露出的就是 #FFFFFF，而不是调试深灰。
  love.graphics.clear(1, 1, 1, 1)
  local s, cx, cy = fit(g)             -- 画布内：s = 1，中心 = 舞台中心
  local stage_x, stage_y = 0, 0        -- 画布本身就是舞台，不需要裁剪

  -- 背景层：把屏幕造型**密铺**在整个舞台上，并跟随屏幕自身的旋转/缩放/透明度
  -- （官方也是密铺：不是拉伸铺满，而是按造型原尺寸平铺）
  local screen = nil
  for i = 1, #g.entities do
    local e = g.entities[i]
    if e.kind == "screen" and (not g.cur_screen or e.id == g.cur_screen) then screen = e break end
  end
  if screen and screen.visible ~= false then
    local img = self:style_image(g, screen:style_id())
    if img then
      local asset = g.assets and g.assets[screen:style_id()]
      local iw, ih = img:getWidth(), img:getHeight()
      local sc = screen.scale_x or 1
      if sc <= 0 then sc = 1 end
      local shader = self:bg_shader()
      if shader then
        -- 图案变换（仿官方 tileTransform）：pivot = 纹理中心 + centerPoint
        local cp = { x = 0, y = 0 }
        if asset and asset.center then
          cp.x = tonumber(asset.center.x) or 0
          cp.y = tonumber(asset.center.y) or 0
        end
        -- 屏幕空间：舞台中心；y 方向与 KN 的 y-up 相反，故滚动/中心点取负号
        shader:send("tex_size", { iw, ih })
        -- 舞台空间（逻辑像素）；**刻意不用 screen_coords**，避免安卓高 DPI 下物理/逻辑像素不一致
        shader:send("u_size", { g.stage_w, g.stage_h })
        shader:send("u_center", { g.stage_w / 2, g.stage_h / 2 })
        shader:send("angle", math.rad(screen.dir or 0))
        -- 图案缩放口径：
        --   stage（默认）：1 纹理像素 = 1 舞台单位 —— 背景与舞台成 1:1，
        --     于是大图自然"顶格/超出"舞台、纹理中心正落在舞台中心；小图才会出现密铺。
        --     官方网页播放器的画布尺寸就等于舞台，所以它的 view 口径与此等价；
        --     而我们的窗口是可变的，若按屏幕像素算，窗口一大图案就比舞台小、露出密铺且对齐跑偏。
        --   canvas：1 纹理像素 = 1 屏幕像素（严格照官方 view 口径；仅当窗口=舞台时才等价）
        -- 图案缩放：官方 update_adaptive_scale 的四种 adaption 规则
        --   缺省(无 adaption) & NONE：纹理**两个方向都比舞台小** → 放大到铺满(max)，否则 1:1
        --   CONTAIN: min(比例) 整体可见 ／ COVER: max(比例) 铺满裁切 ／ STRETCH: 各向异性
        -- 另可用 config/参数 bg_fit = native|cover|contain|stretch 强制覆盖（便于排查）
        local kx, ky = g.stage_w / iw, g.stage_h / ih
        -- ★ 官方背景自适应（player bundle 逐字）：
        --   set_texture 时 adaption = (asset.adaption === NONE ? NONE : COVER)   ← 没写就是 COVER
        --   update_adaptive_scale: CONTAIN=min(r,i) / COVER=max(r,i) / STRETCH={r,i}；未自适应=1:1(密铺)
        local ad = asset and asset.adaption or nil
        local function is_none(v) return v == "NONE" or v == "none" or v == 0 or v == "0" end
        local mode
        if self.bg_fit then
          mode = ({ cover = "COVER", contain = "CONTAIN", stretch = "STRETCH", native = "NONE" })[self.bg_fit]
             or "COVER"
        elseif is_none(ad) then mode = "NONE"
        elseif ad == "CONTAIN" or ad == 1 or ad == "1" then mode = "CONTAIN"
        elseif ad == "STRETCH" or ad == 2 or ad == "2" then mode = "STRETCH"
        else mode = "COVER" end
        local sx, sy = H.bg_scale(mode, iw, ih, g.stage_w, g.stage_h)
        self._bg_last = { mode = mode, sx = sx, sy = sy, iw = iw, ih = ih,
                          stage_w = g.stage_w, stage_h = g.stage_h }
        local tsc_x, tsc_y = sc * sx, sc * sy
        shader:send("tscale", { tsc_x, tsc_y })
        shader:send("pivot", { iw / 2 + cp.x, ih / 2 + cp.y })
        shader:send("scroll", { -(screen.x or 0), (screen.y or 0) })
        love.graphics.setShader(shader)
        love.graphics.setColor(1, 1, 1, (screen.alpha or 100) / 100)
        -- 注意：必须绘制**图片**（着色器里的 tex 就是它）；画 rectangle 会拿到 1×1 白纹理。
        -- 几何尺寸只用来覆盖舞台，实际取样由着色器按屏幕坐标算。
        love.graphics.draw(img, stage_x, stage_y, 0, g.stage_w / iw, g.stage_h / ih)
        love.graphics.setShader()
        if dump then dump:mark_drawn(screen) end
      end
    end
  end

  -- 画笔层：背景之上、角色之下（与官方/Scratch 图层顺序一致）
  -- 官方把笔迹与图章/图片图章都画在"笔层"这张舞台大小的位图上；这里先按帧描线，
  -- 再把整张笔层画出来（旧的硬编码蓝色线段实现已删除）。
  self:pen_update(g)
  local pen_canvas = self:pen_layer(g)
  local sorted = require("rt.scene").render_list(g)
  local mode = self._pen_layer_mode
  local pen_pos = 0
  if mode == "peak" then
    pen_pos = #sorted
  elseif mode == "prev_layer" then
    pen_pos = math.min(#sorted, (self._pen_layer_index or 0) + 1)
  elseif mode == "next_layer" then
    pen_pos = math.max(0, (self._pen_layer_index or 0) - 1)
  end
  -- 指定目标角色：把笔层挂到该角色之上（prev/next 相对它）。
  if self._pen_layer_target and (mode == "prev_layer" or mode == "next_layer") then
    for i, e in ipairs(sorted) do
      if e.id == self._pen_layer_target or e.name == self._pen_layer_target then
        pen_pos = (mode == "next_layer") and math.max(0, i - 1) or math.min(#sorted, i)
        break
      end
    end
  end
  self._pen_layer_index = pen_pos
  local pen_key = tostring(g.cur_screen or "default")
  if self._pen_canvases and self._pen_canvases[pen_key] then self._pen_canvases[pen_key].index = pen_pos end
  local function draw_pen()
    if not pen_canvas then return end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(pen_canvas, 0, 0)
  end
  if pen_pos == 0 then draw_pen() end

  love.graphics.setScissor()
  -- 颜色碰撞采样底图：必须在不含角色的背景绘制完成后、角色循环开始前复制。
  -- PERF-2：只有用到「碰到颜色」的作品才付这次整屏拷贝；没有该积木的作品直接跳过。
  if g.uses_color_touch or self.color_debug then
    self:_capture_bg(g, cv)
  end

  -- 角色：只画"当前屏幕该画的"（由 rt/scene 统一裁决，宿主不再自己筛选/排序）
  -- ★ 视口裁剪：只光栅化舞台范围内的像素（PIXI 的 view 裁剪等价物）。
  --   角色可以拉到 9999%（几千像素），不裁剪会让 LÖVE 光栅化巨大四边形 → 卡/崩坏。
  love.graphics.setScissor(0, 0, g.stage_w, g.stage_h)
  for i = 1, #sorted do
    local e = sorted[i]
    if e.visible and not e.deleted and e.kind == "actor" and e ~= skip then
      local x, y = self:canvas_pos(g, e.x, e.y)
      -- 完全在舞台外的角色直接跳过（巨大角色仍会被裁剪绘制）
      local hw = (e.img_w or 0) * math.abs(e.scale_x or ((e.scale or 100) / 100)) / 2
      local hh = (e.img_h or 0) * math.abs(e.scale_y or ((e.scale or 100) / 100)) / 2
      local culled = e.img_w and e.img_h and
        (math.abs(e.x) - hw > g.stage_w / 2 or math.abs(e.y) - hh > g.stage_h / 2)
      local style_id = e:style_id()
      local img = self:style_image(g, style_id)
      local r = 30 * (e.scale_x or 1)
      if e.text_effect and e.text_effect.active and not culled then
        self:draw_text_effect(e, g)
      elseif img and not culled then
        local asset = g.assets and g.assets[style_id]
        local iw, ih = img:getWidth(), img:getHeight()
        local sc = math.min(9999, math.max(-9999, e.scale_x or 1))
        -- 官方缩放上限 9999；超过就不画（否则 LÖVE 光栅化巨大四边形会掉帧/崩）
        -- 每轴尺寸：宽高块给的是像素(舞台单位)；没设就用造型尺寸 × 统一缩放。
        -- LÖVE 的 draw 是 translate→rotate→scale，所以这里是**角色局部轴**拉伸 ✓
        -- 官方：角色缩放上限 9999%；宽高是独立两轴（scale_x / scale_y）
        local sxr = math.min(9999, math.max(-9999, (e.scale_x or sc) * 100)) / 100
        local syr = math.min(9999, math.max(-9999, (e.scale_y or sc) * 100)) / 100
        -- 几何截断：超过舞台 2 倍的绘制尺寸截到 2 倍（视觉等价，避免巨四边形）
        local capw = math.max(1, g.stage_w * 2)
        local caph = math.max(1, g.stage_h * 2)
        local dw = math.min(iw * math.abs(sxr), capw)
        local dh = math.min(ih * math.abs(syr), caph)
        -- ★ 画面裁切：角色远大于舞台时，只提交"纹理的可见子区域"（newQuad），
        --   而不是提交一个巨大四边形让 GPU 去裁。这是"只对 GPU 提交画面内渲染"的关键。
        local quad = nil
        if dw > g.stage_w * 1.5 or dh > g.stage_h * 1.5 then
          -- 角色四角 → 舞台坐标；取与舞台矩形的交集，再把交集四角转回"角色局部坐标"
          local halfw, halfh = (dw / s) / 2, (dh / s) / 2
          local rad = -math.rad(e.dir or 0)
          local cs, sn = math.cos(rad), math.sin(rad)
          local lx1, ly1, lx2, ly2 = math.huge, math.huge, -math.huge, -math.huge
          for _, p2 in ipairs({ { -g.stage_w / 2, -g.stage_h / 2 }, { g.stage_w / 2, -g.stage_h / 2 },
                                { g.stage_w / 2, g.stage_h / 2 }, { -g.stage_w / 2, g.stage_h / 2 } }) do
            local vx, vy = p2[1] - e.x, p2[2] - e.y
            local rx = vx * cs - vy * sn
            local ry = vx * sn + vy * cs
            lx1, ly1 = math.min(lx1, rx), math.min(ly1, ry)
            lx2, ly2 = math.max(lx2, rx), math.max(ly2, ry)
          end
          -- 裁到角色自身矩形内，再映射成纹理像素
          lx1, lx2 = math.max(lx1, -halfw), math.min(lx2, halfw)
          ly1, ly2 = math.max(ly1, -halfh), math.min(ly2, halfh)
          if lx2 > lx1 and ly2 > ly1 then
            local u1 = (lx1 + halfw) / (2 * halfw) * iw
            local u2 = (lx2 + halfw) / (2 * halfw) * iw
            local v1 = (-ly2 + halfh) / (2 * halfh) * ih
            local v2 = (-ly1 + halfh) / (2 * halfh) * ih
            local qw, qh = u2 - u1, v2 - v1
            if qw > 0.5 and qh > 0.5 then
              local okq, q = pcall(love.graphics.newQuad, u1, v1, qw, qh, iw, ih)
              if okq then
                quad = q
                img = img
                -- 用子区域中心作为绘制锚点
                e._qcx, e._qcy = (u1 + u2) / 2, (v1 + v2) / 2
                e._qw, e._qh = qw, qh
                dw, dh = qw * (dw / iw), qh * (dh / ih)
              end
            end
          end
        end
        local ox, oy = iw / 2, ih / 2
        if asset and asset.center then
          -- centerPoint 是相对图片中心的偏移（像素）
          ox = ox + (tonumber(asset.center.x) or 0)
          oy = oy + (tonumber(asset.center.y) or 0)
        end
        e.img_w, e.img_h = iw, ih            -- 供命中检测使用
        e.center_point = asset and asset.center or nil
        local ML = require("rt.impl.motion_looks")
        local draw_dir, flip_h = ML.draw_rotation(e)
        local alpha = (e.alpha or 100) / 100
        -- 透明特效：0..100，100 = 全透明（与"透明度"语义一致）
        alpha = alpha * (1 - math.min(1, math.max(0, (e.effects.opacity or 0) / 100)))
        local fx_canvas = nil
        local csh = self:color_shader(e)
        local fast_clone = e.is_clone and #g.entities > 50
        local fast_done = false
        if not quad and fast_clone then
          fast_done = self:draw_clone_effects(e, img, iw, ih, dw, dh, x, y,
            draw_dir, flip_h, ox, oy, alpha, csh, g.stage_w, g.stage_h)
        end
        if not fast_done and not quad then
          fx_canvas = self:sprite_effect_canvas(e, img, iw, ih, dw, dh, x, y, draw_dir, flip_h, ox, oy, g.stage_w, g.stage_h)
        end
        if fast_done then
          if dump then dump:before(e, i) end
          if dump then dump:after(e, i) end
        elseif fx_canvas then
          if csh then love.graphics.setShader(csh) end
          love.graphics.setColor(1, 1, 1, alpha)
          if dump then dump:before(e, i) end
          -- transform 已烘进 filterArea，最终只做屏幕位置合成，不能再旋转。
          love.graphics.draw(fx_canvas.canvas, x, y, 0, 1, 1,
            fx_canvas.w / 2, fx_canvas.h / 2)
          if dump then dump:after(e, i) end
          if csh then love.graphics.setShader() end
        else
          local shader = self:sprite_shader(e, x, y, dw, dh)
          if shader then love.graphics.setShader(shader) end
          love.graphics.setColor(1, 1, 1, alpha)
          if dump then dump:before(e, i) end
          if quad then
            local qw, qh = e._qw, e._qh
            love.graphics.draw(img, quad, x, y, -math.rad(draw_dir),
              (flip_h and -1 or 1) * dw / qw, dh / qh, e._qcx, e._qcy)
          else
            love.graphics.draw(img, x, y, -math.rad(draw_dir),
              (flip_h and -1 or 1) * dw / iw, dh / ih, ox, oy)
          end
          if dump then dump:after(e, i) end
          if shader then love.graphics.setShader() end
        end
      elseif _G._KN_MISSING_TEX_DEBUG then
        -- 纹理没加载上时的调试占位：**默认不画**（之前会把角色名直接印在画面上，
        -- 隐藏角色也会露出来）。排查缺图时把 _KN_MISSING_TEX_DEBUG 打开即可。
        if dump then dump:before(e, i) end
        love.graphics.setColor(0.4, 0.8, 1, (e.alpha or 100) / 100)
        love.graphics.circle("fill", x, y, r)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(tostring(e.name) .. (e.is_clone and ("#" .. tostring(e.clone_index)) or ""), x - r, y - r - 16)
        if dump then dump:after(e, i) end
      end
    end
    if i == pen_pos and pen_pos > 0 then draw_pen() end
  end

  self:draw_global_effect(g)
  if not render_only then self:draw_test_values(g) end
  if dump then dump:end_frame(g) end
  if render_only then
    love.graphics.pop()
    return cv
  end

  -- ② 把舞台画布整张适配到窗口（contain / cover / stretch）
  love.graphics.setCanvas()
  love.graphics.clear(0, 0, 0)
  local kx, ky, dx, dy = window_fit(g)
  love.graphics.setColor(1, 1, 1, 1)
  local tr = g.transition
  if tr and self._prev_stage then
    local t = math.max(0, math.min(1, (tr.elapsed or 0) / (tr.duration or 0.35)))
    local typ = tostring(tr.type or "fade_in_out")
    if typ == "slide" then
      local sw, sh = g.stage_w * kx, g.stage_h * ky
      local ax, ay, bx, by = dx, dy, dx, dy
      local d = tostring(tr.direction or "up")
      if d == "up" then ay = dy + t * sh; by = dy - (1-t) * sh
      elseif d == "down" then ay = dy - t * sh; by = dy + (1-t) * sh
      elseif d == "left" then ax = dx + t * sw; bx = dx - (1-t) * sw
      else ax = dx - t * sw; bx = dx + (1-t) * sw end
      love.graphics.setColor(1,1,1,1); love.graphics.draw(self._prev_stage, ax, ay, 0, kx, ky)
      love.graphics.draw(cv, bx, by, 0, kx, ky)
    elseif typ == "bounce" then
      local sw, sh = g.stage_w * kx, g.stage_h * ky
      local bounce = math.sin(t * math.pi) * (1 - t) * sh * 0.35
      love.graphics.setColor(1,1,1,1)
      love.graphics.draw(self._prev_stage, dx, dy + bounce, 0, kx, ky)
      love.graphics.draw(cv, dx, dy - bounce, 0, kx, ky)
    elseif typ == "distort" then
      local wobble = math.sin(t * math.pi * 6) * 8 * (1-t)
      love.graphics.draw(cv, dx + wobble, dy, 0, kx, ky)
      love.graphics.setColor(1,1,1,1-t)
      love.graphics.draw(self._prev_stage, dx - wobble, dy, 0, kx, ky)
    else
      love.graphics.draw(cv, dx, dy, 0, kx, ky)
      love.graphics.setColor(1,1,1,1-t)
      love.graphics.draw(self._prev_stage, dx, dy, 0, kx, ky)
    end
  else
    love.graphics.draw(cv, dx, dy, 0, kx, ky)
  end
  love.graphics.setColor(1, 1, 1, 1)
  self:_snapshot_stage(cv, g)

  -- 仅诊断包（b1_probe / draw_dump）显示；普通 paint 包不显示任何调试叠层。
  if self.b1_probe or dump then
    love.graphics.setColor(1, 1, 1, 1)
    self:text("BOOT OK", 8, 8, 14)
    if dump and dump:in_range(g.frame) then
      self:text(("DRAW_DUMP ACTIVE frame=%d entities=%d"):format(g.frame, #(g.entities or {})), 8, 30, 12)
    end
  end

  -- 与入口的 push("all") 配对：恢复画布/着色器/scissor/颜色等全部状态
  love.graphics.pop()
end

-- 造型像素尺寸（等价官方 texture.width/height）：优先已加载的图，其次读文件头
function H:style_size(id, g)
  self._sizes = self._sizes or {}
  if self._sizes[id] ~= nil then return self._sizes[id][1], self._sizes[id][2] end
  local img = self:style_image(g, id)
  local w, h
  if img then w, h = img:getWidth(), img:getHeight() end
  if not w then
    local path = self:style_file(g, id)
    if path then w, h = require("rt.asset").size(path) end
  end
  self._sizes[id] = { w, h }
  return w, h
end

-- 官方 set_points_data：把贴图取原分辨率像素，用其 **alpha 字节** 判断是否"实心"
-- 我们只需要 alpha 通道（官方存 RGBA，判定用 >>>24）；无图/解码失败返回 nil
-- 造型文件路径（与 style_image 同一套解析 + SVG→PNG 回退）
local STYLE_EXTS = { "", ".png", ".jpg", ".jpeg", ".gif", ".svg", ".webp", ".bin" }

function H:style_file(g, style_id)
  local a = g and g.assets and g.assets[style_id]
  -- 编译器给的 file 只决定目录；扩展名可能不一致（url 无扩展名/下载为 bin/svg）→ 逐个试
  local dir = (g and g.assets_dir or "works") .. "/assets"
  if a and a.file then
    local path = self:asset_path(g, a.file)
    if love.filesystem.getInfo(path) then return path end
    local alt = path:gsub("%.svg$", ".png")
    if alt ~= path and love.filesystem.getInfo(alt) then return alt end
  end
  for _, e in ipairs(STYLE_EXTS) do
    local p2 = dir .. "/" .. style_id .. e
    if love.filesystem.getInfo(p2) then return p2 end
  end
  return nil
end

function H:style_pixels(id, g)
  local path = self:style_file(g, id)
  if not path then return nil end
  local ok, data = pcall(love.image.newImageData, path)
  if not ok or not data then return nil end
  local w, h = data:getWidth(), data:getHeight()
  local rgba = data:getString()          -- love: rgba8 原始字节（每像素 4 字节）
  local n = w * h
  if #rgba < n * 4 then return nil end
  -- 不再重建 alpha 串：命中时直接按 (i-1)*4+4 取第 4 字节（Hit.alpha_at）
  return { w = w, h = h, rgba = rgba }
end

---------------------------------------------------------------------- 加载期
-- 分批预加载造型图片（每帧最多 ms 毫秒），返回 true 表示已全部就绪。
-- 官方也是"加载完再放行"，这样作品的脚本一开始就能拿到正确的造型尺寸/内容。
function H:preload(g, ms)
  self._preload_list = self._preload_list or (function()
    local ids = {}
    for id in pairs(g.assets or {}) do ids[#ids + 1] = id end
    table.sort(ids)
    return ids
  end)()
  local t0 = love.timer.getTime()
  for i = (self._preload_i or 1), #self._preload_list do
    self:style_image(g, self._preload_list[i])
    self._preload_i = i + 1
    if (love.timer.getTime() - t0) * 1000 > (ms or 6) then break end
  end
  self._preload_done = (self._preload_i or 1) > #self._preload_list
  return self._preload_done
end

function H:preload_progress(g)
  local n = #(self._preload_list or {})
  if n == 0 then return 1 end
  return math.min(1, ((self._preload_i or 1) - 1) / n)
end

-- 角落信息：FPS + 构建号（由 main.lua 在每帧绘制后调用）
H.hud = function(self, g) return self:_hud(g) end

function H:_hud(g)
  self._fps_n = (self._fps_n or 0) + 1
  local now = love.timer.getTime()
  if not self._fps_t or now - self._fps_t >= 0.5 then
    self._fps = self._fps_n / math.max(now - (self._fps_t or now), 1e-3)
    self._fps_t, self._fps_n = now, 0
  end
  local id = "?"
  local ok, b = pcall(function() return require("rt.init").build end)
  if ok and type(b) == "table" then id = b.id end
  local hs = math.max(11, math.floor(love.graphics.getHeight() / 60))
  local font = self:make_font()
  local hk = hs / H.FONT_BASE
  love.graphics.setFont(font)
  local txt = ("%d FPS   %s"):format(math.floor((self._fps or 0) + 0.5), id)
  love.graphics.setColor(0, 0, 0, 0.55)
  love.graphics.rectangle("fill", 6, 6, font:getWidth(txt) * hk + 12, font:getHeight() * hk + 6)
  love.graphics.setColor(1, 1, 0.85)
  love.graphics.print(txt, 12, 9, 0, hk, hk)
  love.graphics.setColor(1, 1, 1)
end

---------------------------------------------------------------------- 画笔层
-- 官方：画笔是一个"笔层"（舞台大小的位图），落笔后角色移动即在其上连线；
--       图章/图片图章把角色当前造型画到笔层；清空画笔清空整层。
--       默认层序在**背景之上、角色之下**（set_pen_layer 可改）。
function H:pen_layer(g)
  local key = tostring((g and g.cur_screen) or "default")
  self._pen_canvases = self._pen_canvases or {}
  local st = self._pen_canvases[key]
  if not st then
    local canvas = love.graphics.newCanvas(g.stage_w, g.stage_h)
    canvas:setFilter("linear", "linear")
    st = { canvas = canvas, has_ink = false, mode = "", target = nil, index = 0 }
    self._pen_canvases[key] = st
  end
  self._pen_canvas = st.canvas
  self._pen_has_ink = st.has_ink
  self._pen_layer_mode = st.mode or ""
  self._pen_layer_target = st.target
  self._pen_layer_index = st.index or 0
  return st.canvas
end

-- 笔层属于当前屏幕：clear 只清当前屏，不碰其它屏的笔迹。
function H:pen_clear(g)
  local canvas = self:pen_layer(g)
  local key = tostring((g and g.cur_screen) or "default")
  if canvas then
    love.graphics.push("all")
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.pop()
  end
  if self._pen_canvases and self._pen_canvases[key] then
    self._pen_canvases[key].has_ink = false
  end
  self._pen_has_ink = false
  local Scene = require("rt.scene")
  for _, e in ipairs((g and g.entities) or {}) do
    if e.pen and Scene.in_scene(e, g) then e.pen.last_x, e.pen.last_y = nil, nil end
  end
end

-- restart/重载：丢弃所有屏幕的笔层。
function H:pen_reset(g)
  self._pen_canvases = {}
  self._pen_canvas = nil
  self._pen_has_ink = false
  self._pen_layer_mode = ""
  self._pen_layer_target = nil
  self._pen_layer_index = 0
  for _, e in ipairs((g and g.entities) or {}) do
    if e.pen then e.pen.last_x, e.pen.last_y = nil, nil end
  end
end

local function parse_color(c)
  if type(c) == "table" then return (c.r or 255) / 255, (c.g or 0) / 255, (c.b or 0) / 255 end
  if type(c) == "string" then
    local hex = c:match("^#(%x%x%x%x%x%x)$")
    if hex then
      return tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255
    end
  end
  return 0, 0, 0
end

-- 笔层批量绘制：同一段代码（步骤内/绘制内）只 push+setCanvas 一次，帧末统一 pop（PERF-7）
function H:_pen_batch_begin(canvas, force_local)
  if force_local then
    love.graphics.push("all")
    love.graphics.setCanvas(canvas)
    love.graphics.origin()
    return "local"
  end
  if self._pen_active and self._pen_active_canvas ~= canvas then
    love.graphics.pop()
    self._pen_active = false
  end
  if not self._pen_active then
    love.graphics.push("all")
    love.graphics.setCanvas(canvas)
    love.graphics.origin()
    self._pen_active = true
    self._pen_active_canvas = canvas
  end
  return "batch"
end

function H:_pen_batch_end(mode)
  if mode == "local" then love.graphics.pop() end
end

-- 落笔当帧的圆点（官方 brush draw_line 先 canvas_draw_circle）。
-- 由 self_pen_down 在步骤中直接调用，不依赖角色移动。
function H:pen_dot(e, g)
  if not e or not e.pen then return end
  if not require("rt.scene").in_scene(e, g) then return end
  local canvas = self:pen_layer(g)
  if not canvas then return end
  local x, y = self:canvas_pos(g, e.x, e.y)
  local width = math.max(1, e.pen.size or 4)
  local r, gg, b = parse_color(e.pen.color)
  local alpha = math.min(1, math.max(0, e.pen.alpha or 1))
  self:_pen_batch_begin(canvas, false)
  love.graphics.setColor(r, gg, b, alpha)
  love.graphics.circle("fill", x, y, width / 2)
  self._pen_has_ink = true
  local key = tostring((g and g.cur_screen) or "default")
  if self._pen_canvases and self._pen_canvases[key] then self._pen_canvases[key].has_ink = true end
end

-- 把角色当前造型画到笔层（图片图章）
function H:pen_stamp(e, g)
  local canvas = self:pen_layer(g)
  local img = self:style_image(g, e:style_id())
  if not img or not canvas then return end

  -- 先算尺寸/参数（可能直接跳过），再动 graphics 状态 —— 避免 push/pop 不平衡
  local ML = require("rt.impl.motion_looks")
  local draw_dir, flip_h = ML.draw_rotation(e)
  local base = e.scale_x or 1
  local asx = math.abs(e.scale_x or base)
  local asy = math.abs(e.scale_y or base)
  -- ★ 官方口径：缩放值超过 9999 就不渲染这张图像印章（不是按像素算）
  if asx > 9999 or asy > 9999 or asx <= 0 or asy <= 0 then return end
  local dw = math.floor(img:getWidth() * asx)
  local dh = math.floor(img:getHeight() * asy)
  if flip_h then dw = -dw end
  if e.flip_x then dw = -dw end
  if e.flip_y then dh = -dh end
  local eff_op = (e.effects and e.effects.opacity) or 0
  local alpha = ((e.alpha or 100) / 100) * (1 - math.min(1, math.max(0, eff_op / 100)))
  local px, py = self:canvas_pos(g, e.x, e.y)   -- 笔层画布=舞台尺寸，用画布坐标

  -- 性能：同一帧内只切一次画布（每次 push+setCanvas+pop 都很贵，印章多时 60→3fps）
  self:_pen_batch_begin(canvas, false)
  self._pen_has_ink = true
  local key = tostring((g and g.cur_screen) or "default")
  if self._pen_canvases and self._pen_canvases[key] then self._pen_canvases[key].has_ink = true end
  love.graphics.setColor(1, 1, 1, alpha)
  -- 官方 imageStamp @1642815：draw_image_stamp(true) 用**处理后的完整外观**
  -- （颜色/亮度/黑白 + 像素化/波纹/扭曲），不是原始纹理。这里用角色效果着色器等价实现。
  local fx_sh = self:sprite_shader(e, px, py, math.abs(dw), math.abs(dh))
  if fx_sh then love.graphics.setShader(fx_sh) end
  love.graphics.draw(img, px, py, -math.rad(draw_dir),
    (dw < 0 and -1 or 1) * math.abs(dw) / img:getWidth(),
    (dh < 0 and -1 or 1) * math.abs(dh) / img:getHeight(),
    img:getWidth() / 2, img:getHeight() / 2)
  if fx_sh then love.graphics.setShader() end
end

-- 逐帧描线：落笔的角色移动时，在笔层上连一段线（官方行为）
function H:pen_tick(e, g, in_draw)
  if not e or not e.pen or not e.pen.down or e.deleted then return end
  if not require("rt.scene").in_scene(e, g) then return end
  local canvas = self:pen_layer(g)
  if not canvas then return end
  local last_x, last_y = e.pen.last_x, e.pen.last_y
  local x, y = e.x, e.y
  if not last_x or not last_y then
    e.pen.last_x, e.pen.last_y = x, y
    return
  end
  if last_x == x and last_y == y then return end
  local x1, y1 = self:canvas_pos(g, last_x, last_y)
  local x2, y2 = self:canvas_pos(g, x, y)
  local LIM = 1e6
  if math.abs(x1) < LIM and math.abs(y1) < LIM and math.abs(x2) < LIM and math.abs(y2) < LIM then
    local r, gg, b = parse_color(e.pen.color)
    local width = math.max(1, e.pen.size or 4)
    -- 绘制阶段（H:draw 内）不能把笔层画布留到舞台绘制之后，只用局部 push/pop
    local mode = self:_pen_batch_begin(canvas, in_draw == true)
    love.graphics.setColor(r, gg, b, math.min(1, math.max(0, e.pen.alpha or 1)))
    love.graphics.setLineWidth(width)
    love.graphics.setLineStyle("smooth")
    love.graphics.line(x1, y1, x2, y2)
    local rr = width / 2
    love.graphics.circle("fill", x1, y1, rr)
    love.graphics.circle("fill", x2, y2, rr)
    self:_pen_batch_end(mode)
    self._pen_has_ink = true
    local key = tostring((g and g.cur_screen) or "default")
    if self._pen_canvases and self._pen_canvases[key] then self._pen_canvases[key].has_ink = true end
  end
  e.pen.last_x, e.pen.last_y = x, y
end

-- 帧末兜底：处理没有经过 motion_looks 的坐标变化；即时 tick 已推进过 origin 的不重复画。
function H:pen_update(g)
  for _, e in ipairs(g.entities or {}) do self:pen_tick(e, g, true) end
end

function H:pen_layer_move(mode, target, g)
  g = g or self.game
  local key = tostring((g and g.cur_screen) or "default")
  self._pen_canvases = self._pen_canvases or {}
  local st = self._pen_canvases[key]
  local m = tostring(mode or "")
  local tg = (target ~= nil and tostring(target) ~= "") and tostring(target) or nil
  if st then st.mode, st.target = m, tg end
  self._pen_layer_mode = m
  self._pen_layer_target = tg
end

-- 官方 scene brush target：笔层挂在某个 actor 上。
function H:pen_brush_target()
  return self._pen_layer_target
end
function H:pen_brush_empty()
  return not self._pen_has_ink
end
function H:set_pen_brush_target(target)
  local id = target
  if type(target) == "table" then id = target.id or target.name end
  local g = self.game
  local key = tostring((g and g.cur_screen) or "default")
  self._pen_canvases = self._pen_canvases or {}
  local st = self._pen_canvases[key]
  self._pen_layer_target = (id ~= nil and tostring(id) ~= "") and tostring(id) or nil
  self._pen_layer_mode = self._pen_layer_target and "prev_layer" or ""
  if st then st.target, st.mode = self._pen_layer_target, self._pen_layer_mode end
end
function H:unset_pen_brush_target()
  local g = self.game
  local key = tostring((g and g.cur_screen) or "default")
  self._pen_canvases = self._pen_canvases or {}
  local st = self._pen_canvases[key]
  self._pen_layer_target = nil
  self._pen_layer_mode = ""
  if st then st.target, st.mode = nil, "" end
end

---------------------------------------------------------------------- 叠加层
-- 显示：构建号 / FPS / 实体·线程数 / **所有全局变量**（两列，超出一屏自动翻页）
function H:overlay(g)
  self._ov_t = self._ov_t or love.timer.getTime()
  self._ov_page = self._ov_page or 1
  self._ov_n = (self._ov_n or 0) + 1
  local now = love.timer.getTime()
  if now - self._ov_t >= 0.5 then
    self._fps = self._ov_n / math.max(now - self._ov_t, 1e-3)
    self._ov_t, self._ov_n = now, 0
  end
  if now - (self._ov_page_t or 0) >= 4 then -- 每 4 秒翻页（手机上无键盘也能看全）
    self._ov_page_t = now
    self._ov_page = self._ov_page + 1
  end

  local lines = {}
  local bh = "?"
  local ok, b = pcall(function() return require("rt.init").build end)
  if ok and type(b) == "table" then bh = b.id end
  lines[#lines + 1] = ("knplayer %s   %d FPS   实体 %d / 线程 %d"):format(bh,
    math.floor((self._fps or 0) + 0.5), #g.entities, #g.sched.threads)

  -- 全局变量（名字 = 值；列表显示项数）
  local rows = {}
  for k, v in pairs(g.vars) do
    local nm = g:describe(k)
    if nm and nm ~= "" then
      local txt
      if type(v) == "table" then
        local n = 0
        for _ in pairs(v) do n = n + 1 end
        txt = ("[列表 %d]"):format(n)
      else
        txt = tostring(v)
      end
      rows[#rows + 1] = nm .. " = " .. txt
    end
  end
  table.sort(rows)

  local ovsize = math.max(11, math.floor(love.graphics.getHeight() / 56))
  local font = self:make_font()
  local ovk = ovsize / H.FONT_BASE
  love.graphics.setFont(font)
  local lh = font:getHeight() * ovk
  local per_page = math.max(1, math.floor((love.graphics.getHeight() * 0.9 - lh * 2) / lh))
  local pages = math.max(1, math.ceil(#rows / per_page))
  local page = ((self._ov_page - 1) % pages) + 1
  local from = (page - 1) * per_page + 1
  for i = from, math.min(#rows, from + per_page - 1) do
    lines[#lines + 1] = rows[i]
  end
  -- 角色实时坐标（排查"图章落在 NaN 位置"这类问题用）
  local ents = {}
  for _, e in ipairs(g.entities) do
    if e.kind == "actor" then
      ents[#ents + 1] = ("%s(%s,%s) 可见=%s"):format(tostring(e.name):sub(1, 10),
        tostring(e.x):sub(1, 7), tostring(e.y):sub(1, 7), tostring(e.visible ~= false))
    end
  end
  table.sort(ents)
  for i = 1, math.min(#ents, 4) do rows[#rows + 1] = "实体: " .. ents[i] end

  lines[#lines + 1] = ("— %d/%d 页（全局变量 %d 个）—"):format(page, pages, #rows)

  local w = 0
  for _, l in ipairs(lines) do w = math.max(w, font:getWidth(l) * ovk) end
  local x, y = 8, 8
  love.graphics.setColor(0, 0, 0, 0.72)
  love.graphics.rectangle("fill", x, y, w + 16, #lines * lh + 10)
  love.graphics.setColor(0.6, 1, 0.7)
  love.graphics.rectangle("line", x, y, w + 16, #lines * lh + 10)
  for i, l in ipairs(lines) do
    local head = (i == 1)
    love.graphics.setColor(head and 1 or 0.92, head and 0.95 or 0.95, head and 0.6 or 0.95)
    love.graphics.print(l, x + 8, y + 5 + (i - 1) * lh, 0, ovk, ovk)
  end
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(self:make_font())
end

-- 舞台画布（尺寸 = 舞台；作品换舞台或首次绘制时创建）
function H:stage_canvas(g)
  if not self._stage_cv or self._stage_cv_w ~= g.stage_w or self._stage_cv_h ~= g.stage_h then
    self._stage_cv = love.graphics.newCanvas(g.stage_w, g.stage_h)
    self._stage_cv_w, self._stage_cv_h = g.stage_w, g.stage_h
    self:log(("舞台画布 %dx%d（背景/角色/印章都在舞台坐标里画，与窗口解耦）")
      :format(g.stage_w, g.stage_h))
  end
  return self._stage_cv
end

function H:draw_entity(e) end
-- 旧的硬编码画笔接口：已由笔层（pen_layer/pen_update）取代，保留为空实现避免旧调用点报错
function H:draw_line() end

---------------------------------------------------------------------- 文字印章（画笔文字）
-- 「设置文字印章」积木：M2 阶段先用 love.graphics.print 真画在舞台上
-- （真正的画笔层/覆盖层顺序在 M4 做；这里保证作品能"看见输出"）
function H:stamp_text(entity, text, args, g)
  args = args or {}
  if not entity then return end
  g = g or require("rt.init").game
  local canvas = self:pen_layer(g)
  if not canvas then return end
  local size = tonumber(args.size) or 24
  size = math.max(1, math.min(1000, size))
  local align = tostring(args.align or "left")
  local pen = entity.pen or {}
  local r, gg, b = parse_color(pen.color or "#000000")
  local alpha = math.min(1, math.max(0, pen.alpha or 1))
  local font = self:make_font()
  local k = size / H.FONT_BASE
  local w = font:getWidth(tostring(text or "")) * k
  local dx = 0
  if align == "center" then dx = -w / 2 elseif align == "right" then dx = -w end
  -- A 方案：官方 canvas textBaseline="middle" 以 em 中点为锚；LÖVE 的
  -- print y 是行框顶部，baseline=top+ascent。把 em 中点放到 actor 位置：
  -- y = size/2 - ascent。
  local ok_asc, ascent = pcall(function() return font:getAscent() end)
  if not ok_asc or not ascent then ascent = font:getHeight() / 2 end
  local ty = size / 2 - ascent * k
  local px, py = self:canvas_pos(g, entity.x or 0, entity.y or 0)
  love.graphics.push("all")
  love.graphics.setCanvas(canvas)
  love.graphics.origin()
  love.graphics.translate(px, py)
  love.graphics.rotate(-math.rad(entity.dir or 0))
  love.graphics.setFont(font)
  love.graphics.setColor(r, gg, b, alpha)
  love.graphics.print(tostring(text or ""), dx, ty, 0, k, k)
  love.graphics.pop()
end

-- 单个滤镜 shader 缓存（官方多 pass：Pixelate → Displacement → Twist）
function H:fx_shader(name)
  self._fx_shaders = self._fx_shaders or {}
  local sh = self._fx_shaders[name]
  if sh ~= nil then return sh or nil end
  local ok, v = pcall(love.graphics.newShader, "rt/host/" .. name .. ".glsl")
  if not ok then
    self:log("滤镜 shader 编译失败 " .. name .. ": " .. tostring(v), "warn")
    self._fx_shaders[name] = false
    return nil
  end
  self._fx_shaders[name] = v
  return v
end

function H:displacement_map()
  if self._displacement_map ~= nil then return self._displacement_map or nil end
  -- 官方 main.15ba0757.js 的 data:image/png 位移纹理（620x310），不是程序噪声。
  local ok, img = pcall(love.graphics.newImage, "rt/host/displacement.png")
  if ok and img then
    img:setWrap("repeat", "repeat")
    img:setFilter("linear", "linear")
    self._displacement_map = img
    return img
  end
  self:log("官方位移纹理载入失败：" .. tostring(img), "warn")
  self._displacement_map = false
  return nil
end

function H:color_shader(e)
  local fx = e.effects or {}
  local hue = fx.color or 0
  local bright = 0
  if (fx.brightness or 0) ~= 0 then bright = (fx.brightness / 100) - 1 end
  local sat = 1
  if (fx.grayscale or 0) ~= 0 then sat = math.max(0, 1 - fx.grayscale / 100) end
  if hue == 0 and bright == 0 and sat == 1 then return nil end
  local sh = self:fx_shader("color")
  if not sh then return nil end
  sh:send("e_hue", hue)
  sh:send("e_bright", bright)
  sh:send("e_sat", sat)
  return sh
end

-- 效果画布池：按尺寸复用 canvas，避免每帧 newCanvas/GC（PERF-1）
function H:_fx_get_canvas(w, h)
  self._fx_pool = self._fx_pool or {}
  local k = w .. "x" .. h
  local list = self._fx_pool[k]
  if not list then list = {}; self._fx_pool[k] = list end
  local c = table.remove(list)
  if not c then c = love.graphics.newCanvas(w, h) end
  c:setFilter("nearest", "nearest")
  return c
end

function H:_fx_put_canvas(c)
  if not c then return end
  self._fx_pool = self._fx_pool or {}
  local k = c:getWidth() .. "x" .. c:getHeight()
  local list = self._fx_pool[k]
  if not list then list = {}; self._fx_pool[k] = list end
  -- 每尺寸最多留 8 张，避免极端作品把显存当缓存
  if #list < 8 then list[#list + 1] = c end
end

-- 帧末/下一帧初：把上一帧的缓存纹理归还池子（同帧内仍被多个 clone 共享）
function H:_fx_release_caches()
  for _, v in pairs(self._fx_clone_cache or {}) do self:_fx_put_canvas(v.canvas) end
  for _, v in pairs(self._fx_frame_cache or {}) do self:_fx_put_canvas(v.canvas) end
  self._fx_clone_cache, self._fx_frame_cache = {}, {}
  self._fx_clone_cache_n = 0
end

-- 极端 clone 快速路径：每个 clone 一个 source + 一个 composite pass，
-- 但保留 Pixelate/Displacement/Twist 三个效果；用于大量 clone。
function H:draw_clone_effects(e, img, iw, ih, dw, dh, sx, sy, draw_dir, flip_h, ox, oy, alpha, csh, view_w, view_h)
  local fx = e.effects or {}
  local p, d, t = fx.pixelate or 0, fx.ripple or 0, fx.distortion or 0
  if p <= 1 and d <= 0 and t <= 0 then return false end
  local rad = -math.rad(draw_dir or 0)
  local cs, sn = math.abs(math.cos(rad)), math.abs(math.sin(rad))
  local hw = cs * dw / 2 + sn * dh / 2
  local hh = sn * dw / 2 + cs * dh / 2
  local pad = 20
  local bw = math.max(16, math.ceil((hw * 2 + pad * 2) / 16) * 16)
  local bh = math.max(16, math.ceil((hh * 2 + pad * 2) / 16) * 16)
  local key = table.concat({ tostring(e:style_id()), tostring(iw), tostring(ih),
    tostring(math.floor(dw)), tostring(math.floor(dh)), tostring(draw_dir or 0),
    tostring(flip_h and 1 or 0), tostring(p), tostring(d), tostring(t), tostring(bw), tostring(bh) }, "|")
  local cached = self._fx_clone_cache and self._fx_clone_cache[key]
  if cached then
    if csh then love.graphics.setShader(csh) end
    love.graphics.setColor(1, 1, 1, alpha or 1)
    love.graphics.draw(cached.canvas, sx, sy, 0, 1, 1, cached.w / 2, cached.h / 2)
    if csh then love.graphics.setShader() end
    return true
  end
  local src = self:_fx_get_canvas(bw, bh)
  local out = self:_fx_get_canvas(bw, bh)
  love.graphics.push("all")
  love.graphics.setBlendMode("alpha")
  love.graphics.setCanvas(src)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setShader()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(img, bw / 2, bh / 2, rad,
    (flip_h and -1 or 1) * dw / iw, dh / ih, ox or (iw / 2), oy or (ih / 2))
  love.graphics.setCanvas(out)
  love.graphics.clear(0, 0, 0, 0)
  local sh = self:fx_shader("composite")
  if sh then
    sh:send("mapSampler", self:displacement_map())
    sh:send("u_size", { bw, bh })
    sh:send("pixel_size", math.max(1, math.min(p, math.min(bw, bh))))
    sh:send("displ_scale", 20)
    local vw = math.max(1, view_w or 900)
    local vh = math.max(1, view_h or 562)
    sh:send("map_scale", { 1 / (2 * vw), 1 / (2 * vh) })
    sh:send("map_offset", { (love.timer.getTime() * d * 60) / (2 * vw), 0 })
    sh:send("twist_angle", math.rad(10 * t))
    sh:send("twist_radius", math.sqrt((dw / 2) ^ 2 + (dh / 2) ^ 2))
    love.graphics.setShader(sh)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(src, 0, 0)
    love.graphics.setShader()
  end
  love.graphics.setCanvas()
  love.graphics.pop()

  if csh then love.graphics.setShader(csh) end
  love.graphics.setColor(1, 1, 1, alpha or 1)
  love.graphics.draw(out, sx, sy, 0, 1, 1, bw / 2, bh / 2)
  if csh then love.graphics.setShader() end

  -- 同 key 的小容量缓存；直接把 out 交给缓存（不再拷贝一张），下一帧初归还池子。
  local owned = false
  if self._fx_clone_cache_n < 16 then
    self._fx_clone_cache[key] = { canvas = out, w = bw, h = bh }
    self._fx_clone_cache_n = self._fx_clone_cache_n + 1
    owned = true
  end
  self:_fx_put_canvas(src)
  if not owned then self:_fx_put_canvas(out) end
  return true
end

-- 官方滤镜链：Color → Pixelate → Displacement → Twist。
-- 关键：先把 actor 的旋转/缩放烘进 filterArea source texture，
-- 之后所有空间滤镜都在屏幕/filterArea 坐标完成，最终不再二次旋转。
function H:sprite_effect_canvas(e, img, iw, ih, dw, dh, sx, sy, draw_dir, flip_h, ox, oy, view_w, view_h)
  local fx = e.effects or {}
  local p = fx.pixelate or 0
  local d = fx.ripple or 0
  local t = fx.distortion or 0
  if p <= 1 and d <= 0 and t <= 0 then return nil end

  local rad = -math.rad(draw_dir or 0)
  local cs, sn = math.abs(math.cos(rad)), math.abs(math.sin(rad))
  local hw = cs * dw / 2 + sn * dh / 2
  local hh = sn * dw / 2 + cs * dh / 2
  -- 官方 TwistFilter 默认 padding=20；filterArea 必须包含这个边距。
  local pad = 20
  local w = math.max(1, math.ceil(hw * 2 + pad * 2))
  local h = math.max(1, math.ceil(hh * 2 + pad * 2))
  local cx, cy = sx, sy

  -- clone 批量：同帧同 style/effect/transform 共享空间滤镜纹理。
  -- 颜色矩阵在 draw 时单独做，因此 hue 不参与缓存 key。
  self._fx_frame_cache = self._fx_frame_cache or {}
  local fkey = table.concat({
    tostring(e:style_id()), tostring(iw), tostring(ih), tostring(math.floor(dw)),
    tostring(math.floor(dh)), tostring(draw_dir or 0), tostring(flip_h and 1 or 0),
    tostring(p), tostring(d), tostring(t)
  }, "|")
  local cached = self._fx_frame_cache[fkey]
  if cached then return cached end

  local prev_canvas = love.graphics.getCanvas()
  love.graphics.push("all")
  love.graphics.setBlendMode("alpha")
  love.graphics.setCanvas()
  local src = self:_fx_get_canvas(w, h)
  love.graphics.setCanvas(src)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setShader()
  love.graphics.setColor(1, 1, 1, 1)
  -- 先把 actor transform 画进 filterArea source。
  love.graphics.draw(img, w / 2, h / 2, rad,
    (flip_h and -1 or 1) * dw / iw, dh / ih, ox or (iw / 2), oy or (ih / 2))

  local cur = src
  local function pass(shader)
    local out = self:_fx_get_canvas(w, h)
    love.graphics.setCanvas(out)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setShader(shader)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(cur, 0, 0)
    love.graphics.setShader()
    -- 上一 pass 的纹理已经画完，立即归还池子（最终结果在 cache 里，帧末归还）
    self:_fx_put_canvas(cur)
    cur = out
  end

  if p > 1 then
    local sh = self:fx_shader("pixelate")
    if sh then
      sh:send("u_size", { w, h })
      sh:send("pixel_size", math.max(1, math.min(p, math.min(w, h))))
      pass(sh)
    end
  end
  if d > 0 then
    local sh = self:fx_shader("displacement")
    if sh then
      local map = self:displacement_map()
      if map then
        sh:send("mapSampler", map)
        sh:send("u_size", { w, h })
        sh:send("displ_scale", 20)
        -- 官方 displacement_sprite 尺寸 = 2*view；value 是每帧滚动 speed。
        local vw = math.max(1, view_w or 900)
        local vh = math.max(1, view_h or 562)
        local map_scale_x = 1 / (2 * vw)
        local map_scale_y = 1 / (2 * vh)
        local scroll_x = (love.timer.getTime() * d * 60) / (2 * vw)
        local scroll_y = 0
        -- 同帧 clone 共享空间纹理；map 原点用 canvas 本地坐标。
        local origin_x = 0
        local origin_y = 0
        sh:send("map_scale", { map_scale_x, map_scale_y })
        sh:send("map_offset", { origin_x + scroll_x, origin_y + scroll_y })
        pass(sh)
      end
    end
  end
  if t > 0 then
    local sh = self:fx_shader("twist")
    if sh then
      sh:send("u_size", { w, h })
      sh:send("twist_angle", math.rad(10 * t))
      -- 官方 set_twist: radius = target_sprite 半对角，不能用 padded filterArea。
      sh:send("twist_radius", math.sqrt((dw / 2) ^ 2 + (dh / 2) ^ 2))
      pass(sh)
    end
  end
  love.graphics.setCanvas(prev_canvas)
  love.graphics.pop()
  -- cache 只存局部纹理；不能缓存位置。
  local result = { canvas = cur, w = w, h = h }
  self._fx_frame_cache[fkey] = result
  return result
end

-- 角色特效着色器：按实体当前特效参数配置（没有特效时返回 nil，零开销）
function H:sprite_shader(e, x, y, w, h)
  local fx = e.effects or {}
  local hue = fx.color or 0
  local bright = 0
  if (fx.brightness or 0) ~= 0 then bright = (fx.brightness / 100) - 1 end -- 官方：clamp(-1,1, v/100-1)
  local sat = 1
  if (fx.grayscale or 0) ~= 0 then sat = math.max(0, 1 - fx.grayscale / 100) end -- 黑白：0..100 → 饱和度
  local pixel = fx.pixelate or 0
  local twist = fx.distortion or 0
  local ripple = fx.ripple or 0
  if hue == 0 and bright == 0 and sat == 1 and pixel <= 1 and twist == 0 and ripple == 0 then
    return nil
  end
  if self._sprite_shader == nil then
    local ok, sh = pcall(love.graphics.newShader, "rt/host/sprite.glsl")
    self._sprite_shader = ok and sh or false
    if not ok then self:log("角色特效着色器编译失败：" .. tostring(sh), "warn") end
  end
  local sh = self._sprite_shader
  if not sh then return nil end
  sh:send("e_hue", hue)
  sh:send("e_bright", bright)
  sh:send("e_sat", sat)
  sh:send("e_pixel", pixel)
  sh:send("e_twist", twist)
  sh:send("e_ripple", ripple)
  sh:send("e_time", love.timer.getTime())
  -- 只发 u_size：着色器里用 tc*u_size 还原绘制框内坐标（u_origin 已不再使用）
  sh:send("u_size", { math.max(w, 1), math.max(h, 1) })
  return sh
end

-- 背景图案着色器（一次编译，反复用）
function H:bg_shader()
  if self._bg_shader ~= nil then return self._bg_shader or nil end
  local path = "rt/host/background.glsl"
  if not love.filesystem.getInfo(path) then
    self._bg_shader = false
    return nil
  end
  local ok, sh = pcall(love.graphics.newShader, path)
  if not ok then
    self:log("背景着色器编译失败：" .. tostring(sh), "warn")
    self._bg_shader = false
    return nil
  end
  self._bg_shader = sh
  return sh
end

function H:fonts()
  self._fonts = self._fonts or {}
  return self._fonts
end

function H:draw_stamps(g, s)
  local list = self.stamps
  if not list then return end
  for i = 1, #list do
    local st = list[i]
    local x, y = self:canvas_pos(g, st.x, st.y)
    local px = st.size
    if px ~= px then px = 12 end      -- NaN → 回退默认字号
    local r, gg, b, a = require("rt.values").rgb(st.color)
    local f = self:make_font()
    local k = math.max(0.05, math.min(16, px / H.FONT_BASE))
    self:text(st.text, x, y + f:getHeight() * k / 2, px, st.align == "center" and "center" or nil, { r, gg, b, (st.alpha or 100) / 100 })
  end
  self.stamps = {}
  love.graphics.setColor(1, 1, 1)
end

return H
