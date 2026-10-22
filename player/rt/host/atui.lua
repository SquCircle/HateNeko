-- AtLua 驱动的非舞台 UI：HUD / 调试面板 / 日志控制台。
-- 只画在窗口坐标，舞台仍由 rt.host.love 画；不碰作品角色。
local M = {
  available = false,
  page = 1,
  pages = 5,
  visible = false,
  capture = false,
  console_visible = false,
}

local function cut(s, n)
  s = tostring(s or "")
  if #s <= n then return s end
  return s:sub(1, n) .. "…"
end

local function finite_num(v)
  if type(v) ~= "number" then return tostring(v) end
  if v ~= v then return "NaN" end
  return string.format("%.1f", v)
end

local function live_threads(game)
  local live, total = 0, 0
  for _, t in ipairs((game and game.sched and game.sched.threads) or {}) do
    total = total + 1
    if not t.done then live = live + 1 end
  end
  return live, total
end

local function missing_text()
  local miss = {}
  local ok, st = pcall(function() return require("rt.init").stats end)
  for k, v in pairs((ok and st and st.missing) or {}) do miss[#miss + 1] = k .. "×" .. tostring(v) end
  return #miss > 0 and table.concat(miss, " ") or "无"
end

-- 纯函数：headless 可直接断言页面内容。
function M.page_text(game, page, opts)
  opts = opts or {}
  if not game then return "(no game)" end
  page = page or 1
  local out = {}
  local live, total = live_threads(game)
  if page == 1 then
    out[#out + 1] = ("build %s  %s FPS  frame %d"):format(tostring(opts.build or "?"), tostring(opts.fps or "?"), game.frame or 0)
    out[#out + 1] = ("screen %s"):format(cut(game.cur_screen, 40))
    out[#out + 1] = ("entities %d   threads %d/%d"):format(#(game.entities or {}), live, total)
    out[#out + 1] = ("step %sms   draw %sms"):format(finite_num(opts.step_ms or 0), finite_num(opts.draw_ms or 0))
    out[#out + 1] = ("avg step %sms  max %sms"):format(finite_num(opts.avg_step or 0), finite_num(opts.max_step or 0))
    out[#out + 1] = ("avg draw %sms  max %sms"):format(finite_num(opts.avg_draw or 0), finite_num(opts.max_draw or 0))
    out[#out + 1] = ("stage %dx%d   missing: %s"):format(game.stage_w or 0, game.stage_h or 0, missing_text())
    local hh = game.host
    out[#out + 1] = ("device %s   pointer_valid=%s down=%s"):format(
      tostring(hh and hh.device_type or "?"), tostring(hh and hh.pointer_valid), tostring(hh and hh.mouse_is_down))
  elseif page == 2 then
    out[#out + 1] = "actors (visible first 12)"
    local n = 0
    for _, e in ipairs(game.entities or {}) do
      if e.kind == "actor" and not e.deleted and e.visible ~= false then
        n = n + 1
        out[#out + 1] = ("%s  (%s,%s)  order=%s seq=%s"):format(
          cut(e.name, 14), finite_num(e.x), finite_num(e.y), tostring(e.order), tostring(e.seq))
        if n >= 12 then break end
      end
    end
    if n == 0 then out[#out + 1] = "(none)" end
  elseif page == 3 then
    out[#out + 1] = ("threads %d/%d"):format(live, total)
    local byhat = {}
    for _, t in ipairs((game.sched and game.sched.threads) or {}) do
      if not t.done then byhat[t.hat or "?"] = (byhat[t.hat or "?"] or 0) + 1 end
    end
    local keys = {}
    for k in pairs(byhat) do keys[#keys + 1] = k end
    table.sort(keys)
    for i = 1, math.min(12, #keys) do
      out[#out + 1] = ("%s × %d"):format(keys[i], byhat[keys[i]])
    end
  elseif page == 4 then
    out[#out + 1] = "global variables / lists"
    local rows, seen = {}, {}
    for id, m in pairs(game.var_meta or {}) do
      if m.is_global then
        rows[#rows + 1] = { id = id, name = m.name or id, typ = m.type }
        seen[id] = true
      end
    end
    -- 兜底：有些测试/旧构建没有 var_meta；game.vars 本身就是全局作用域。
    for id in pairs(game.vars or {}) do
      if not seen[id] then
        rows[#rows + 1] = { id = id, name = (game.describe and game:describe(id)) or id }
      end
    end
    table.sort(rows, function(a, b) return tostring(a.name) < tostring(b.name) end)
    for _, r in ipairs(rows) do
      local v = game.vars and game.vars[r.id]
      if type(v) == "table" then
        local n = #v
        local first = {}
        for i = 1, math.min(n, 12) do
          local x = v[i]
          first[#first + 1] = type(x) == "table" and "[table]" or cut(x, 18)
        end
        local more = n > 12 and (" …+" .. (n - 12)) or ""
        out[#out + 1] = ("%s [%d] = %s%s"):format(cut(r.name, 22), n, table.concat(first, ","), more)
      else
        out[#out + 1] = ("%s = %s"):format(cut(r.name, 22), cut(v, 32))
      end
    end
    out[#out + 1] = ("globals total=%d"):format(#rows)
  elseif page == 5 then
    out[#out + 1] = "pointer / stage"
    local h = game.host
    out[#out + 1] = ("mouse=(%s,%s) down=%s"):format(
      tostring(h and h.mouse_x), tostring(h and h.mouse_y), tostring(h and h.mouse_is_down))
    local wx, wy = game:pointer_world()
    out[#out + 1] = ("world=(%s,%s)"):format(finite_num(wx), finite_num(wy))
    out[#out + 1] = ("profiler on=%s"):format(tostring(opts.profiler or false))
    if opts.profiler_rows then
      for i = 1, math.min(6, #opts.profiler_rows) do out[#out + 1] = opts.profiler_rows[i] end
    end
  end
  return table.concat(out, "\n")
end

function M.toggle_console()
  if not M.console then return false end
  M.console:toggle()
  M.console_visible = M.console:isOpen() == true
  return M.console_visible
end

function M.init(host)
  if not (love and love.graphics and love.graphics.newFont) then return false end
  local ok, At = pcall(require, "At.At")
  if not ok or not At then return false end
  At.config.blur.enabled = false
  -- LÖVE 的文件路径用相对包根更稳；At 默认带前导 /。
  if At.config.font then
    At.config.font.main = "At/assets/font.ttf"
    At.config.font.emoji = "At/assets/emoji.ttf"
  end
  At.config.apply()
  At.log.setFile(false)
  At.log.setLevel("info")
  pcall(At.font.init, 16)
  M.At = At
  M.host = host
  M.available = true
  M.fps = 0
  M.fps_n, M.fps_t = 0, love.timer.getTime()

  -- 日志也进入 At.Console；保留原 host.log 的终端输出。
  if host and host.log then
    local orig = host.log
    host.log = function(h, msg, level)
      pcall(function() At.log.info("%s", tostring(msg)) end)
      return orig(h, msg, level)
    end
  end

  local function set_panel_parts(v)
    M.panel:setVisible(v)
    M.body_view:setVisible(v)
    M.header:setVisible(v)
    M.page_label:setVisible(v)
    M.prev_btn:setVisible(v)
    M.next_btn:setVisible(v)
    M.close_btn:setVisible(v)
  end
  M.set_panel_visible = set_panel_parts

  local function toggle_panel()
    M.visible = not M.visible
    set_panel_parts(M.visible)
  end
  M.toggle_panel = toggle_panel

  M.fps_label = At.Label({ text = "0 FPS", fontSize = 13, color = "#FFFFFF", w = 64 })
  M.fps_panel = At.Panel({
    x = 8, y = 8, w = 76, h = 24, direction = "row", align = "center", padding = 4,
    radius = 4, background = "#111820", alpha = 165,
    children = { M.fps_label },
  })
  M.debug_btn = At.Button({ text = "DBG", w = 58, h = 26, fontSize = 12, onClick = toggle_panel })
  M.log_btn = At.Button({ text = "LOG", w = 58, h = 26, fontSize = 12, onClick = M.toggle_console })

  M.body = At.Label({ text = "", w = "100%", wrap = true, fontSize = 13, color = "#DCE4F0", lineHeight = 1.35 })
  M.body_view = At.ScrollView({ w = "100%", h = 280, content = M.body,
    background = "#0B1118", scrollbar = true, radius = 6, padding = 6 })
  M.page_label = At.Label({ text = "", w = 260, fontSize = 12, color = "#9FB0C8" })
  M.prev_btn = At.Button({ text = "PREV", w = 56, h = 24, fontSize = 11, radius = 5,
    onClick = function() M.page = ((M.page - 2) % M.pages) + 1 end })
  M.next_btn = At.Button({ text = "NEXT", w = 56, h = 24, fontSize = 11, radius = 5,
    onClick = function() M.page = (M.page % M.pages) + 1 end })
  M.close_btn = At.Button({ text = "×", w = 30, h = 24, fontSize = 16, radius = 5,
    onClick = toggle_panel })
  M.header = At.Panel({
    direction = "row", gap = 6, w = "100%", h = 26, padding = 0, children = {
      M.page_label, M.prev_btn, M.next_btn, M.close_btn,
    },
  })
  M.panel = At.Panel({
    x = 8, y = 52, w = 600, h = 390, visible = false, direction = "column", gap = 8,
    padding = 12, radius = 10, background = "#111820", alpha = 240, borderColor = "#3A485A",
    children = {
      M.header,
      M.body_view,
    },
  })
  set_panel_parts(false)
  M.console = At.Console({ x = 8, y = 60, w = 600, h = 300, visible = false, tab = false })

  -- 加载界面：At 字体已就绪，主循环 loading 阶段也用它。
  local sw, sh = love.graphics.getDimensions()
  local pw = math.min(430, math.max(260, sw - 80))
  local ph = 150
  M.loading_title = At.Label({ text = "加载中…", fontSize = 20, color = "#FFFFFF", w = pw - 32 })
  M.loading_pct = At.Label({ text = "0%", fontSize = 13, color = "#9FB0C8" })
  M.loading_bar = At.ProgressBar({ w = pw - 32, h = 12, value = 0, animate = false,
    trackColor = "#3A4352", fillColor = "#8FB5E8" })
  M.loading_panel = At.Panel({
    x = math.floor((sw - pw) / 2), y = math.floor((sh - ph) / 2), w = pw, h = ph,
    direction = "column", gap = 10, padding = 16, radius = 12,
    background = "#101720", alpha = 245, borderColor = "#2F3D50",
    children = { M.loading_title, M.loading_pct, M.loading_bar },
  })
  M.loading_panel:setVisible(true)
  M.set_hud_visible(false)
  return true
end

function M.set_hud_visible(v)
  if not M.available then return end
  M.fps_panel:setVisible(v)
  M.debug_btn:setVisible(v)
  M.log_btn:setVisible(v)
end

function M.layout()
  if not M.available then return end
  local sw, sh = love.graphics.getDimensions()
  M.fps_panel:setRect(8, 8, 76, 24)
  M.debug_btn:setRect(sw - 66, 8, 58, 26)
  M.log_btn:setRect(sw - 66, sh - 34, 58, 26)
  local pw = math.min(600, sw - 16)
  local ph = math.min(390, sh - 64)
  M.panel:setRect(8, 50, pw, ph)
  -- body 只能占面板剩余高度：padding(12*2) + header(26) + gap(8)
  M.body_view.h = math.max(40, ph - 24 - 26 - 8)
  M.body_view.w = math.max(80, pw - 24)
end

function M.loading_update(dt)
  if not M.available then return false end
  M.At.update(dt)
  return true
end

function M.draw_loading(progress)
  if not M.available then return false end
  progress = math.max(0, math.min(1, tonumber(progress) or 0))
  love.graphics.clear(0.06, 0.07, 0.10)
  M.loading_pct:setText(("%d%%"):format(math.floor(progress * 100 + 0.5)))
  M.loading_bar:setValue(progress, true)
  M.loading_panel:draw()
  return true
end

function M.finish_loading()
  if not M.available then return end
  M.loading_panel:setVisible(false)
  M.set_hud_visible(true)
end

function M.update(dt)
  if not M.available then return end
  M.At.update(dt)
  local perf = _G.__KN_PERF or {}
  M.perf_n = (M.perf_n or 0) + 1
  M.perf_step_sum = (M.perf_step_sum or 0) + (perf.step or 0)
  M.perf_draw_sum = (M.perf_draw_sum or 0) + (perf.draw or 0)
  M.perf_step_max = math.max(M.perf_step_max or 0, perf.step or 0)
  M.perf_draw_max = math.max(M.perf_draw_max or 0, perf.draw or 0)
  M.fps_n = (M.fps_n or 0) + 1
  local now = love.timer.getTime()
  if not M.fps_t or now - M.fps_t >= 0.5 then
    M.fps = M.fps_n / math.max(now - (M.fps_t or now), 1e-3)
    M.fps_t, M.fps_n = now, 0
  end
  if not M.perf_t or now - M.perf_t >= 1.0 then
    local n = math.max(1, M.perf_n or 1)
    M.avg_step, M.avg_draw = M.perf_step_sum / n, M.perf_draw_sum / n
    M.max_step, M.max_draw = M.perf_step_max or 0, M.perf_draw_max or 0
    M.perf_t, M.perf_n, M.perf_step_sum, M.perf_draw_sum = now, 0, 0, 0
    M.perf_step_max, M.perf_draw_max = 0, 0
  end
end

function M.draw(game)
  if not M.available or not game then return end
  local perf = _G.__KN_PERF or {}
  local build = "?"
  local ok, b = pcall(function() return require("rt.init").build end)
  if ok and type(b) == "table" then build = b.id end
  M.layout()
  M.fps_label:setText(("%d FPS"):format(math.floor((M.fps or 0) + 0.5)))
  M.fps_panel:draw()
  M.debug_btn:draw()
  M.log_btn:draw()
  if M.visible then
    local prof = package.loaded["rt.host.profiler"]
    local rows
    if prof and prof.on then
      -- prof.top 返回 (rows, samples) 两个值；不能直接塞进 { } 后当字符串数组。
      local list = prof.top(6)
      rows = list
    end
    M.page_label:setText(("DEBUG %d/%d"):format(M.page, M.pages))
    M.body:setText(M.page_text(game, M.page, {
      build = build, fps = math.floor((M.fps or 0) + 0.5),
      step_ms = perf.step, draw_ms = perf.draw,
      avg_step = M.avg_step, max_step = M.max_step,
      avg_draw = M.avg_draw, max_draw = M.max_draw,
      profiler = prof and prof.on or false, profiler_rows = rows,
    }))
    M.panel:draw()
  end
  M.console_visible = M.console:isOpen() == true
  if M.console_visible or (M.console.openAmount and M.console:openAmount() > 0.001) then
    M.console:draw()
  end
end

-- 控制台是变量/列表 monitor 之上的浮层（见 main.lua 的绘制顺序）。
-- 命中必须与图层一致：先问控制台，命中后不再下传给 monitor。
local function console_active()
  local c = M.console
  if not c then return false end
  return c:isOpen() == true or (c.openAmount ~= nil and c:openAmount() > 0.001)
end

function M.mousepressed(x, y, b, touch, presses)
  if not M.available then return false end
  if console_active() and M.console.mousepressed and M.console:mousepressed(x, y, b) then
    M.capture = true
    M.console_capture = true   -- 这次按下属于控制台，release 只让它收尾
    return true
  end
  local handled = M.At.mousepressed(x, y, b, touch, presses) == true
  if handled then M.capture = true end
  return handled
end

function M.mousereleased(x, y, b, touch, presses)
  if not M.available then return false end
  -- 即使指针已不在控制台上，也要让它收尾（拖动窗口、滚动惯性）
  local console_handled = false
  if M.console and M.console.mousereleased then
    console_handled = M.console:mousereleased(x, y, b) == true
  end
  local handled = M.At.mousereleased(x, y, b, touch, presses) == true
  local was_console = M.console_capture == true
  M.console_capture = nil
  if M.capture then
    M.capture = false
    return true
  end
  -- 按下不在控制台上时，别让控制台的 release 吃掉舞台的松开事件
  return (was_console and console_handled) or handled
end

function M.keypressed(key, scancode, isrepeat)
  if not M.available then return false end
  if key == "f1" then
    M.toggle_panel()
    return true
  end
  if key == "f2" then
    M.toggle_console()
    return true
  end
  return M.At.keypressed(key, scancode, isrepeat) == true
end

function M.textinput(text)
  if not M.available then return false end
  return M.At.textinput(text) == true
end

function M.wheelmoved(dx, dy)
  if not M.available then return false end
  -- 控制台盖住 monitor 时，滚轮归控制台（它内部再决定是否滚动日志）
  if console_active() and M.console.wheelmoved and M.console:wheelmoved(dx, dy) then
    return true
  end
  return M.At.wheelmoved(dx, dy) == true
end

return M
