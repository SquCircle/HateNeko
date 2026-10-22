-- 无图形宿主：虚拟时钟 + 事件队列 + 绘制 no-op
-- 用于 headless 单测 / 与官方 oracle 的逐帧状态比对
local H = {}
H.__index = H

function H.new(opts)
  opts = opts or {}
  local h = setmetatable({}, H)
  h.t = 0                  -- 虚拟时钟（毫秒）
  h.dt_ms = 0
  h.events = {}
  h.keys = {}
  h.key_states = {}       -- code -> "down" / "up"（官方 on_keydown 动作状态）
  h.mouse_x, h.mouse_y = 0, 0
  h.mouse_is_down = false
  local dev = opts.device or os.getenv("KN_DEVICE") or "pc"
  h.device_type = (dev == "mobile") and "mobile" or "pc"
  h.is_mobile = h.device_type == "mobile"
  h.pointer_valid = true
  h.logs = {}
  h.lines = {}
  h.audios = {}
  h.verbose = opts.verbose or false
  if os.getenv("KN_DRAW_DUMP") == "1" then
    h.draw_dump = require("rt.host.draw_dump").new()
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
  self:on_mouse_released(x, y)
  self:clear_pointer()
  self.touch_id = nil
end

function H:now_ms()
  return self.t
end

function H:begin_frame(dt)
  self.dt_ms = (dt or (1 / 60)) * 1000
  self.t = self.t + self.dt_ms
end

-- 无图形 host 的落笔圆点记录（供 headless 断言；不参与渲染）。
function H:pen_dot(e, g)
  self.pen_events = self.pen_events or {}
  self.pen_events[#self.pen_events + 1] = {
    kind = "dot", x = e.x, y = e.y,
    size = e.pen and e.pen.size, color = e.pen and e.pen.color,
    frame = g and g.frame,
  }
end

function H:pen_stamp(e, g)
  self.pen_stamps = self.pen_stamps or {}
  self.pen_stamps[#self.pen_stamps + 1] = {
    x = e and e.x, y = e and e.y, style = e and e:style_id(),
    size_x = e and e.scale_x, size_y = e and e.scale_y, frame = g and g.frame,
  }
end

