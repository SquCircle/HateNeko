-- KN 作品播放器（Love2D）：加载资源 → 绿旗 → 每帧 step → 绘制
-- 启动参数都在 conf.lua 的 STARTUP 表里（打包在压缩包内，不涉及本地存储）。
--
-- 关键：**加载期不跑作品脚本**。官方也是等资源（造型/声音）就绪才放行；
-- 否则"当…/碰到…/按键"这些 hat 会在加载期乱跑，依赖造型尺寸或内容的脚本就会错乱。
io.stdout:setvbuf("line")
_G.__DBGHOST = nil
local PROBE = { on = false }
local SHOT = { on = false, every = 45, max = 1200, marks = { 150, 300, 450, 600, 800, 1000, 1200 } }
_G._STAMP_DBG = nil       -- 印章调试：关（开一次会额外 draw 调用）
_G._YIELD_PROBE = (os.getenv("KN_YIELD_PROBE") == "1")  -- 默认关：开启会让每次循环让出都 debug.getinfo（实机 ~30ms/帧）
local rt = require("rt.init")
local LoveHost = require("rt.host.love")

local loading = true
local progress = 0
local diag = nil        -- STARTUP.diag = true 时装载（rt/host/diag.lua）
local atui = require("rt.host.atui")

function love.load(args)
  -- 作品大量用「随机造型/随机音乐」：不播种的话每次启动都是同一个序列（每次都同一个背景）
  pcall(function() math.randomseed(os.time() + math.floor((love.timer.getTime() * 1000) % 100000)) end)
  local cfg = (type(STARTUP) == "table") and STARTUP or {}
  -- 探针：conf 里 probe=true，或命令行加 probe（love <游戏目录> probe）
  if args then
    for _, a in ipairs(args) do
      if a == "probe" then PROBE.on = true end
      if a == "shot" then SHOT.on = true end
      local m = tostring(a):match("^frames=(%d+)$")
      if m then SHOT.max = tonumber(m) end
    end
  end
  PROBE.on = PROBE.on or cfg.probe == true
  local host = LoveHost.new()
  host.bg_fit = cfg.bg_fit        -- 背景铺法：nil(官方规则) / native / cover / contain / stretch
  host.stage_fit = cfg.stage_fit or "contain"
  host.ask_value = cfg.ask or ""  -- 「弹出输入框」积木的固定内容
  -- 颜色碰撞诊断：必须等 host 创建后再设置。
  host.color_debug = cfg.color_debug == true
  host.hide_variables = cfg.hide_variables == true
  host.test_values = cfg.test_values == true
  host.key_sim = cfg.key_sim == true
  rt.set_host(host)
  -- diag：conf 的 STARTUP.diag，或包内存在 diag.on 标记文件（打包 diag 版用，正式包没有）
  local want_diag = cfg.diag
  if not want_diag then
    local oki, inf = pcall(function() return love.filesystem.getInfo("diag.on") end)
    want_diag = oki and inf ~= nil
  end
  if want_diag then
    diag = require("rt.host.diag").install(host, { work = cfg.work })
  end
  atui.init(host)

  local name = cfg.work or "media"
  local ok, work = pcall(require, "works." .. name)
  if not ok or type(work) ~= "table" then
    host:log("加载作品失败：works/" .. tostring(name) .. ".lua → " .. tostring(work), "warn")
    loading = false
    return
  end

  -- 窗口比例跟随作品舞台；竖屏作品锁竖屏，横屏作品锁横屏。
  local sw, sh = work.stage_w or 562, work.stage_h or 900
  local want = tostring((type(STARTUP) == "table" and STARTUP.orientation) or "auto")
  local landscape
  if want == "landscape" then landscape = true
  elseif want == "portrait" then landscape = false
  else landscape = sw >= sh end
  local k = math.min(760 / sw, 760 / sh, 1.6)
  local ww, wh = math.floor(sw * k), math.floor(sh * k)
  if landscape and wh > ww then ww, wh = wh, ww end
  if (not landscape) and ww > wh then ww, wh = wh, ww end
  pcall(love.window.setMode, ww, wh, { resizable = false, vsync = 1, minwidth = ww, minheight = wh })

  if PROBE.on then
    pcall(function() require("rt.init").install_nan_watchdog() end)
  end
  rt.load(work, host)   -- 注意：这里**不发绿旗**，先进入加载期
  if cfg.profile then pcall(function() require("rt.host.profiler").start() end) end
  if PROBE.on then
    -- spawn 钩子：每次启动线程都记录（hat + owner + 体行号）
    local orig_spawn = rt.game.sched.spawn
    rt.game.sched.spawn = function(self2, owner, hat, args, body, event, reg)
      local t = orig_spawn(self2, owner, hat, args, body, event, reg)
      local li = body and debug.getinfo(body, "S")
      host:log(("  [spawn] %-26s owner=%-16s bodyLine=%s"):format(tostring(hat),
        tostring(owner and owner.name), tostring(li and li.linedefined)))
      return t
    end
    -- 线程结束时也记一笔
    local orig_finish = rt.game.sched.finish
    rt.game.sched.finish = function(self2, th)
      local li = th.body and debug.getinfo(th.body, "S")
      host:log(("  [finish] %-25s owner=%-16s bodyLine=%s"):format(tostring(th.hat),
        tostring(th.owner and th.owner.name), tostring(li and li.linedefined)))
      return orig_finish(self2, th)
    end
  end
  if PROBE.on then
    rt.game.debug_nan = true
    rt.game.on_error = function(th, e)
      host:log(("[运行时错误] owner=%s hat=%s → %s"):format(
        tostring(th and th.owner and th.owner.name), tostring(th and th.hat), tostring(e)), "error")
    end
  end
  host:log(("作品 %s  舞台 %dx%d  背景铺法 %s")
    :format(name, work.stage_w or 0, work.stage_h or 0, tostring(host.bg_fit or "官方规则")))
