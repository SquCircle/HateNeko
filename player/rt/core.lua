-- KN → Love2D 运行时内核：实体 / 线程 / 调度器
--
-- 语义对齐官方 Heart/Ohno 引擎（见 docs/04、analysis/warp_report.md）：
--   * 非 warp 循环：每帧只跑 1 次迭代（循环末尾 yield）
--   * warp 循环：每帧预算 30000 次迭代 / 4ms（只在循环末尾检查，预算每帧重置）
--   * 阻塞（等待/渐变/弹窗…）由运行时登记 blocked_until，被阻塞的线程整帧不 resume
--   * 一个 hat 脚本 = 一个线程（协程）；克隆体各自一个；tell/广播在目标上新建线程
local Values = require("rt.values")

local core = {}

local C = {
  max_warp_iterations = 30000, -- 官方 max_warp_iterations_per_interpreter_step
  warp_time_limit_ms = 4,      -- 官方 warp_interpreter_millisecond_time_limit
  max_clones_per_entity = 300,
  max_threads = 2000,
}
core.C = C

local function copy_value(v)
  if type(v) ~= "table" then return v end
  local t = {}
  for k, x in pairs(v) do t[k] = copy_value(x) end
  return t
end
core.copy_value = copy_value

-- 哨兵错误：用 identity 比较，error(obj, 0) 抛出，调度器在 resume 处捕获
local SIG = { STOP_THIS = {}, STOP_OTHER = {}, STOP_ALL = {}, RESTART = {}, BREAK_ALL = {} }
core.SIG = SIG

local host -- 由 core.set_host 注入

function core.set_host(h)
  host = h
end

-- 诊断日志：同时写 host（终端/logcat）与 At.log（AtLua 控制台可见）。
function core.diag(fmt, ...)
  local msg = select("#", ...) > 0 and string.format(tostring(fmt), ...) or tostring(fmt)
  if host and host.log then pcall(host.log, host, msg, "diag") end
  local ok, A = pcall(require, "At.At")
  if ok and A and A.log and A.log.info then pcall(A.log.info, msg) end
end

function core.warn(fmt, ...)
  local msg = select("#", ...) > 0 and string.format(tostring(fmt), ...) or tostring(fmt)
  if host and host.log then pcall(host.log, host, msg, "warn") end
  local ok, A = pcall(require, "At.At")
  if ok and A and A.log and A.log.warn then pcall(A.log.warn, msg) end
end

local function now_ms()
  return host:now_ms()
end

----------------------------------------------------------------------
-- 实体（角色 / 屏幕）
----------------------------------------------------------------------
local Entity = {}
Entity.__index = Entity
core.Entity = Entity

function Entity.new(spec)
  spec = spec or {}
  local e = setmetatable({}, Entity)
  e.kind = spec.kind or "actor"        -- "actor" | "screen"
  e.seq = (Entity._seq or 0) + 1        -- 创建序号：同 layer/order 时的稳定裁决（后建的在上）
  Entity._seq = e.seq
  -- ★ 编译器给出的元数据必须**整块**拷过来（漏一个就让整块功能空转：
  --   order 漏了 → 图层顺序空转；img_w 漏了 → 碰撞恒假；scene/scenes 漏了 → 角色不随屏幕显隐）
  for _, k in ipairs({ "order", "layer", "scene", "scenes", "is_global",
                       "img_w", "img_h", "center_point" }) do
    if spec[k] ~= nil then e[k] = spec[k] end
  end
  -- 大小只有两轴倍数（scale_x/scale_y，1.0 = 原尺寸）；不再有 scale 字段。
  -- 编译产物里的 scale 是**百分比输入**，在这里换算一次。
  local _k = (spec.scale or 100) / 100
  e.scale_x = spec.scale_x or _k
  e.scale_y = spec.scale_y or _k
  e.styles = spec.styles or {}                 -- 造型列表
  e.style_index = spec.style_index or 1        -- 当前造型下标（默认第一个）
  e.layer = spec.layer                 -- 「移到最上层/最下层」设置的层号
  e.scene = spec.scene                 -- 所属屏幕（单值，兼容旧数据）
  e.scenes = spec.scenes               -- 所属屏幕列表（编辑器里可能在多个屏幕）
  e.is_global = spec.is_global         -- 被所有屏幕共享（编辑器"所有屏幕"）
  e.scene_ok = true                    -- 场景门：当前屏幕是否包含它（与自身 visible 分开，互不覆盖）
  e.id = spec.id or spec.name or ("e" .. tostring(math.random(1e6)))
  e.name = spec.name or ""
  e.x = spec.x or 0
  e.y = spec.y or 0
  e.dir = spec.dir or spec.rotation or 0 -- 假设 0 = 朝右、逆时针为正（待与官方播放器比对）
  e.scale_x, e.scale_y = (spec.scale_x or _k or 1), (spec.scale_y or _k or 1)
  e.visible = (spec.visible ~= false)
  e.alpha = spec.alpha or 100
  e.layer = spec.layer or 0
  e.rotation_style = spec.rotation_style or "all" -- all | left_right | none
  e.styles = spec.styles or {}
  e.style_index = spec.style_index or 1
  e.effects = { color = 0, opacity = 0, brightness = 0, pixelate = 0, ripple = 0, distortion = 0, grayscale = 0 }
  e.text_effect = nil
  if spec.effects then for k, v in pairs(spec.effects) do e.effects[k] = v end end
  e.vars = {}
  e.lists = {}
  e.pen = { down = false, size = 1, color = "#000000", hsl = { 0, 0, 0 }, alpha = 1, drawing = {} }
  e.draggable = false
  e.edge_bounce = false
  e.clones = 0
  e.clone_index = 0
  e.is_clone = false
  e.parent = nil
  e.deleted = false
  return e
end

function Entity:style_id()
  return self.styles[self.style_index]
end

function Entity:set_style_by_id(id)
  for i = 1, #self.styles do
    if self.styles[i] == id then self.style_index = i return true end
  end
  return false
end

function Entity:clone_self()
  local c = setmetatable({}, Entity)
  for k, v in pairs(self) do c[k] = v end
  c.vars = {}
  for k, v in pairs(self.vars) do c.vars[k] = v end
  c.lists = {}
  for k, v in pairs(self.lists) do
    local src, dst = v, {}
    for i = 1, #src do dst[i] = src[i] end
    c.lists[k] = dst
  end
  c.effects = {}
  for k, v in pairs(self.effects) do c.effects[k] = v end
  if self.text_effect then
    c.text_effect = {}
    for k, v in pairs(self.text_effect) do c.text_effect[k] = v end
  end
  local ph = self.pen.hsv or self.pen.hsl or { 0, 0, 0 }
  c.pen = { down = self.pen.down, size = self.pen.size, color = self.pen.color,
    hsv = { ph[1] or 0, ph[2] or 0, ph[3] or 0 },
    hsl = { ph[1] or 0, ph[2] or 0, ph[3] or 0 },
    alpha = self.pen.alpha or 1, drawing = {} }
  c.is_clone = true
  c.parent = self
  -- 克隆体要有**自己的创建序号**：否则复制父体 seq，同 order 时排序不稳。
  -- 官方克隆体作为新 child 加在父体之后（更上层）；bottom_first 用 seq 打破同 order。
  c.seq = (Entity._seq or 0) + 1
  Entity._seq = c.seq
  -- 克隆体编号**单调递增**：删掉的编号不回收（官方也是这样，作品常拿它当唯一键
  -- 往列表里登记；用"存活数+1"会复用编号，导致新克隆体继承旧条目、点了删不掉）
  self.clone_seq = (self.clone_seq or 0) + 1
  c.clone_index = self.clone_seq
  c.id = self.id .. "#" .. c.clone_index
  c.clones = 0
  c.deleted = false
  return c
