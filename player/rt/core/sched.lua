-- 调度器：hat 派发 / 线程推进 / 广播 / 克隆 / 切屏门
-- （原 rt/core.lua Sched 段；2026-10-24 拆分）

local Values = require("rt.values")
local S = require("rt.core.state")
local Thread = require("rt.core.thread").Thread
local SIG, C, now_ms, warn = S.SIG, S.C, S.now_ms, S.warn

local Sched = {}
Sched.__index = Sched

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

-- 块所属屏幕（官方 group_id 的等价物）。
--   屏幕实体 → 自己的 id；角色 → 它所属屏幕；**没有屏幕信息的角色 → nil（永不冻结）**。
-- 之前用 `owner.id` 兜底会让"无 scene 的角色"拿一个永远不等于 cur_screen 的 id，
-- 新加的冻结判定会把它们的线程全冻住（测试夹具里很常见）。
local function group_of(owner, hat)
  if not owner or owner.is_global then return nil end
  if Sched.OFFICIAL_NO_GROUP_ID[hat] then return nil end
  if owner.scene then return owner.scene end
  if owner.scenes and owner.scenes[1] then return owner.scenes[1] end
  if owner.kind == "screen" then return owner.id end
  return nil
end

function Sched:register(owner, hat, args, body)
  local list = self.hats[hat]
  if not list then list = {} self.hats[hat] = list end
  -- group_id = 块所属屏幕。官方编译器给每个块打 group_id，**唯独 start_on_click 不打**；
  -- 全局角色在官方是"每屏一份实例"，这里也不做冻结（Nil → 永不算跑出运行组）。
  local script = { owner = owner, hat = hat, args = args or {}, body = body,
    group_id = group_of(owner, hat) }
  list[#list + 1] = script
  return script
end

function Sched:spawn(owner, hat, args, body, event, reg, exec_self)
  local t = Thread.new(self, owner, hat, args, body, event, exec_self)
  t.reg = reg
  t.epoch = self.restart_epoch or 0
  t.group_id = reg and reg.group_id or group_of(owner, hat)
  self.threads[#self.threads + 1] = t
  return t
end

-- 官方 step_code（player.main:4829705）的判据：
--   跑出运行组（group_id 有值且 ≠ 当前屏幕）时，只有 finish_out_of_run_group 的块被销毁，
--   其余线程**冻结**（不 step、不删；切回该屏幕会继续）。
function Sched:thread_in_running_group(t)
  local gid = t.group_id
  if gid == nil then return true end
  return gid == self.game.cur_screen
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

function Sched:find_live_listener(s, exec_self)
  for _, t in ipairs(self.threads) do
    if not t.done and t.reg == s and t.execution_self == exec_self then return t end
  end
  return nil
end

function Sched:has_live_listener(s, exec_self)
  return self:find_live_listener(s, exec_self) ~= nil
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
      and Values.js_boolean(s.cond(self:system_thread(), s.owner))
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
  -- 官方 broadcast 动作状态：`statefulness {default_value:"", automatic_transitions:"one_frame"}`
  -- （player.main:4652970），由 perform_automatic_state_transitions 在**每帧开始**清空
  -- （player.main:4639096）。`收到广播(...)` 读的就是这个状态，不是线程 event。
  self.game.bcast_state = self.game.bcast_state or {}
  if message ~= nil then self.game.bcast_state[tostring(message)] = true end
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
          local live = Sched.block_restart_when_finished(hat) and self:find_live_listener(s, e) or nil
          if live and not wait then
            -- restart_when_finished 的监听器正在运行时收到新广播：
            -- 不能丢弃（作品常用“广播给自己”分块续播），先挂 latest pending，
            -- 等当前实例结束后由 step 的 restart_when_finished 分支用新 event 续跑。
            live._pending_broadcast = { event = event }
          elseif not live then
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
        warn("[proc] %s owner=%s hat=%s reg=%s exec=%s depth=%d frames=%d calls=%d returns=%d status=%s last=%s",
          err, tostring(th.owner and th.owner.name), tostring(th.hat),
          tostring(th.reg), tostring(th.execution_self and th.execution_self.name),
          #frames + 1, #frames, th._proc_calls or 0, th._proc_returns or 0,
          tostring(coroutine.status(th.co)), table.concat(names, ">"))
        warn("[proc] lists=%s", self.game:diag_list_state())
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
  local host = S.get_host()
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
  game:reset_timer_block()
  game.timer_visible = game.uses_timer == true and game.timer_hidden_default ~= true
  game.timer_running = game.uses_timer == true
  game.timer_base_ms = 0
  game.timer_started_at = game.timer_running and game:now_ms() or nil
  game.timer_pos = game.initial_timer_pos or game.timer_pos
  game._id_map, game._name_map = nil, nil
  game._clone_cache = nil

  -- 完整重启：重新触发绿旗/开始运行脚本。
  self:fire_green_flag(game.cur_screen)
  self:fire("start_on_click", {})
  self:fire("start_on_click_2", {})
end

-- restart_when_finished 监听器结束后：优先用运行期收到的 pending 广播续跑。
-- 注意：线程可能在本次 resume 中才结束（else 分支），两个结束点都必须调用此函数。
function Sched:restart_finished_listener(th)
  if not Sched.block_restart_when_finished(th.hat) then return end
  if not th.owner or th.owner.deleted or th.stopped then return end
  if (th.epoch or 0) ~= (self.restart_epoch or 0) then return end
  if not th.reg or not self:hat_active(th.reg) then return end
  if th.error then th._pending_broadcast = nil; return end
  local pending = th._pending_broadcast
  th._pending_broadcast = nil
  local nt
  if pending then
    -- 运行中收到的新广播：用新 event（含 param）续跑一次
    nt = self:spawn(th.owner, th.hat, th.args, th.body, pending.event, th.reg, th.execution_self)
  elseif th.hat == "when" then
    -- when 需要持续轮询条件；self_listen 结束后回到“空闲等待下一次广播”，
    -- 不能拿旧 event 直接重跑（会无限重复同一块）。
    nt = self:spawn(th.owner, th.hat, th.args, th.body, th.event, th.reg, th.execution_self)
  end
  if nt then
    -- 续播放到下一帧，避免一次 step 把整张图/整条广播链跑完导致长卡顿
    nt._defer_frame = (self.game and self.game.frame or 0) + 1
  end
end

function Sched:step(dt)
  self.dt = dt
  local game = self.game
  local host = S.get_host()
  host:begin_frame(dt)

  -- 加载期：资源还没就绪时**不派发任何事件、不推进任何线程**
  -- （官方也是等资源加载完才放行；否则当…/碰到…/按键这些 hat 会在加载期乱跑，
  --   依赖造型尺寸/内容的脚本就会表现错乱）
  if not game.started then return end

  -- 官方 perform_automatic_state_transitions（player.main:4639096）：每帧开始把
  -- one_frame 动作状态清空。`收到广播(...)` 读的就是 game.bcast_state。
  game.bcast_state = {}

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
    if th._defer_frame and th._defer_frame > (self.game and self.game.frame or 0) then
      i = i + 1
    elseif th.done then
      table.remove(threads, i)
      -- 官方 restart_when_finished（self_listen / self_listen_with_param / when）：
      -- 这类监听线程**跑完就重启**（原版是 reset 解释器；这里等价地重开一份）。
      self:restart_finished_listener(th)
    elseif not self:thread_in_running_group(th) then
      -- 跑出运行组：官方只销毁 finish_out_of_run_group（= 进入屏幕帽），其余冻结。
      if Sched.block_finish_out_of_run_group(th.hat) then
        self:finish(th)
        table.remove(threads, i)
      else
        i = i + 1
      end
    else
      if th.wait_for then self:check_join(th) end
      th._defer_frame = nil
      if (not th.done) and (not th.wait_for) and (th.lock_count or 0) == 0
         and now >= th.blocked_until then
        th.warp_iters = 0
        th.frame_start = now
        self:resume(th)
      end
      if th.done then
        table.remove(threads, i)
        self:restart_finished_listener(th)
      else
        i = i + 1
      end
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

return { Sched = Sched }