function H:pen_layer_move(mode, target)
  self.pen_layer_events = self.pen_layer_events or {}
  self.pen_layer_events[#self.pen_layer_events + 1] = { mode = tostring(mode), target = tostring(target) }
end

function H:pen_clear(g)
  self.pen_clears = (self.pen_clears or 0) + 1
  self.pen_clear_screens = self.pen_clear_screens or {}
  self.pen_clear_screens[#self.pen_clear_screens + 1] = g and g.cur_screen
  local Scene = require("rt.scene")
  for _, e in ipairs((g and g.entities) or {}) do
    if e.pen and (not g or Scene.in_scene(e, g)) then e.pen.last_x, e.pen.last_y = nil, nil end
  end
end

function H:pen_reset(g)
  self.pen_resets = (self.pen_resets or 0) + 1
  for _, e in ipairs((g and g.entities) or {}) do
    if e.pen then e.pen.last_x, e.pen.last_y = nil, nil end
  end
end

function H:pen_tick(e, g)
  if not e or not e.pen or not e.pen.down then return end
  local last_x, last_y = e.pen.last_x, e.pen.last_y
  if last_x == nil or last_y == nil then
    e.pen.last_x, e.pen.last_y = e.x, e.y
    return
  end
  if last_x == e.x and last_y == e.y then return end
  self.pen_lines = self.pen_lines or {}
  self.pen_lines[#self.pen_lines + 1] = {
    kind = "line", owner = e.name, screen = g and g.cur_screen,
    x1 = last_x, y1 = last_y, x2 = e.x, y2 = e.y,
    size = e.pen.size, color = e.pen.color, frame = g and g.frame,
  }
  e.pen.last_x, e.pen.last_y = e.x, e.y
end

function H:end_frame(dt)
  local d = self.draw_dump
  if not d then return end
  local g = require("rt.init").game
  if not g then return end
  if d:begin_frame(g) then d:end_frame(g) end
end

-- 键名 <-> JS keyCode（与 love 宿主共用 rt/host/keymap.lua；H-3）
local Keymap = require("rt.host.keymap")

function H:key_state(k)
  return self.key_states and self.key_states[tostring(k)] or nil
end

function H:key_down(k)
  local code = tostring(k)
  local st = self.key_states and self.key_states[code]
  if st ~= nil then return st == "down" end
  return self.keys[code] == true or self.keys[k] == true
end

-- down=true/false；key 可以是 LÖVE 键名（"w"）或 JS keyCode（87 / "87"）
function H:on_key(key, down)
  if not (self.game or require("rt.init").game) then return end
  local game = self.game or require("rt.init").game
  if game.transition then return end
  local code
  if type(key) == "number" then
    code = tostring(key)
  elseif tostring(key):match("^%d+$") then
    code = tostring(key)
  else
    code = Keymap.name_to_code[tostring(key):lower()]
  end
  if not code then return end
  self.keys = self.keys or {}
  self.key_states = self.key_states or {}
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
end

function H:press_key(k) self:on_key(k, true) end
function H:release_key(k) self:on_key(k, false) end
function H:simulate_key_down(code) self:on_key(tostring(code), true) end
function H:simulate_key_up(code) self:on_key(tostring(code), false) end
function H:simulate_key(code)
  self:simulate_key_down(code); self:simulate_key_up(code)
end

-- 官方 drag_end：按下→抬起 < 1000ms 且目标相同 → 派发点击（扇出到所有点击类 hat）
function H:on_mouse_released(x, y)
  if not (self.game or require("rt.init").game) then return end -- 加载期忽略输入
  local game0 = self.game or require("rt.init").game
  if game0.transition then return end
  self.mouse_is_down, self.mouse_up = false, true
  self.drag_ent = nil
  local game = self.game or require("rt.init").game
  x, y = x or self.mouse_x or 0, y or self.mouse_y or 0
  self:set_pointer(x, y, true)
  local down = self._force_press or self.press_sprite
  local forced = self._force_press ~= nil
  local press = self.press_hits or {}
  self._force_press, self.press_sprite, self.press_hits = nil, nil, nil
  local wx, wy = game:screen_to_world(x, y)
  local Hit = require("rt.hit")
  local release_hits, release_ents = {}, {}
  if forced then
    if down then release_hits[down.id] = true; release_ents[#release_ents + 1] = down end
  else
    for _, e in ipairs(Hit.hit_list_at(game, wx, wy)) do
      release_hits[e.id] = true
      release_ents[#release_ents + 1] = e
    end
  end
  local press_ids = press
  if forced and down then press_ids = { [down.id] = true } end
  local taps = require("rt.host.taps")
  local up_ev, click_ev = taps.release(self, game, release_hits, press_ids)
  self.click_hit = down
  self.click_hits = click_ev.hits
  up_ev.sprite = (release_ents[1] or down) and (release_ents[1] or down).id or nil
  up_ev.hit = release_ents[1] or down
  click_ev.sprite = down and down.id or nil
  click_ev.hit = down
  for _, hat in ipairs({ "sprite_on_tap", "sprite_on_click" }) do
    self.events[#self.events + 1] = { hat = hat, event = up_ev }
    self.events[#self.events + 1] = { hat = hat, event = click_ev }
  end
end


function H:click(x, y, sprite_id)
  if not (self.game or require("rt.init").game) then return end -- 加载期忽略输入
  -- 走与 love 宿主**完全相同**的官方流程：按下记目标 → 抬起判定
  -- 显式给 sprite_id 时按"点到该角色"模拟；不给则按屏幕坐标做真实命中检测。
  x, y = x or 0, y or 0
  local game = self.game or require("rt.init").game
  if not self:screen_inside(x, y) then return end
  self:set_pointer(x, y, true)
  self.mouse_is_down = true
  self.press_time = 0
  local Hit = require("rt.hit")
  local wx, wy = game:screen_to_world(x, y)
  if sprite_id ~= nil and sprite_id ~= false then
    self._force_press = game:find(sprite_id)
  else
    self._force_press = nil
    self.press_hits = {}
    for _, e in ipairs(Hit.hit_list_at(game, wx, wy)) do self.press_hits[e.id] = true end
  end
  return self:on_mouse_released(x, y)
end

function H:cancel_pointer()
  self.mouse_is_down, self.mouse_up = false, false
  self.mouse_clicked = false
  self.drag_ent = nil
  self.press_sprite, self.press_hits, self._force_press = nil, nil, nil
  self.tap_action, self.click_targets = {}, nil
  self.global_tap, self.global_click = "", false
end

function H:release_all_input()
  for code, st in pairs(self.key_states or {}) do
    if st == "down" then
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

function H:screen_inside(x, y)
  local g = self.game or require("rt.init").game
  if not g then return false end
  return x >= 0 and y >= 0 and x <= g.stage_w and y <= g.stage_h
end

function H:stage_inside(x, y)
  local game = self.game or require("rt.init").game
  if not game then return false end
  local wx, wy = game:screen_to_world(x, y)
  return wx >= -game.stage_w / 2 and wx <= game.stage_w / 2
     and wy >= -game.stage_h / 2 and wy <= game.stage_h / 2
end

function H:on_mouse(x, y)
  self:set_pointer(x, y, true)
  if self.drag_ent and self.mouse_is_down and self.drag_ent.draggable then
    if not self:stage_inside(x, y) then return end
    local game = self.game or require("rt.init").game
    local wx, wy = game:screen_to_world(x, y)
    local dx, dy = wx - (self.drag_old_x or wx), wy - (self.drag_old_y or wy)
    self.drag_ent.x = (self.drag_ent.x or 0) + dx
    self.drag_ent.y = (self.drag_ent.y or 0) + dy
    self.drag_old_x, self.drag_old_y = wx, wy
  end
end

function H:on_mouse_pressed(x, y, button)
  if not (self.game or require("rt.init").game) then return end
  local game0 = self.game or require("rt.init").game
  if game0.transition then return end
  if not self:screen_inside(x, y) then return end
  self:set_pointer(x, y, true)
  self.mouse_is_down, self.mouse_up = true, false
  local game = self.game or require("rt.init").game
  local wx, wy = game:screen_to_world(x, y)
  local Hit = require("rt.hit")
  self.press_sprite = Hit.test(game, wx, wy)
  self.press_hits = {}
  for _, e in ipairs(Hit.hit_list_at(game, wx, wy)) do self.press_hits[e.id] = true end
  local taps = require("rt.host.taps")
  local ev = taps.press(self, game, self.press_hits)
  ev.hit = self.press_sprite
  ev.sprite = self.press_sprite and self.press_sprite.id or nil
  for _, hat in ipairs({ "sprite_on_tap", "sprite_on_click" }) do
    self.events[#self.events + 1] = { hat = hat, event = ev }
  end
  self.drag_ent = nil
  if self.press_sprite and self.press_sprite.draggable then
    self.drag_ent = self.press_sprite
    self.drag_dx = wx - (self.press_sprite.x or 0)
    self.drag_dy = wy - (self.press_sprite.y or 0)
    self.drag_old_x, self.drag_old_y = wx, wy
  end
end


-- 滑动输入（供测试/无头）
function H:swipe(direction, sprite_id)
  if not (self.game or require("rt.init").game) then return end -- 加载期忽略输入
  local dx, dy = 0, 0
  if direction == "left" then dx = -1 elseif direction == "right" then dx = 1
  elseif direction == "up" then dy = 1 elseif direction == "down" then dy = -1 end
  self:click(self.mouse_x or 0, self.mouse_y or 0, sprite_id)
  self.events[#self.events + 1] = {
    hat = "on_swipe",
    event = { type = "swipe", direction = tostring(direction), sprite = sprite_id },
    filter = function(s)
      local want = s.args and (s.args.type or s.args.direction)
      return want == nil or tostring(want) == tostring(direction)
    end,
  }
end

function H:take_events()
  if #self.events == 0 then return nil end
  local e = self.events
  self.events = {}
  return e
end

function H:log(msg, level)
  self.logs[#self.logs + 1] = tostring(msg)
  if self.verbose then print("[" .. tostring(level or "info") .. "] " .. tostring(msg)) end
end

function H:draw_entity(e) end
function H:draw_line(x1, y1, x2, y2, color, size)
  self.lines[#self.lines + 1] = { x1, y1, x2, y2, color, size }
end

-- 文字印章：无头宿主把它**结构化记下来**（便于断言作品到底输出了什么）
function H:stamp_text(entity, text, args, g)
  self.stamps = self.stamps or {}
  self.stamps[#self.stamps + 1] = {
    text = tostring(text or ""),
    x = entity and entity.x or 0,
    y = entity and entity.y or 0,
    size = args and tonumber(args.size) or nil,
    align = args and tostring(args.align or "left") or "left",
    color = entity and entity.pen and entity.pen.color or nil,
    alpha = entity and entity.pen and entity.pen.alpha or 1,
    dir = entity and entity.dir or 0,
    frame = g and g.frame or nil,
  }
end
-- 返回时长（毫秒）：无头环境给个固定值，让"播放直到结束"能推进
function H:play_audio(id, loop, volume)
  self.audios[#self.audios + 1] = { id = id, loop = loop, volume = volume, t = self.t }
  local ms = loop and 0 or 100
  self._audio = self._audio or {}
  self._audio[id] = { until_t = self.t + ms, loop = loop and true or false }
  return ms
end

function H:audio_playing(id)
  local a = self._audio and self._audio[id]
  if not a then return false end
  if a.loop then return true end
  return self.t < a.until_t
end

function H:stop_audio(id)
  self._audio = self._audio or {}
  if id == "all" then
    self._audio = {}
  elseif id ~= nil then
    self._audio[id] = nil
  end
end
function H:image() return nil end      -- 无头环境不加载图片
function H:load_done() end
-- 无头环境没有图片要加载：preload 直接返回"已完成"
function H:preload() return true end

function H:asset_path(g, file)
  return (g and g.assets_dir or "works") .. "/" .. file
end

-- 造型像素尺寸（等价官方 texture.width/height）：无头没有解码器 → 读图片文件头
function H:style_size(id, g)
  local a = g and g.assets and g.assets[id]
  if not a or not a.file then return nil end
  local path = self:asset_path(g, a.file)
  local w, h = require("rt.asset").size(path)
  if not w then w, h = require("rt.asset").size((path:gsub("%.svg$", ".png"))) end
  return w, h
end

return H