end

----------------------------------------------------------------------
-- 线程（= 官方 interpreter）
----------------------------------------------------------------------
local Thread = {}
Thread.__index = Thread
core.Thread = Thread

function Thread.new(sched, owner, hat, args, body, event, exec_self)
  local t = setmetatable({}, Thread)
  t.sched = sched
  t.owner = owner
  t.base_exec_self = exec_self or owner
  t.execution_self = t.base_exec_self
  t.hat = hat
  t.args = args or {}
  t.event = event or {}
  t.body = body
  t.blocked_until = 0
  t.done = false
  t.warp_frames = 0   -- 运行期 warp 深度（覆盖 warp 内调用的过程体）
  t.warp_iters = 0    -- 本帧已消耗的 warp 迭代数
  t.frame_start = 0
  t.script_vars = {}  -- 脚本私有变量（官方按 interpreter 作用域）
  t.born_frame = (sched and sched.game and sched.game.frame) or 0
  t.params = {}       -- 参数栈：traverse_number_param / self_listen_param
  t.frames = {}       -- trampoline 过程帧
  t.call_depth = 0
  t.wait_for = nil    -- 等待的线程集合（广播并等待 / 告诉执行并等待）
  t.lock_count = 0    -- per-thread 阻塞锁数量（官方 get_thread_lock 的 interpreter 粒度）
  t.co = coroutine.create(function()
    body(t, t.execution_self)
  end)
  return t
end

-- 循环收尾：非 warp —— 每帧 1 次迭代
-- 返回 true 表示「本层循环应跳出」（break 积木）
function Thread:iter_n()
  if _G._YIELD_PROBE then
    local info = debug.getinfo(2, "Sl")
    if info then
      local key = tostring(info.short_src) .. ":" .. tostring(info.currentline)
      _G._YIELD_SEEN = _G._YIELD_SEEN or {}
      if not _G._YIELD_SEEN[key] then
        _G._YIELD_SEEN[key] = true
        print("[YIELD] " .. key .. "  hat=" .. tostring(self.hat) .. " owner=" .. tostring(self.owner and self.owner.name))
      end
    end
  end
  coroutine.yield()
  return false
end

-- 循环收尾：编译期已知在「一步执行(warp)」内
function Thread:iter_w()
  self:budget_warp()
  return false
end

-- 循环收尾：运行期判断（过程体 / tell 体：可能被 warp 调用）
function Thread:iter_d()
  if self.warp_frames > 0 then
    self:budget_warp()
  else
    coroutine.yield()
  end
  return false
end

function Thread:budget_warp()
  local n = self.warp_iters + 1
  self.warp_iters = n
  if n >= C.max_warp_iterations then
    coroutine.yield()
  elseif (n % 32) == 0 and (now_ms() - self.frame_start) >= C.warp_time_limit_ms then
    coroutine.yield()
  end
end

-- 阻塞：登记 blocked_until 后让出（官方 runtime_manager.thread_wait）
function Thread:block(ms)
  self.blocked_until = now_ms() + ms
  coroutine.yield()
end

function Thread:warp_enter()
  self.warp_frames = self.warp_frames + 1
end

function Thread:warp_exit()
  self.warp_frames = self.warp_frames - 1
end

function Thread:push_param(v)
  local n = #self.params + 1
  self.params[n] = v
  return n
end

function Thread:pop_params(n)
  for i = #self.params, n, -1 do self.params[i] = nil end
end

function Thread:pop_param()
  local n = #self.params
  if n > 0 then self.params[n] = nil end
end