end

-- 探针模式（仅在 conf.lua 的 STARTUP.probe = true 时启用）：
-- 走**真宿主**（真窗口/真鼠标事件/真资源加载）跑一遍脚本化操作并打印指标，
-- 用于"真机路径验证"（无头测试全绿不等于真机正常）。
local PN = 0

-- 长跑截图模式（love <目录> shot [帧数]）：周期性点击穿过入口，多个时点存图。
-- 用途：像真机一样"看到"第 2 屏之后的画面（探针只按 140 帧就退出了）。
function LoveProbe(g, host)
  local function iv() for k, v in pairs(g.vars) do if g:describe(k) == "i" then return v end end return 0 end
  local function sc() local r for _, e in ipairs(g.entities) do if e.kind == "screen" and e.id == g.cur_screen then r = e end end return r end
  local function report(tag)
    host:log(("PROBE %s 屏幕=%s dir=%.1f i=%d 实体=%d 线程=%d")
      :format(tag, tostring(g.cur_screen):sub(1, 8), (sc() and sc().dir or 0), iv(), #g.entities, #g.sched.threads))
  end
  PN = PN + 1
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  if host._bg_last and PN % 20 == 0 then
    local b = host._bg_last
    host:log(("  背景: 模式=%s 缩放=%.3f 纹理=%dx%d 舞台=%dx%d → 画到 %.0fx%.0f")
      :format(b.mode, b.sx, b.iw, b.ih, b.stage_w, b.stage_h, b.iw * b.sx, b.ih * b.sy))
  end
  -- NaN 首次出现帧（逐帧检查角色坐标与全局变量）
  if not _G.__nan_reported then
    local bad_ent, bad_var
    for _, e in ipairs(g.entities) do
      if type(e.x) == "number" and (e.x ~= e.x or e.y ~= e.y) then bad_ent = tostring(e.name) end
    end
    for k, v in pairs(g.vars) do
      if type(v) == "number" and v ~= v then bad_var = tostring(g:describe(k)) end
    end
    -- 脚本变量（作品大量使用 script_variables）
    for _, th2 in ipairs(g.sched.threads) do
      for k, v in pairs(th2.script_vars or {}) do
        if type(v) == "number" and v ~= v then
          bad_var = (bad_var and (bad_var .. " + ") or "") .. ("script:" .. tostring(k))
        end
      end
    end
    if bad_ent or bad_var then
      _G.__nan_reported = true
      host:log(("★ NaN 首次出现帧=%d 实体=%s 变量=%s")
        :format(PN, tostring(bad_ent), tostring(bad_var)))
    end
  end
  if PN == 3 then
    host:log("--- hat 注册表 ---")
    for hat, list in pairs(g.sched.hats) do
      for _, sreg in ipairs(list) do
        host:log(("   %-26s owner=%-16s kind=%s"):format(hat,
          tostring(sreg.owner and sreg.owner.name), tostring(sreg.owner and sreg.owner.kind)))
      end
    end
    host:log("--- 注册的 hat 体行号 ---")
    for hat, list in pairs(g.sched.hats) do
      for _, sreg in ipairs(list) do
        local li = debug.getinfo(sreg.body, "S")
        host:log(("   %-24s owner=%-16s bodyLine=%s"):format(hat,
          tostring(sreg.owner and sreg.owner.name), tostring(li and li.linedefined)))
      end
    end
    host:log("--- 当前线程 ---")
    for _, th in ipairs(g.sched.threads) do
      local li = th.body and debug.getinfo(th.body, "S")
      host:log(("   %-26s owner=%-16s done=%s bodyLine=%s wait_for=%s blocked=%.0f"):format(
        tostring(th.hat), tostring(th.owner and th.owner.name), tostring(th.done),
        tostring(li and li.linedefined), tostring(th.wait_for ~= nil), th.blocked_until or 0))
    end
  end
  if PN == 60 then
    host:log("线程状态探测:")
    for _, th in ipairs(g.sched.threads) do
      local li = th.body and debug.getinfo(th.body, "S")
      host:log(("   %-26s owner=%-16s bodyLine=%s co=%s done=%s"):format(tostring(th.hat),
        tostring(th.owner and th.owner.name), tostring(li and li.linedefined),
        coroutine.status(th.co), tostring(th.done)))
    end
  end
  if PN == 60 then
    local function gv(id) return g:get_var(id, nil, nil) end
    host:log(("裁剪条件 f60: z1(b6730dd0)=%s  15647f70=%s  ccd4ae8d=%s  p_distance=1 → 渲染=%s"):format(
      tostring(gv("b6730dd0-393e-4481-9ba7-ed35d6644d49")),
      tostring(gv("15647f70-09f4-47da-82fa-a09f334a3457")),
      tostring(gv("ccd4ae8d-e3d8-4917-a47b-c8208844c946")),
      tostring((function()
        local a = tonumber(gv("b6730dd0-393e-4481-9ba7-ed35d6644d49")) or -1e9
        local b = tonumber(gv("15647f70-09f4-47da-82fa-a09f334a3457")) or -1e9
        local c = tonumber(gv("ccd4ae8d-e3d8-4917-a47b-c8208844c946")) or -1e9
        return (a > 1) or (b > 1) or (c > 1)
      end)())))
  end
  if PN == 6 or PN == 60 or PN == 120 then
    local tv = g:get_var("46362f3a-7c20-476d-a261-a4145b692581", nil, nil)
    local now = require("rt.values").num(rt.f["get_time"](nil, { time = "second" }, nil))
    host:log(("秒数探测 f%d: t=%s(%s) get_time(second)=%s 线程=%d"):format(
      PN, tostring(tv), type(tv), tostring(now), #g.sched.threads))
  end
  if PN == 6 then
    local sc
    for _, e in ipairs(g.entities) do if e.kind == "screen" and e.id == g.cur_screen then sc = e end end
    if sc then
      local sid = sc:style_id()
      local img = host:style_image(g, sid)
      local f2 = host.style_file and host:style_file(g, sid)
      host:log(("style_image 探测: style=%s file=%s img=%s"):format(
        tostring(sid):sub(1, 8), tostring(f2), img and (img:getWidth() .. "x" .. img:getHeight()) or "nil"))
    end
  end
  if PN <= 30 then
    host:log(("  f%-3d 屏幕=%s dir=%.1f i=%d 线程=%d 按下=%s")
      :format(PN, tostring(g.cur_screen):sub(1, 8), (sc() and sc().dir or 0), iv(), #g.sched.threads,
        tostring(host.mouse_is_down)))
  end
  if PN == 20 then report("开局")
  elseif PN == 22 then host:on_mouse_pressed(w / 2, h / 2, 1)
  elseif PN == 25 then
    host:on_mouse_released(w / 2, h / 2)
    -- 诊断：每条 hat 登记项的场景门判定
    local Scene = require("rt.scene")
    for hat, list in pairs(g.sched.hats) do
      for _, sreg in ipairs(list) do
        local o = sreg.owner
        host:log(("  门: %-22s owner=%-8s kind=%-6s scene=%s id=%s 通过=%s")
          :format(hat, tostring(o and o.name), tostring(o and o.kind),
            tostring(o and o.scene):sub(1, 8), tostring(o and o.id):sub(1, 8),
            tostring(o and Scene.in_scene(o, g))))
      end
    end
    host:log(("  当前屏幕=%s  排队事件=%d"):format(tostring(g.cur_screen):sub(1, 8), #(host.events or {})))
  elseif PN == 40 then report("点击1后")
  elseif PN == 45 then host:on_mouse_pressed(w / 2, h / 2, 1)
  elseif PN == 48 then host:on_mouse_released(w / 2, h / 2)
  elseif PN == 60 then report("点击2后")
  elseif PN == 120 then
    report("1秒后")
    -- 笔层像素统计（确认画笔真的画出来了）
    if host._pen_canvas then
      local ok, id = pcall(function() return host._pen_canvas:newImageData() end)
      if ok and id then
        local w2, h2 = id:getWidth(), id:getHeight()
        local n = 0
        for yy = 0, h2 - 1, 2 do
          for xx = 0, w2 - 1, 2 do
            local _, _, _, a = id:getPixel(xx, yy)
            if a > 0.01 then n = n + 1 end
          end
        end
        host:log(("PROBE 笔层: %dx%d 非透明采样点=%d（>100 说明笔迹在画）"):format(w2, h2, n))
      end
    else
      host:log("PROBE 笔层: 尚未创建（这个作品没落笔？）")
    end
    for _, e in ipairs(g.entities) do
      if e.pen then
        host:log(("PROBE 画笔: %-18s down=%s size=%s color=%s last=(%s,%s) pos=(%.0f,%.0f)")
          :format(tostring(e.name), tostring(e.pen.down), tostring(e.pen.size), tostring(e.pen.color),
            tostring(e.pen.last_x), tostring(e.pen.last_y), e.x, e.y))
      else
        host:log(("PROBE 画笔: %-18s 没有 pen 字段 ✗"):format(tostring(e.name)))
      end
    end
    -- 舞台画布墨迹包围盒：画布内一律用舞台坐标，所以它与窗口尺寸无关。
    do
      local cv = host._stage_cv
      if cv then
        local okd, id = pcall(function() return cv:newImageData() end)
        if okd and id then
          local w3, h3 = id:getWidth(), id:getHeight()
          local x0, y0, x1, y1 = w3, h3, -1, -1
          local step = 4
          for yy = 1, h3, step do
            for xx = 1, w3, step do
              local r, gg, b, a = id:getPixel(xx - 1, yy - 1)
              -- 背景清屏色是 (0.14,0.16,0.22)
              if a > 0.05 and math.abs(r - 0.14) + math.abs(gg - 0.16) + math.abs(b - 0.22) > 0.08 then
                if xx < x0 then x0 = xx end
                if yy < y0 then y0 = yy end
                if xx > x1 then x1 = xx end
                if yy > y1 then y1 = yy end
              end
            end
          end
          host:log(("PROBE 舞台墨迹: 画布 %dx%d 包围盒=(%d,%d)-(%d,%d)"):format(w3, h3, x0, y0, x1, y1))
        end
      end
    end
    love.graphics.captureScreenshot(function(i) i:encode("png", "probe.png") end)
    love.graphics.captureScreenshot(function(i) i:encode("png", "probe_late.png") end)
  elseif PN == 140 then love.event.quit(0) end
end

local shot_frame = 0
local function shot_tick()
  if not SHOT.on then return end
  shot_frame = shot_frame + 1
  local host = rt.host
  local g = rt.game
  if shot_frame % SHOT.every == 0 and g then
    local w, h = love.graphics.getDimensions()
    host:click(w / 2, h / 2, nil)          -- 点击屏幕中心（穿过入口/确认）
  end
  if shot_frame % 60 == 0 and g then
    local host2 = rt.host
    host2:log(("SHOT f=%d 屏幕=%s 实体=%d 线程=%d"):format(shot_frame, tostring(g.cur_screen),
      #g.entities, #g.sched.threads))
  end
  for _, m in ipairs(SHOT.marks) do
    if shot_frame == m then
      love.graphics.captureScreenshot("shot_" .. m .. ".png")
    end
  end
  if shot_frame >= SHOT.max then love.event.quit(0) end
end

function love.update(dt)
  shot_tick()
  if loading then
    if atui.available then atui.loading_update(dt) end
    -- 分批加载资源；全部就绪后才发绿旗，作品脚本才真正开始
    if rt.host.preload and not rt.host:preload(rt.game, 8) then
      progress = rt.host:preload_progress(rt.game)
      return
    end
    progress = 1
    loading = false
    if atui.available then atui.finish_loading() end
    rt.host:log("资源加载完成，绿旗开始")
    rt.start()
    return
  end
  atui.update(dt)
  local _t0 = love.timer.getTime()
  rt.step(dt)
  _G.__KN_PERF = _G.__KN_PERF or {}
  _G.__KN_PERF.step = (love.timer.getTime() - _t0) * 1000
  if diag then diag.tick(rt.game, rt.host) end
end

function love.draw()
  if loading then
    if atui.available and atui.draw_loading(progress) then return end
    -- AtUI 初始化失败时回退旧加载界面
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.clear(0.08, 0.09, 0.12)
    local lsize = math.max(14, math.floor(h / 28))
    local base = rt.host:make_font()
    local lk = lsize / (rt.host.FONT_BASE or 128)
    love.graphics.setFont(base)
    love.graphics.setColor(1, 1, 1)
    love.graphics.push()
    love.graphics.scale(lk, lk)
    love.graphics.printf(("加载中… %d%%"):format(math.floor(progress * 100 + 0.5)), 0, (h * 0.45) / lk, w / lk, "center")
    love.graphics.pop()
    love.graphics.setColor(0.4, 0.45, 0.55)
    love.graphics.rectangle("line", w * 0.15, h * 0.55, w * 0.7, 12)
    love.graphics.setColor(0.5, 0.85, 0.6)
    love.graphics.rectangle("fill", w * 0.15, h * 0.55, w * 0.7 * progress, 12)
    return
  end
  if PROBE.on then LoveProbe(rt.game, rt.host) end
  local _d0 = love.timer.getTime()
  rt.host:draw(rt.game)
  _G.__KN_PERF = _G.__KN_PERF or {}
  _G.__KN_PERF.draw = (love.timer.getTime() - _d0) * 1000
  if atui.available then
    -- 图层自下而上：舞台 → 变量/列表 monitor → AtUI（FPS/DBG/LOG/调试面板/控制台）。
    -- monitor 属于舞台监视层，必须压在控制台下面；反过来画会让变量/列表盖住控制台。
    if rt.host.monitors then rt.host.monitors:draw(rt.game) end
    if rt.host.ui_at then rt.host.ui_at:draw(rt.game) end
    if rt.host.ui_timer then rt.host.ui_timer:draw(rt.game) end
    if rt.host.ui_keys then rt.host.ui_keys:draw(rt.game) end
    atui.draw(rt.game)                                -- 控制台在本层最上，命中优先级同步见 atui.mousepressed
  elseif rt.host.hud then
    rt.host:hud(rt.game)                              -- At 初始化失败时仅回退 HUD
  end
  if diag then diag.after_draw(rt.game) end             -- 到点存截图（回调在本帧渲染后）

end

-- 作品需要的输入事件（键盘/鼠标）继续转发给运行时
function love.quit()
  if diag then diag.flush() end
end

-- 输入路由（H-1/H-2）：只把“确实下发给运行时”的按下事件在抬起时补回去。
-- AtUI 控制台/弹窗会吞掉 keypressed / mousepressed；以前抬起仍无条件转发，
-- 会向作品派发“凭空松开/点击”事件。
local runtime_keys = {}          -- key -> true（已转发给运行时的按住键）
local runtime_mouse_down = false -- 运行时收到了 mousepressed
local runtime_touch_id = nil     -- 运行时收到了 touchpressed 的 id

function love.keypressed(key, scancode, isrepeat)
  if atui.keypressed(key, scancode, isrepeat) then return end
  if rt.host:on_key(key, true) then runtime_keys[key] = true end
end
function love.keyreleased(key)
  if runtime_keys[key] then
    runtime_keys[key] = nil
    rt.host:on_key(key, false)
  end
end
function love.textinput(text) atui.textinput(text) end

-- 失焦/切后台：浏览器不会补发 keyup/mouseup → 主动释放，避免卡键/卡按住。
function love.focus(f)
  if f then return end
  runtime_keys = {}
  runtime_mouse_down = false
  runtime_touch_id = nil
  if rt.host and rt.host.release_all_input then rt.host:release_all_input() end
end

function love.mousemoved(x, y)
  if rt.host.is_mobile then return end
  rt.host:on_mouse(x, y)
end
function love.mousepressed(x, y, button, touch, presses)
  if rt.host.is_mobile then return end
  -- 屏幕外按下不产生任何交互；屏幕内按下后移出屏幕仍沿用原按下状态。
  local sw, sh = love.graphics.getDimensions()
  if x < 0 or y < 0 or x > sw or y > sh then return end
  if atui.mousepressed(x, y, button, touch, presses) then return end
  runtime_mouse_down = true
  rt.host:on_mouse_pressed(x, y, button)
end
function love.mousereleased(x, y, button, touch, presses)
  if rt.host.is_mobile then return end
  local atui_handled = atui.mousereleased(x, y, button, touch, presses)
  -- 只有运行时真的收到过按下，才把抬起交给它（否则会出现“没按下也点击”）
  if runtime_mouse_down then
    runtime_mouse_down = false
    rt.host:on_mouse_released(x, y)
  elseif atui_handled then
    -- 控制台/面板消费掉，不进入作品
  end
end

-- 移动端：LÖVE ≥0.10 的 touch 坐标已经是**窗口像素**（官方文档），
-- 不能再乘窗口宽高（H-4：以前会乘成屏幕外的巨大坐标，触摸全丢）。
function love.touchpressed(id, x, y)
  if not rt.host.is_mobile then return end
  if atui.mousepressed(x, y, 1, true, 1) then return end
  runtime_touch_id = id
  rt.host:on_touch_pressed(x, y, id)
end
function love.touchmoved(id, x, y)
  if not rt.host.is_mobile then return end
  if runtime_touch_id == nil or id ~= runtime_touch_id then return end
  rt.host:on_touch_moved(x, y, id)
end
function love.touchreleased(id, x, y)
  if not rt.host.is_mobile then return end
  local atui_handled = atui.mousereleased(x, y, 1, true, 1)
  if runtime_touch_id ~= nil and (id == nil or id == runtime_touch_id) then
    runtime_touch_id = nil
    rt.host:on_touch_released(x, y, id)
  elseif atui_handled then
    -- 控制台消费
  end
end
function love.wheelmoved(dx, dy)
 atui.wheelmoved(dx, dy)
end