function Thread:param()
  return self.params[#self.params]
end

-- 过程 trampoline：不在 Lua C 栈上递归，由 Sched:resume 驱动显式帧。
function Thread:call_proc(proc, self_arg, ...)
  if type(proc) ~= "function" then return nil end
  if coroutine.status(self.co) ~= "suspended" and coroutine.status(self.co) ~= "running" then
    return nil
  end
  self._proc_calls = (self._proc_calls or 0) + 1
  return coroutine.yield({
    __kn_proc = proc,
    __kn_self = self_arg,
    __kn_args = { ... },
    __kn_n = select("#", ...),
  })
end

-- 等待一组线程跑完（广播并等待 / 告诉执行并等待）
function Thread:join(threads)
  local set, count = {}, 0
  for i = 1, #threads do
    local th = threads[i]
    if th and not th.done then
      set[th] = true
      count = count + 1
    end
  end
  if count == 0 then return end -- 没有接收者：立即继续
  self.wait_for = set
  coroutine.yield()
end

----------------------------------------------------------------------
-- 调度器
----------------------------------------------------------------------
local Sched = {}
Sched.__index = Sched
core.Sched = Sched

function Sched.new(game)
  return setmetatable({
    game = game,
    threads = {},
    hats = {},          -- hat 类型 -> { {owner, args, body, cond?}, ... }
    pending_add = {},   -- 帧末加入的克隆体
    pending_del = {},   -- 帧末删除的克隆体
    input_queue = {},   -- host 投递的事件（键/鼠标/触摸/碰撞…）
    restart_epoch = 0,  -- restart 代数：旧线程不得在 restart 后重启 restart_when_finished
    dt = 0,
  }, Sched)
end

function Sched:register(owner, hat, args, body)
  local list = self.hats[hat]
  if not list then list = {} self.hats[hat] = list end
  local script = { owner = owner, hat = hat, args = args or {}, body = body,
    group_id = owner and (owner.scene or (owner.scenes and owner.scenes[1]) or owner.id) or nil }
  list[#list + 1] = script
  return script
end

function Sched:spawn(owner, hat, args, body, event, reg, exec_self)
  local t = Thread.new(self, owner, hat, args, body, event, exec_self)
  t.reg = reg
  t.epoch = self.restart_epoch or 0
  t.group_id = (reg and reg.group_id) or (owner and owner.id)
  self.threads[#self.threads + 1] = t
  return t
end

-- 官方 runtime_manager.get_thread_lock(entity, interpreter)：per-interpreter 的阻塞任务。
-- 这里只锁调用它的线程；其他线程照常推进。返回的对象由 UI callback 调 stop() 释放。
function Sched:get_thread_lock(th)
  th.lock_count = (th.lock_count or 0) + 1
  local released = false
  return {
    thread = th,
    stop = function()
      if released then return end
      released = true
      th.lock_count = math.max(0, (th.lock_count or 1) - 1)
    end,
  }
end

-- 启动某个 hat 类型的所有脚本（可选静态预过滤；等价于官方「程序内过滤器」，见 docs/04 §2.5）
-- ★ 官方登记表（逐字摘自播放器 bundle `block_metadata`，勿改）：
--   finish_out_of_run_group: ["on_running_group_activated"]
--   restart_when_finished:   ["self_listen", "self_listen_with_param", "when"]
-- 语义：每个块带 group_id（= 所属实体的 screen id，**唯独 start_on_click 不带**）；
--   运行期 running_group = 当前屏幕；块"跑出运行组"= group_id 有值且 ≠ running_group。
--   跑出运行组时，**只有** finish_out_of_run_group 里的类型会被销毁（= 只有绿旗线程）；
--   而 start_on_click 因为 group_id 为 nil，永不"跑出运行组" → 线程永不因切屏销毁。
Sched.OFFICIAL_BLOCK_METADATA = {
  finish_out_of_run_group = { on_running_group_activated = true },
  restart_when_finished = { self_listen = true, self_listen_with_param = true, when = true },
}
-- 官方编译器给每个块打 group_id（=所属屏幕），**唯独 start_on_click / start_on_click_2 不打**
--   （player bundle: `"start_on_click" !== e.type && (n[r] = t)`）
-- 结果：它们的 interpreter_out_of_running_group 恒为 false → 不受场景门限制、也不随切屏销毁。
Sched.OFFICIAL_NO_GROUP_ID = { start_on_click = true, start_on_click_2 = true }
-- 克隆体**不**监听本体的这些 hat（目前只有"绿旗/进入屏幕"）。以后要改只动这张表。
Sched.CLONE_LISTEN_EXCLUDE = { on_running_group_activated = true }
function Sched.block_finish_out_of_run_group(hat) return Sched.OFFICIAL_BLOCK_METADATA.finish_out_of_run_group[hat] == true end
function Sched.block_restart_when_finished(hat) return Sched.OFFICIAL_BLOCK_METADATA.restart_when_finished[hat] == true end

function Sched:has_live_thread(s)
  for _, t in ipairs(self.threads) do
    if not t.done and t.reg == s then return true end
  end
  return false
end

function Sched:has_live_listener(s, exec_self)
  for _, t in ipairs(self.threads) do
    if not t.done and t.reg == s and t.execution_self == exec_self then return true end
  end
  return false
end

-- 事件是否"处在当前 scene"：不在的事件即使条件满足也不启动（用户实测机制）
function Sched:hat_active(s)
  local o = s.owner
  if not o or o.deleted then return false end
  -- 官方：无 group_id 的块（start_on_click / start_on_click_2）永不"跑出运行组" → 不受场景门限制
  if Sched.OFFICIAL_NO_GROUP_ID[s.hat] then return true end
  -- 输入事件（同一帧排队的那些）用"帧开始时的场景"快照：
  -- 一个手势可能同时触发多个 hat（比如"A→切屏"和"B→计数"），
  -- 它们必须按同一场景判定，否则先跑的切屏会把后面的 hat 场景门挡掉。
  local Scene = require("rt.scene")
  if self._frame_scene ~= nil then
    local saved = self.game.cur_screen
    self.game.cur_screen = self._frame_scene
    local ok = Scene.in_scene(o, self.game)
    self.game.cur_screen = saved
    return ok
  end
  return Scene.in_scene(o, self.game)
end

-- 官方 sprite_on_tap 触发器（player.main.63b4a46c.js action spec）：
--   动作类型按下拉：mouse_click / mouse_down / mouse_up
--   --screen：click 看 global_click（仅空白处点击）；down/up 看 global_tap
--   角色：click 看 isMouseClickTarget；down/up 看该实体的 sprite_on_tap 状态
--   目标可以是本体，也可以是它的克隆体（id 前缀 "本体id#"）
function Sched:tap_match(s, ev)
  local ty = tostring(s.args.type or "mouse_click")
  local want
  if ty == "down" or ty == "mouse_down" then want = "mouse_down"
  elseif ty == "up" or ty == "mouse_up" then want = "mouse_up"
  else want = "mouse_click" end
  if ev.kind ~= want then return false end
  local target = s.args.sprite
  if target == nil or target == "" then target = "--self" end
  if target == "--screen" then return true end
  local hits = ev.hits or {}
  local function hits_has(e)
    if not e then return false end
    if hits[e.id] then return true end
    local p = tostring(e.id) .. "#"
    for id in pairs(hits) do
      if type(id) == "string" and id:sub(1, #p) == p then return true end
    end
    return false
  end
  if target == "--self" then return hits_has(s.owner) end
  -- 场景 id：只有点到舞台空白（事件主体 = 当前场景）才算
  if self.game.screens and self.game.screens[tostring(target)] then
    return hits_has(self.game.screens[tostring(target)])
  end
  local t = self.game:find(target)
  if t then return hits_has(t) end
  return hits[tostring(target)] == true
end

function Sched:fire(hat, event, filter)
  local list = self.hats[hat]
  local started = {}
  if not list then return started end
  event = event or {}
  for i = 1, #list do
    local s = list[i]
    local pass
    if event.kind and (hat == "sprite_on_tap" or hat == "sprite_on_click" or hat == "on_tap") then
      pass = self:tap_match(s, event)
    else
      pass = (not filter or filter(s))
    end
    if self:hat_active(s) and pass then
      -- 官方 clone 的 responder 是“连带监听”，不是把事件执行主体改成克隆体。
      -- 点中克隆体时仍用本体 owner 执行 hat；因此克隆体不能真正克隆克隆体自身。
      local owner = s.owner
      local tgt = owner
      local exec_self = owner
      local hit = event and event.hit
      if hat == "sprite_on_tap" or hat == "sprite_on_click" or hat == "on_tap" then
        local hits = event and event.hits
        if hits then
          -- 命中集合里优先取 owner 自己；否则取该 owner 的直接 clone。
          -- 绝不能把全局最上层 hit（例如 now 的“手指”光标）当成所有监听器的执行主体。
          if owner and owner.kind ~= "screen" and hits[owner.id] then
            exec_self = owner
          else
            local best = nil
            if owner then
              for _, e in ipairs(self.game:clones_of(owner)) do
                if hits[e.id] and not e.deleted then
                  if not best or (e.order or 0) >= (best.order or 0) then best = e end
                end
              end
            end
            if best then exec_self = best end
          end
        elseif hit and hit ~= owner and (hit.parent == owner) then
          exec_self = hit
        end
      end
      if Sched.block_restart_when_finished(hat) and self:has_live_thread(s) then
        -- 跳过
      else
        started[#started + 1] = self:spawn(tgt, hat, s.args, s.body, event, s, exec_self)
      end
    end
  end
  return started
end

-- 供 hat 条件等「没有真实线程」的上下文使用的最小线程桩
-- （条件里只会用到纯报告类原语，它们需要 th.sched.game）
function Sched:system_thread()
  if not self._sys_th then
    local th = {
      sched = self,
      script_vars = {},
      entity = nil,
      done = false,
      warping = false,
      warp_iters = 0,
      warp_frames = 0,
      _blocked = 0,
    }
    th.iter_n = function() return false end
    th.iter_w = function() return false end
    th.iter_d = function() return false end
    th.warp_enter = function() end
    th.warp_exit = function() end
    th.block = function() end
    th.params = {}
    self._sys_th = th
  end
  return self._sys_th
end

-- 启动某个屏幕（scene）里所有角色的绿旗脚本（切屏时用；官方切屏会重启该屏脚本）
function Sched:fire_green_flag(scene)
  local list = self.hats["on_running_group_activated"]
  if not list then return end
  local Scene = require("rt.scene")
  for i = 1, #list do
    local s = list[i]
    local o = s.owner
    if self:hat_active(s) then
      -- 去重只针对**同一顶 hat（同一个注册项）**：
      --   一个角色可以有多顶"当开始运行"，它们必须各起一顶（官方就是这样）；
      --   而切屏重进同一屏时，已经跑着的同一顶不要重复起（否则线程数翻倍）。
      local running = false
      for j = 1, #self.threads do
        local t2 = self.threads[j]
        if t2.reg == s and not t2.done then running = true break end
      end
      if not running then
        self:spawn(o, "on_running_group_activated", s.args, s.body, {}, s)
      end
    end
  end
end

-- 每帧检查：碰到角色时（边沿触发——只在"刚开始碰到"的那一帧触发）
function Sched:fire_bump()
  local list = self.hats["on_bump_actor"]
  if not list then return end
  local Hit = require("rt.hit")
  local g = self.game
  for i = 1, #list do
    local s = list[i]
    local o = s.owner
    if self:hat_active(s) then
      local target = s.args and (s.args.sprite or s.args.target or s.args.actor)
      local t = nil
      local target_kind = nil
      if target == "--mouse" or target == "--screen" then
        target_kind = "mouse"
      elseif target and tostring(target):sub(1, 6) == "--edge" then
        target_kind = "edge"
      elseif target and target ~= "--self" then
        t = g:find(target)
      end
      local want = tostring(s.args.type or "start")
      local candidates = { o }
      for _, e in ipairs(g:clones_of(o)) do candidates[#candidates + 1] = e end
      s._bump_prev = s._bump_prev or {}
      for ci = 1, #candidates do
        local e = candidates[ci]
        local now = false
        if target_kind == "mouse" then
          local wx, wy = g:pointer_world()
          now = Hit.is_touching(e, wx, wy, g) == true
        elseif target_kind == "edge" then
          local x1, y1, x2, y2 = Hit.aabb(e, g)
          if x1 then
            local L, R = -g.stage_w / 2, g.stage_w / 2
            local B, T = -g.stage_h / 2, g.stage_h / 2
            local edge = tostring(target)
            if edge == "--edge" then now = (x2 <= L or x1 >= R or y2 <= B or y1 >= T)
            elseif edge == "--edge_left" then now = x2 <= L
            elseif edge == "--edge_right" then now = x1 >= R
            elseif edge == "--edge_top" then now = y1 >= T
            elseif edge == "--edge_bottom" then now = y2 <= B end
          end
        elseif t and t ~= e then
          now = Hit.overlaps(e, t, g) == true
        end
        local prev = s._bump_prev[e.id] == true
        local fire = (want == "start" and now and not prev)
          or (want == "move" and now and prev)
          or (want == "end" and not now and prev)
        if fire then
          local attr = nil
          if t then
            local a = tostring(s.args.attribute or s.args.attr or "x")
            if a == "y" then attr = t.y
            elseif a == "direction" or a == "rotation" then attr = t.dir
            elseif a == "style_index" or a == "styles" then attr = t.style_index
            elseif a == "scale" then attr = (t.scale_x or 1) * 100
            else attr = t.x end
          end
          self:spawn(o, "on_bump_actor", s.args, s.body,
            { type="bump", bump_type=want, target=t, attr=attr, hit=e }, s, e)
        end
        s._bump_prev[e.id] = now
      end
    end
  end
end

function Sched:fire_when()
  local list = self.hats["when"]
  if not list then return end
  for i = 1, #list do
    local s = list[i]
    local active = self:hat_active(s) and s.cond
      and Values.bool(s.cond(self:system_thread(), s.owner))
    -- 官方 restart_when_finished：条件为真且当前没有实例时启动；
    -- 结束后由 step 的 restart_when_finished 再起，不用每帧重复 spawn。
    if active and not self:has_live_thread(s) then
      self:spawn(s.owner, "when", s.args, s.body, {})
    end
  end
end

function Sched:broadcast(message, param, sender, message_id, wait, broadcaster)
  local event = { message = message, param = param, sender = sender }
  local state = { message = message, wait = wait == true, broadcaster = broadcaster,
    status = wait and "pending" or "idle", listeners = {}, count = 0 }
  self._bcast = self._bcast or {}
  self._bcast[tostring(message)] = state
  local function match(s)
    local want = s.args.message
    local want_id = s.args.message_id or s.args.broadcast_id or s.args.messageId
    if want_id ~= nil and message_id ~= nil then
      return tostring(want_id) == tostring(message_id)
    end
    if want == nil then return true end
    return tostring(want) == tostring(message)
  end
  local started = {}
  for _, hat in ipairs({ "received_broadcast", "self_listen", "self_listen_with_param" }) do
    local list = self.hats[hat] or {}
    for i = 1, #list do
      local s = list[i]
      if self:hat_active(s) and match(s) then
        local candidates = { s.owner }
        for _, e in ipairs(self.game:clones_of(s.owner)) do candidates[#candidates + 1] = e end
        for ci = 1, #candidates do
          local e = candidates[ci]
          if not (Sched.block_restart_when_finished(hat) and self:has_live_listener(s, e)) then
            local t = self:spawn(s.owner, hat, s.args, s.body, event, s, e)
            started[#started + 1] = t
            local key = tostring(s) .. "|" .. tostring(e.id)
            if not state.listeners[key] then
              state.listeners[key] = true
              state.count = state.count + 1
            end
            t._broadcast_state = state
          end
        end
      end
    end
  end
  if state.count > 0 then state.status = "sending" end
  return started, state
end

-- broadcast_and_wait 需要等“本次新启动 + 已在运行的匹配 listener”。
function Sched:live_listeners(message)
  local out = {}
  for _, hat in ipairs({ "received_broadcast", "self_listen", "self_listen_with_param" }) do
    local list = self.hats[hat] or {}
    for i = 1, #list do
      local s = list[i]
      local want = s.args and s.args.message
      if want == nil or tostring(want) == tostring(message) then
        local candidates = { s.owner }
        for _, e in ipairs(self.game:clones_of(s.owner)) do candidates[#candidates + 1] = e end
        for _, e in ipairs(candidates) do
          for j = 1, #self.threads do
            local t = self.threads[j]
            if not t.done and t.reg == s and t.execution_self == e then out[#out+1] = t end
          end
        end
      end
    end
  end
  return out
end

function Sched:resume(th)
  local frames = th.frames or {}
  th.frames = frames
  local ok, a = coroutine.resume(th.co, self.dt)
  while true do
    if th.done then return end
    if not ok then
      if a == SIG.STOP_THIS then
        self:finish(th)
      elseif a == SIG.STOP_OTHER then
        self:finish(th)
        self:stop_scope(th, "other")
      elseif a == SIG.STOP_ALL then
        self:finish(th)
        self:stop_all()
      elseif a == SIG.RESTART then
        self:finish(th)
        self:restart()
      else
        th.error = a
        self:finish(th)
        local tb = debug.traceback(th.co, tostring(a))
        local host = self.game.host
        if host and host.log then
          host:log(("[线程错误] owner=%s hat=%s → %s\n%s"):format(
            tostring(th.owner and th.owner.name), tostring(th.hat), tostring(a), tb), "error")
        else
          print("[线程错误] " .. tostring(a) .. "\n" .. tb)
        end
        if self.game.on_error then self.game.on_error(th, a) end
      end
      return
    end
    if type(a) == "table" and a.__kn_proc then
      if #frames + 1 >= 10000 then
        local err = "recursion limit exceeded (10000)"
        local names = {}
        local last = math.max(1, #frames - 5)
        for fi = last, #frames do
          local fp = frames[fi] and frames[fi].proc
          local info = fp and debug.getinfo(fp, "nS")
          names[#names + 1] = info and (info.name or info.short_src) or "?"
        end
        core.warn("[proc] %s owner=%s hat=%s reg=%s exec=%s depth=%d frames=%d calls=%d returns=%d status=%s last=%s",
          err, tostring(th.owner and th.owner.name), tostring(th.hat),
          tostring(th.reg), tostring(th.execution_self and th.execution_self.name),
          #frames + 1, #frames, th._proc_calls or 0, th._proc_returns or 0,
          tostring(coroutine.status(th.co)), table.concat(names, ">"))
        core.warn("[proc] lists=%s", self.game:diag_list_state())
        self:finish(th)
        if self.game.on_error then self.game.on_error(th, err) end
        return
      end
      frames[#frames + 1] = { co = th.co, proc = a.__kn_proc }
      th._max_depth = math.max(th._max_depth or 0, #frames + 1)
      th.call_depth = #frames + 1
      local req = a
      th.co = coroutine.create(function()
        return req.__kn_proc(th, req.__kn_self, unpack(req.__kn_args, 1, req.__kn_n))
      end)
      ok, a = coroutine.resume(th.co)
    elseif coroutine.status(th.co) == "dead" then
      if #frames > 0 then
        local caller = table.remove(frames)
        th._proc_returns = (th._proc_returns or 0) + 1
        th.co = caller.co
        th.call_depth = #frames
        ok, a = coroutine.resume(th.co, a)
      else
        self:finish(th)
        return
      end
    else
      return
    end
  end
end

function Sched:finish(th)
  th.done = true
  -- sync_tell 内联执行可能因报错/中止没走到恢复点；线程结束时统一复位上下文
  th.execution_self = th.base_exec_self or th.owner
  if th._broadcast_state then
    local st = th._broadcast_state
    st.count = math.max(0, (st.count or 0) - 1)
    if st.count == 0 then st.status = "idle" end
    th._broadcast_state = nil
  end
  th.wait_for = nil
  local threads = self.threads
  for i = 1, #threads do
    local other = threads[i]
    local set = other.wait_for
    if set and set[th] then
      set[th] = nil
    end
  end
end

function Sched:check_join(th)
  local set, remaining = th.wait_for, 0
  for other in pairs(set) do
    if not other.done then remaining = remaining + 1 end
  end
  if remaining == 0 then th.wait_for = nil end
end

function Sched:stop_scope(th, scope)
  local threads = self.threads
  for i = 1, #threads do
    local other = threads[i]
    if other ~= th and other.owner == th.owner then other.stopped = true; self:finish(other) end
  end
end

function Sched:stop_all()
  local threads = self.threads
  for i = 1, #threads do threads[i].stopped = true; self:finish(threads[i]) end
end

function Sched:restart()
  local game = self.game
  local host = game.host
  self.restart_epoch = (self.restart_epoch or 0) + 1
  self:stop_all()
  self.threads = {}
  self.input_queue = {}
  self.pending_add = {}
  self.pending_del = {}
  self._pending_clone_start = {}
  self._frame_scene = nil
  self._bcast = {}

  -- hat 的每帧状态属于一次运行，restart 必须丢弃。
  for _, list in pairs(self.hats or {}) do
    for _, s in ipairs(list) do s._when_was = nil; s._bump_prev = nil end
  end

  -- UI / 对话 / 气泡队列
  game.bubbles = {}
  game.dialog_queue = {}
  game.ask_prompt = nil
  game.answer = nil
  game.stage_dialog = nil
  game.translate_dialog = nil
  game.last_click_frame = 0
  game.screen_transition = nil
  game.frame = 0
  game.cur_screen = game.initial_screen or game.cur_screen

  -- 输入/宿主状态
  if host then
    host.mouse_is_down, host.mouse_clicked, host.mouse_up = false, false, false
    host.mouse_clicked_frame = 0
    host.mouse_x, host.mouse_y = 0, 0
    host.keys = {}
    host.events = {}
    host.drag_ent, host.drag_dx, host.drag_dy = nil, nil, nil
    host.drag_old_x, host.drag_old_y = nil, nil
    host.press_sprite, host.press_hits, host._force_press = nil, nil, nil
    host.tap_action, host.click_targets = {}, nil
    host.global_tap, host.global_click = nil, false
    host.key_states = {}
    host._color_cache, host._color_grid, host._color_points = {}, nil, nil
    host._collision_cache, host._collision_frame = {}, nil
  end

  -- 移除所有克隆
  for i = #game.entities, 1, -1 do
    if game.entities[i].is_clone then table.remove(game.entities, i) end
  end

  -- 本体/屏幕恢复到初始属性
  for i = 1, #game.entities do
    local e = game.entities[i]
    e.clones = 0
    e.clone_seq = 0
    e.clone_index = 0
    e.parent, e.is_clone, e.deleted = nil, false, false
    e.x, e.y, e.dir = e.spawn_x or 0, e.spawn_y or 0, e.spawn_dir or 0
    e.scale_x, e.scale_y = e.spawn_scale_x or 1, e.spawn_scale_y or 1
    e.style_index = e.spawn_style_index or 1
    e.visible = e.spawn_visible ~= false
    e.alpha = e.spawn_alpha or 100
    e.draggable = e.spawn_draggable == true
    e.edge_bounce = e.spawn_edge_bounce == true
    e.layer = e.spawn_layer or 0
    e.rotation_style = e.spawn_rotation_style or "all"
    e.rotation_type = e.spawn_rotation_type
    e.scene_ok = true
    e.effects = {}
    for k, v in pairs(e.spawn_effects or {}) do e.effects[k] = v end
    e.text_effect = nil
    if e.pen then
      e.pen.down = false
      e.pen.drawing = {}
      e.pen.size = 1
      e.pen.color = "#000000"
      e.pen.alpha = 1
    end
  end

  game:reset_vars()
  game:reset_entity_vars()
  if host and host.pen_reset then host:pen_reset(game) elseif host and host.pen_clear then host:pen_clear(game) end
  game.timer = 0
  game.timer_visible = game.uses_timer == true and game.timer_hidden_default ~= true
  game.timer_running = game.uses_timer == true
  game.timer_pos = game.initial_timer_pos or game.timer_pos
  game._id_map, game._name_map = nil, nil
  game._clone_cache = nil

  -- 完整重启：重新触发绿旗/开始运行脚本。
  self:fire_green_flag(game.cur_screen)
  self:fire("start_on_click", {})
  self:fire("start_on_click_2", {})
end

function Sched:step(dt)
  self.dt = dt
  local game = self.game
  host:begin_frame(dt)

  -- 加载期：资源还没就绪时**不派发任何事件、不推进任何线程**
  -- （官方也是等资源加载完才放行；否则当…/碰到…/按键这些 hat 会在加载期乱跑，
  --   依赖造型尺寸/内容的脚本就会表现错乱）
  if not game.started then return end

  -- 1. host 侧事件（输入/碰撞…）：M1 直接投递为 hat 触发
  -- 输入事件统一按帧开始时的场景判定（见 hat_active 注释）
  self._frame_scene = game.cur_screen
  while #self.input_queue > 0 do
    local ev = table.remove(self.input_queue, 1)
    -- 事件是"排到队列、下一帧才处理"的，所以点击脉冲必须以**处理这一帧**为基准，
    -- 否则"等待直到 鼠标被点击"这类循环的退出条件永远差一帧、永远不退出。
    local e = ev.event
    if e and e.kind == "mouse_click" then
      game.last_click_frame = game.frame
      -- 官方 global_click：任何一次 <1s 的点击都置位（stage:mousedown→mouseup<1s），one_frame
      if game.host then game.host.global_click = true end
    elseif e and e.kind then
      -- mouse_down / mouse_up 不产生点击脉冲
    elseif e and (e.type == "mouse_click" or ev.hat == "sprite_on_tap" or ev.hat == "on_swipe") then
      game.last_click_frame = game.frame
    end
    self:fire(ev.hat, ev.event, ev.filter)
  end

  self._frame_scene = nil

  -- 2. 每帧条件事件
  self:fire_when()
  self:fire_bump()

  -- 3. 恢复线程
  -- 注意：**不要**在这里加"单帧时间预算"来跳过剩余线程。
  -- 线程是按登记顺序恢复的，一旦提前 break，排在后面的角色（特效/交互/克隆体）会被
  -- 永久饿死：画面像"部分卡住"。真机上 fps 正常说明帧时间没问题，不需要这个预算。
  local threads = self.threads
  local now = now_ms()
  local i = 1
  while i <= #threads do
    local th = threads[i]
    if th.done then
      table.remove(threads, i)
      -- 官方 restart_when_finished（self_listen / self_listen_with_param / when）：
      -- 这类监听线程**跑完就重启**（原版是 reset 解释器；这里等价地重开一份）。
      if Sched.block_restart_when_finished(th.hat) and th.owner and not th.owner.deleted
         and not th.stopped and (th.epoch or 0) == (self.restart_epoch or 0)
         and th.reg and self:hat_active(th.reg) then
        self:spawn(th.owner, th.hat, th.args, th.body, th.event, th.reg, th.execution_self)
      end
    else
      if th.wait_for then self:check_join(th) end
      if (not th.done) and (not th.wait_for) and (th.lock_count or 0) == 0
         and now >= th.blocked_until then
        th.warp_iters = 0
        th.frame_start = now
        self:resume(th)
      end
      if th.done then table.remove(threads, i) else i = i + 1 end
    end
  end

  -- 4. 帧末：应用克隆体增删（官方同样有延迟帧，见 docs/04 §5 待实测项）
  self:apply_deferred()
  -- 官方 onAfterUpdate：mouse_up 状态回 ""、isMouseClickTarget 每帧清空
  require("rt.host.taps").end_frame(host)
  host:end_frame(dt)
end

function Sched:apply_deferred()
  local game = self.game
  for i = 1, #self.pending_add do
    local e = self.pending_add[i]
    if not e.deleted then
      game.entities[#game.entities + 1] = e
    elseif game.bubbles then
      game.bubbles[e] = nil
    end
  end
  for i = 1, #self.pending_del do
    local e = self.pending_del[i]
    for j = #game.entities, 1, -1 do
      if game.entities[j] == e then table.remove(game.entities, j) end
    end
  end
  for i = #self.pending_add, 1, -1 do self.pending_add[i] = nil end
  for i = #self.pending_del, 1, -1 do self.pending_del[i] = nil end
  for _, item in ipairs(self._pending_clone_start or {}) do
    if not item.c.deleted then
      self:spawn(item.c, "start_as_a_mirror", item.s.args, item.s.body, {})
    end
  end
  self._pending_clone_start = {}
end

-- 创建克隆体（mirror 积木）。延迟到帧末生效 → 克隆脚本下一帧开始
function Sched:mirror(src)
  local root = src
  while root and root.is_clone and root.parent do root = root.parent end
  if not root or root.clones >= C.max_clones_per_entity then return nil end
  -- 身份/编号属于 root；初始状态（坐标、造型、特效等）来自当前执行实体 src。
  local source = src
  local c = source:clone_self()
  if source ~= root then
    c.parent = root
    root.clone_seq = (root.clone_seq or 0) + 1
    c.clone_index = root.clone_seq
    c.id = root.id .. "#" .. c.clone_index
    c.clone_seq = 0
    c.clones = 0
  end
  root.clones = root.clones + 1
  src = root
  self.pending_add[#self.pending_add + 1] = c
  -- clone 的 start_as_a_mirror 必须在实体加入后再启动，否则首帧不在 entities 中。
  -- 克隆体继承本体的 start_as_a_mirror；对克隆体再克隆时沿 parent 找到本体。
  self._pending_clone_start = self._pending_clone_start or {}
  local base = src
  while base and base.is_clone and base.parent do base = base.parent end
  local hats = self.hats["start_as_a_mirror"]
  if hats then
    for i = 1, #hats do
      local s = hats[i]
      if s.owner == base or s.owner == src then
        self._pending_clone_start[#self._pending_clone_start + 1] = { c = c, s = s }
      end
    end
  end
  return c
end

function Sched:dispose_clone(e)
  if not e.is_clone or e.deleted then return end
  e.deleted = true
  local g = self.game
  if g then
    if g.bubbles then g.bubbles[e] = nil end
    if g.stage_dialog and g.stage_dialog.owner == e then g.stage_dialog = nil end
    if g.translate_dialog and g.translate_dialog.owner == e then g.translate_dialog = nil end
  end
  if e.parent then e.parent.clones = math.max(0, e.parent.clones - 1) end
  local threads = self.threads
  for i = #threads, 1, -1 do
    if threads[i].owner == e then self:finish(threads[i]) end
  end
  self.pending_del[#self.pending_del + 1] = e
end

----------------------------------------------------------------------
-- 游戏（作品实例）
----------------------------------------------------------------------
local Game = {}
Game.__index = Game
core.Game = Game

function Game.new(h)
  local g = setmetatable({}, Game)
  g.host = h
  g.entities = {}
  g.vars = {}          -- 全局变量 key -> value
  g.var_names = {}     -- key -> 显示名
  g.var_meta = {}      -- variable/list monitor metadata
  g.list_meta = {}
  g.var_dirty = {}
  g.lists = {}
  g.screens = {}
  g.bubbles = {}
  g.dialog_queue = {}
  g.cur_screen = nil
  g.stage_w, g.stage_h = 562, 900
  g.timer = 0
  g.timer_visible = false
  g.timer_pos = { x = 720, y = 12 }
  -- 官方 run() 设 timer_block_date=now（crc_libs:1 byte 995434）：计时器从开局就在跑。
  g.timer_running = false
  g.sched = Sched.new(g)
  g.frame = 0
  g.on_error = nil
  return g
end

function Game:add(e)
  self.entities[#self.entities + 1] = e
  e.spawn_x, e.spawn_y, e.spawn_dir = e.x, e.y, e.dir
  e.spawn_scale_x, e.spawn_scale_y = e.scale_x or 1, e.scale_y or 1
  e.spawn_style_index = e.style_index
  e.spawn_visible = e.visible
  e.spawn_alpha = e.alpha
  e.spawn_draggable = e.draggable
  e.spawn_edge_bounce = e.edge_bounce
  e.spawn_layer = e.layer
  e.spawn_rotation_style = e.rotation_style
  e.spawn_rotation_type = e.rotation_type
  e.spawn_effects = {}
  for k, v in pairs(e.effects or {}) do e.spawn_effects[k] = v end
  return e
end

-- 屏幕坐标 → 舞台坐标（Love2D 宿主有精确实现；无头按"窗口=舞台 1:1"换算）
function Game:screen_to_world(sx, sy)
  local h = self.host
  if h and h.screen_to_world then return h:screen_to_world(sx, sy, self) end
  return sx - self.stage_w / 2, self.stage_h / 2 - sy
end

-- 指针当前所在的舞台坐标
function Game:pointer_world()
  local h = self.host
  if h.pointer_valid == false then
    return 0 / 0, 0 / 0
  end
  return self:screen_to_world(h.mouse_x or 0, h.mouse_y or 0)
end

-- 按 **UUID** 找角色（官方一律用 id；跨屏幕允许同名角色，所以绝不能只按名字找）
-- 兜底：名字匹配**只允许命中"当前屏幕"里的角色**，避免取到别的屏幕的同名角色
function Game:find(id)
  if id == nil then return nil end
  id = tostring(id)
  -- 实体 ID 映射缓存：300 克隆场景下避免每个 bump_into 线性扫 300 个实体。
  if not self._id_map or not self._name_map
     or self._id_map_n ~= #self.entities or self._id_map_cur ~= self.cur_screen then
    self._id_map, self._name_map = {}, {}
    local cur = self.cur_screen
    for i = 1, #self.entities do
      local e = self.entities[i]
      if e.id ~= nil then self._id_map[tostring(e.id)] = e end
      if e.name ~= nil and e.scene_ok ~= false and (cur == nil or e.scene == nil or e.scene == cur) then
        local k = tostring(e.name)
        if self._name_map[k] == nil then self._name_map[k] = e end
      end
    end
    self._id_map_n = #self.entities
    self._id_map_cur = cur
  end
  local e = self._id_map[id]
  if e then return e end
  return self._name_map[id]
end

-- 变量作用域：脚本(线程) > 实体 > 全局（官方 get_variable(name, entity, interpreter)）
function Game:scope_of(key, entity, thread)
  if thread and thread.script_vars[key] ~= nil then return thread.script_vars end
  if entity and entity.vars and entity.vars[key] ~= nil then return entity.vars end
  if entity and entity.vars == nil and not self._warned_scope then
    self._warned_scope = true
    print(("[debug] scope_of 收到非实体对象 kind=%s name=%s key=%s\n%s")
      :format(tostring(entity.kind), tostring(entity.name), tostring(key), debug.traceback("", 2)))
  end
  return self.vars
end

-- 某本体的存活克隆列表（按 clone_seq/clones 版本缓存）。
-- fire_bump / 广播 / 点击执行主体 每帧都要找克隆，原来每个 hat 都全量扫 entities。
function Game:clones_of(owner)
  if not owner then return {} end
  -- 版本必须含实体总数：mirror 会先加 clone_seq/clones，延迟到帧末才进 entities；
  -- 否则缓存的列表会漏掉刚创建的克隆。
  local ver = tostring(owner.clone_seq or 0) .. ":" .. tostring(owner.clones or 0) .. ":" .. #self.entities
  self._clone_cache = self._clone_cache or {}
  local c = self._clone_cache[owner]
  if c and c.ver == ver then return c.list end
  local list = {}
  local ents = self.entities
  for i = 1, #ents do
    local e = ents[i]
    if e.is_clone and e.parent == owner and not e.deleted then list[#list + 1] = e end
  end
  self._clone_cache[owner] = { ver = ver, list = list }
  return list
end

function Game:get_var(key, entity, thread)
  key = self:resolve_var_key(key)
  local scope = self:scope_of(key, entity, thread)
  local v = scope[key]
  if v == nil then return 0 end
  return v
end

function Game:set_var(key, value, entity, thread, create_in)
  key = self:resolve_var_key(key)
  local scope = self:scope_of(key, entity, thread)
  if scope[key] == nil and create_in == "script" and thread then scope = thread.script_vars end
  scope[key] = value
  return value
end

function Game:get_list(key, entity, thread)
  key = self:resolve_var_key(key)
  if key == nil then return {} end
  -- ★ 列表的**唯一归宿**是 game.lists（按 uuid）。之前这里只看 vars 作用域，
  --   于是 declare_lists 声明的 26 项初始数据被当成"未定义"→新建空表覆盖，
  --   作品读 列表_bpm 永远拿到空串（变量_bpm 因此恒为 0 → 60/0 → inf）。
  local scope = self:scope_of(key, entity, thread)
  local l = scope[key]
  if type(l) ~= "table" then
    l = {}
    scope[key] = l
  end
  return l
end

-- 作品初始变量：{ {id=, name=, value=, scope="global"|"actor"|"script"} }
-- 列表：和变量一样**按 uuid** 存，名字只做展示
function Game:diag_list_state()
  if not self.diag_lists then return "" end
  local out = {}
  for id in pairs(self.diag_lists) do
    local l = self.vars and self.vars[id]
    out[#out + 1] = tostring(id):sub(1, 8) .. "=" .. tostring(type(l) == "table" and #l or "nil")
  end
  table.sort(out)
  return table.concat(out, ",")
end


function Game:declare_vars(list)
  self.var_initial = {}
  self.script_var_alias = {} -- 名字 → 变量 id（脚本变量）
  for i = 1, #(list or {}) do
    local v = list[i]
    -- 运行值、初始快照、编译器 default 三者必须各自独立。
    local initial = copy_value(v.value ~= nil and v.value or 0)
    self.vars[v.id] = copy_value(initial)
    self.var_names[v.id] = v.name or v.id
    local typ = tostring(v.type or "variable")
    local pos = v.position or {}
    self.var_meta[v.id] = {
      id = v.id, name = v.name or v.id, type = typ,
      style = tostring(v.style or "default"), scale = tonumber(v.scale) or 1,
      visible = (v.visible ~= false), position = { x = tonumber(pos.x) or 0, y = tonumber(pos.y) or 0 },
      is_global = v.is_global and true or false,
      current_entity_id = v.current_entity_id or "",
      entity_name = v.entity_name or "",
      cv_id = v.cv_id or "",
      order = tonumber(v.order) or 0,
    }
    if typ == "list" then self.list_meta[v.id] = self.var_meta[v.id] end
    local snap = copy_value(v)
    snap.value = initial
    self.var_initial[#self.var_initial + 1] = snap
    local nm = tostring(v.id):match('"name"%s*:%s*"([^"]+)"')
    if nm then self.script_var_alias[nm] = v.id end
  end
end

function Game:init_entity_vars()
  for i = 1, #(self.var_initial or {}) do
    local v = self.var_initial[i]
    if v.is_global == false and v.current_entity_id and v.current_entity_id ~= "" then
      local e = self:find(v.current_entity_id)
      if not e and v.entity_name and v.entity_name ~= "" then
        for _, c in ipairs(self.entities) do
          if c.name == v.entity_name and not c.is_clone then e = c break end
        end
      end
      if e and e.kind ~= "screen" then
        e.vars = e.vars or {}
        e.lists = e.lists or {}
        e.vars[v.id] = copy_value(v.value ~= nil and v.value or 0)
        if type(e.vars[v.id]) == "table" then e.lists[v.id] = e.vars[v.id] end
      end
    end
  end
end

function Game:reset_entity_vars()
  for _, e in ipairs(self.entities) do
    if e.kind ~= "screen" and not e.is_clone then
      e.vars, e.lists = {}, {}
    end
  end
  self:init_entity_vars()
end


-- 变量 key 归一化：
--   * 文本代码转出来的脚本变量 id 形如 {"type":"NEKO_SCRIPT_VARIABLE_TYPE-…","name":"char"}
--     → 统一收敛成名字 "char"（否则写入用 id、读取用名字，两边对不上）
--   * 作品里声明的别名表仍作为名字 → id 的兜底
function Game:resolve_var_key(key)
  if key == nil then return nil end
  if type(key) ~= "string" then
    -- JS 的属性名一律是字符串（NaN → "NaN"、数字 → "123"、true → "true"）；
    -- 不转换的话 Lua 会直接报 table index is NaN。
    -- 表/函数等对象键统一映射成 "[object Object]"（JS 的 String(obj) 也是如此）——
    -- 千万不要在这里递归展开整张表：循环结构会爆栈，而且也没意义。
    if type(key) == "table" then return "[object Object]" end
    return Values.str(key)
  end
  -- 快路径：普通变量键（UUID/名字）不以 "{" 开头，不必跑脚本变量 JSON 的正则
  if key:byte(1) ~= 123 then -- '{'
    local alias = self.script_var_alias and self.script_var_alias[key]
    return alias or key
  end
  self._var_key_cache = self._var_key_cache or {}
  local hit = self._var_key_cache[key]
  if hit ~= nil then return hit end
  local nm = key:match('"name"%s*:%s*"([^"]+)"')
  local out = nm
  if not out and self.script_var_alias and self.script_var_alias[key] then
    out = self.script_var_alias[key]
  end
  out = out or key
  self._var_key_cache[key] = out
  return out
end

function Game:var_meta_for(key)
  key = self:resolve_var_key(key)
  return self.var_meta[key] or self.list_meta[key]
end

function Game:reset_vars()
  self.vars = {}
  self.lists = {}
  self.var_dirty = {}
  for i = 1, #(self.var_initial or {}) do
    local v = self.var_initial[i]
    self.vars[v.id] = copy_value(v.value ~= nil and v.value or 0)
  end
end

function Game:describe(key)
  return self.var_names[key] or tostring(key)
end

-- 当前屏幕切换（M1：仅停止本屏脚本 + 换背景；完整切屏特效见 M4）
function Game:switch_screen(id)
  local s = self.screens[id]
  if not s then return false end
  self.cur_screen = id
  return true
end

function Game:screen_name_to_id(name)
  for _, e in pairs(self.screens or {}) do
    if tostring(e.screen_name or e.name) == tostring(name) or tostring(e.name) == tostring(name) then return e.id end
  end
  return nil
end

function Game:resolve_screen(v)
  if v == nil then return nil end
  if type(v) == "number" then
    local i = math.floor(v + 0.5)
    return self.screen_order and self.screen_order[i] or nil
  end
  local s = tostring(v)
  if s == "next" or s == "prev" then
    local order = self.screen_order or {}
    local cur = self.cur_screen
    local idx
    for i = 1, #order do if order[i] == cur then idx = i end end
    if not idx then return cur end
    if s == "next" then return order[math.min(#order, idx + 1)] or cur end
    return order[math.max(1, idx - 1)] or cur
  end
  if self.screens[s] then return s end
  return self:screen_name_to_id(s)
end

function Game:step(dt)
  self.frame = self.frame + 1
  if self.transition then
    self.transition.elapsed = (self.transition.elapsed or 0) + dt
    if self.transition.elapsed >= (self.transition.duration or 0.35) then
      self.transition = nil
    end
  end
  if self.timer_running then self.timer = self.timer + dt end
  local E = require("rt.impl.effects")
  if E.update then E.update(self, dt) end
  self.sched:step(dt)
end

core.now_ms = function() return now_ms() end

return core
