-- rt：共享库入口。组装原语表 rt.f / 注册 hat / 加载作品 / 每帧推进
--
-- 生成代码的调用约定（见 docs/04 §2.5）：
--   f[<块类型>](self, args, th)
--     self = 当前对象（线程 owner：角色/克隆体/屏幕），由调用方从 th 取
--     args = 规范化后的参数表（fields + 值型 inputs，键名对齐官方 domain params）
--     th   = 线程（= 官方 interpreter）：阻塞、warp 预算、脚本变量、参数栈
--   rt.on(owner, hatType, args, body) 注册 hat 脚本；body(th, self) 在触发时以新线程运行
local core = require("rt.core")
local V = require("rt.values")

local rt = {}
rt.core = core
rt.values = V
rt.SIG = core.SIG
rt.C = core.C

----------------------------------------------------------------------
-- 原语实现汇总
----------------------------------------------------------------------
-- 原语注册表（阶段 4）：模块按顺序登记，同名不同实现默认硬失败（见 rt/registry.lua）。
local registry = require("rt.registry")
local _aliases = require("rt.impl.aliases")
local alias_mod = {}
for k, v in pairs(_aliases) do
  if k ~= "install" then alias_mod[k] = v end
end
local _modules = {
  { name = "rt.impl.event", mod = require("rt.impl.event") },
  { name = "rt.impl.control", mod = require("rt.impl.control") },
  -- 运动/外观/画笔/公共工具（原 rt.impl.motion_looks，2026-10-24 按域拆分）
  { name = "rt.impl.motion", mod = require("rt.impl.motion") },
  { name = "rt.impl.looks", mod = require("rt.impl.looks") },
  { name = "rt.impl.pen", mod = require("rt.impl.pen") },
  { name = "rt.impl.effects", mod = require("rt.impl.effects") },
  { name = "rt.impl.data", mod = require("rt.impl.data") },
  -- 运算/文本/侦测/时间/舞台（原 rt.impl.op_sensing，2026-10-24 按域拆分）
  { name = "rt.impl.math", mod = require("rt.impl.math") },
  { name = "rt.impl.text", mod = require("rt.impl.text") },
  { name = "rt.impl.sensing", mod = require("rt.impl.sensing") },
  { name = "rt.impl.time", mod = require("rt.impl.time") },
  { name = "rt.impl.screen", mod = require("rt.impl.screen") },
  { name = "rt.impl.audio", mod = require("rt.impl.audio") },
  { name = "rt.impl.ui", mod = require("rt.impl.ui") },
  { name = "rt.impl.aliases", mod = alias_mod },
}
local impl, _reg = registry.build(_modules)
-- 旧版命名别名（lists_* / math_single / random …）→ 指向同一实现
_aliases.install(impl, impl)
if _aliases.ALIAS then
  for old in pairs(_aliases.ALIAS) do
    if impl[old] and not _reg.defs[old] then
      _reg.defs[old] = { { module = "rt.impl.aliases(alias)", fn = impl[old] } }
      _reg.providers[old] = "rt.impl.aliases(alias)"
    end
  end
end
if #_reg.conflicts > 0 then
  error("原语注册冲突（同名不同实现，未在 rt/registry allow 中声明）：" ..
        table.concat(_reg.conflicts, "; "), 2)
end
rt.registry = _reg
local ok_schema, schema = pcall(require, "rt.schema")
rt.schema = ok_schema and schema or nil

-- 编译期未知块（新版本块 / 未实现块）的显式落点
impl.unknown = function(self, args, th)
  local t = tostring((args and (args.type or args.block_type)) or "?")
  rt.stats.missing[t] = (rt.stats.missing[t] or 0) + 1
  return 0
end

rt.impl = impl

-- 官方 runtime 名 → 块类型 的别名（方便对照移植官方 domain 实现）
rt.aliases = {
  repeat_for_range = "traverse_number",
  once = "warp",
  clone = "mirror",
  delete_this_clone = "dispose_clone",
  break_loop = "break",
  tell_and_wait = "sync_tell",
  broadcast = "self_broadcast",
  broadcast_with_content = "self_broadcast_with_param",
  broadcast_and_wait = "self_broadcast_and_wait",
  is_broadcast_received = "received_broadcast",
  get_clone_count = "get_clone_num",
  get_clone_property = "get_clone_index_property",
  on_collision_with_sprite = "on_bump_actor",
  on_mouse_event = "sprite_on_tap",
  on_keyboard_event = "on_keydown",
  on_broadcast_received = "self_listen",
  on_broadcast_received_with_content = "self_listen_with_param",
  on_clone_start = "start_as_a_mirror",
  on_program_start = "on_running_group_activated",
  on_condition_met = "when",
  get_target_sprite_property = "on_bump_actor_value",
  get_rotation = "coordinate_of_sprite",
  script_variables_get = "script_variables_value",
}

rt.stats = { missing = {} }
rt.debug = nil      -- 打开后：未实现原语直接报错（开发期）
rt.hook = nil       -- function(name, self, args, th)：调试/单步/性能钩子

rt.noop = function() return nil end

-- 构建 rt.f（一次；不在每次调用里包闭包）
-- 参数键归一化已废弃（生成代码统一走 spec 的小写键；保留此说明避免误用）。

function rt.build_f()
  local out = {}
  rt.stats.missing_warned = {}
  for name, fn in pairs(impl) do out[name] = fn end
  if rt.debug and rt.hook then
    for name in pairs(out) do
      local fn = out[name]
      out[name] = function(self, args, th)
        rt.hook(name, self, args, th)
        return fn(self, args, th)
      end
    end
  end
  for alias, real in pairs(rt.aliases) do
    if out[real] and not out[alias] then out[alias] = out[real] end
  end
  -- 缺失键：RELEASE 计数 + no-op；DEBUG 直接报错
  -- 正式包也不能完全静默：每个名字**只 warn 一次**（作品可能每帧命中，不能刷屏）。
  setmetatable(out, {
    __index = function(_, k)
      rt.stats.missing[k] = (rt.stats.missing[k] or 0) + 1
      if rt.debug then error("未实现的原语: " .. tostring(k), 2) end
      local warned = rt.stats.missing_warned
      if not warned then warned = {} rt.stats.missing_warned = warned end
      if not warned[k] then
        warned[k] = true
        if rt.host and rt.host.log then
          pcall(rt.host.log, rt.host,
            ("[rt] 未实现的原语 %s：按 no-op(nil) 降级（编译期清单见 M.unsupported_blocks / 「未知块」）")
              :format(tostring(k)), "warn")
        end
      end
      return rt.noop
    end,
  })
  rt.f = out
end

function rt.missing_report()
  local names = {}
  for k in pairs(rt.stats.missing) do names[#names + 1] = k end
  table.sort(names)
  return names
end

----------------------------------------------------------------------
-- 宿主（时间/绘制/音频/输入）
----------------------------------------------------------------------
function rt.set_host(h)
  rt.host = h
  core.set_host(h)
end

----------------------------------------------------------------------
-- 作品加载
----------------------------------------------------------------------
-- work = { stage_w, stage_h, screens={...}, actors={...}, vars={...}, register=function(rt) ... end }
-- 构建指纹（tools/gen_build.py 生成）：启动时打印，避免"跑的是哪份构建"说不清
rt.build = (function()
  local ok, b = pcall(require, "rt.build")
  if ok and type(b) == "table" then return b end
  return { id = "dev", time = "?", files = 0 }
end)()

function rt.load(work, host)
  if host then rt.set_host(host) end
  if not rt.host then error("rt.load: 需要先 set_host") end
  rt.host:log(("knplayer 运行时构建 %s @ %s"):format(tostring(rt.build.id), tostring(rt.build.time)))
  rt.build_f()
  rt.stats.missing = {}

  local game = core.Game.new(rt.host)
  game.stage_w = work.stage_w or 562
  game.stage_h = work.stage_h or 900
  game.work = work
  game.assets = work.assets or {}          -- styleId → {file, url, center, adaption, styleType}
  game.audios = work.audios or {}          -- audioId → {file, url, name}
  game.assets_dir = work.assets_dir or "works"
  if work.timer_pos then game.timer_pos = work.timer_pos end
  if work.uses_timer and not work.timer_hidden_default then
    game.timer_visible = true
  else
    game.timer_visible = false
  end
  game.timer_running = work.uses_timer == true
  -- 舞台计时器按墙钟走：开局就在跑的作品（uses_timer）把起点设为现在
  if game.timer_running then game.timer_started_at = game:now_ms() end
  -- 场景门交给 rt/scene 统一裁决（这里不再自己改 visible/scene_ok）
  rt.game = game
  -- ★ 初始屏幕 = M.cur_scene（= 场景排序第一屏）；场景实体创建顺序是 pairs（无序），不能依赖
  if work.cur_scene and work.cur_scene ~= "" then game.cur_screen = work.cur_scene end
  game.initial_screen = game.cur_screen
  game.uses_timer = work.uses_timer == true
  game.initial_timer_pos = work.timer_pos and { x = work.timer_pos.x, y = work.timer_pos.y } or { x = 720, y = 12 }
  game.diag_lists = work.diag_lists
  game:declare_vars(work.vars)

  local ents = {}
  for i = 1, #(work.screens or {}) do
    local e = rt.screen(work.screens[i])
    ents[e.id] = e
  end
  for i = 1, #(work.actors or {}) do
    local e = rt.actor(work.actors[i])
    ents[e.id] = e
  end
  game:init_entity_vars()
  game.screen_order = {}
  for i = 1, #(work.screens or {}) do
    local sid = work.screens[i].id
    if sid then game.screen_order[#game.screen_order + 1] = sid end
  end
  if work.register then work.register(rt, game, ents) end

  -- 性能：只有用到「碰到颜色」的作品才需要每帧复制背景（H:draw 的 _capture_bg）
  game.uses_color_touch = false
  for i = 1, #(work.requires or {}) do
    if work.requires[i] == "bump_into_color" then game.uses_color_touch = true break end
  end
  -- 加载期自检：作品声明的需要原语是否都有实现（编译产物里的 M.requires）
  if work.requires then
    local missing = {}
    for i = 1, #work.requires do
      local name = work.requires[i]
      if rawget(rt.f, name) == nil then missing[#missing + 1] = name end
    end
    if #missing > 0 then
      game.missing_primitives = missing
      rt.host:log(("[rt] 作品需要的 %d 个原语尚未实现，将按未实现块降级：%s")
        :format(#missing, table.concat(missing, ", ")), "warn")
    end
  end
  return game
end

function rt.actor(spec)
  spec = spec or {}
  spec.kind = "actor"
  return rt.game:add(core.Entity.new(spec))
end

function rt.screen(spec)
  spec = spec or {}
  spec.kind = "screen"
  local e = rt.game:add(core.Entity.new(spec))
  e.screen_name = spec.screenName or spec.name or e.id
  rt.game.screens[e.id] = e
  -- 初始屏幕由 rt.load 按 M.cur_scene（场景排序第一屏）显式设定，这里不抢
  return e
end

-- hat 名归一：既接受块类型（on_running_group_activated），也接受官方 runtime 名（on_program_start）
rt.hat_alias = {
  on_program_start = "on_running_group_activated",
  on_mouse_event = "sprite_on_tap",
  on_keyboard_event = "on_keydown",
  on_broadcast_received = "self_listen",
  on_broadcast_received_with_content = "self_listen_with_param",
  on_clone_start = "start_as_a_mirror",
  on_condition_met = "when",
  on_collision_with_sprite = "on_bump_actor",
  on_screen_swipe = "on_swipe",
}

-- 注册 hat 脚本。args.cond（若为函数）= when 类 hat 的每帧条件
-- 只有注册了"指针类"hat 的角色才算可交互（对应官方 PIXI 的 interactive）
-- 官方 HAT_BLOCKS：start_on_click / start_on_click_2 是**启动块**（播放时启动、跨屏存活），
-- 它们**不是点击事件**（在播放开始时启动一次）。
local POINTER_HATS = { sprite_on_tap = true, on_tap = true, sprite_on_click = true }

function rt.on(owner, hat, args, body)
  hat = rt.hat_alias[hat] or hat
  -- 官方：**每个角色都是 interactive**（源码里 actor 构造时 n.interactive = true），
  -- 命中形状用角色自己的 is_touching。所以这里不再按 hat 类型挑人。
  if false and POINTER_HATS[hat] then
    -- 「当 <角色X> 被点击」是给**被点的那个角色**注册事件（官方按目标注册），
    -- 所以可交互的应是 hat 的目标角色：--self/空 = 自己；否则按 UUID 找目标。
    local tgt = args and args.sprite
    local e = owner
    if tgt ~= nil and tgt ~= "--self" and tgt ~= "--screen" then
      local other = rt.game and rt.game:find(tgt)
      if other then e = other end
    end
    if e then e.interactive = true end
  end
  if owner and owner.kind == "actor" then owner.interactive = true end -- 官方语义：角色恒 interactive
  local s = rt.game.sched:register(owner, hat, args or {}, body)
  if type(args) == "table" and type(args.cond) == "function" then s.cond = args.cond end
  return s
end

-- NaN 看门狗（仅调试）：在每个原语调用前后检查调用者坐标，第一次变成 NaN 的那次就是元凶
function rt.install_nan_watchdog()
  local f = rt.f
  local reported = {}
  for name, fn in pairs(f) do
    if type(fn) == "function" and not tostring(name):find("^__") then
      f[name] = function(self, args, th)
        local before
        if self and type(self.x) == "number" then before = { self.x, self.y } end
        local r = fn(self, args, th)
        if self and type(self.x) == "number" then
          local bad = (self.x ~= self.x) or (self.y ~= self.y)
          local was_bad = before and ((before[1] ~= before[1]) or (before[2] ~= before[2]))
          local key = tostring(name) .. "/" .. tostring(self.name)
          if bad and not was_bad and not reported[key] then
            reported[key] = true
            local hat = th and th.hat or "?"
            rt.game.host:log(("[NaN] 原语 %s 把角色 %s 的坐标变成 NaN（hat=%s） args=%s")
              :format(name, tostring(self.name), tostring(hat),
                (function()
                  local t = {}
                  for k, v in pairs(args or {}) do
                    if type(v) == "number" and v ~= v then t[#t + 1] = k .. "=NaN" end
                  end
                  return table.concat(t, ",")
                end)()), "warn")
          end
        end
        return r
      end
    end
  end
end

function rt.start()
  rt.game.started = true
  -- 官方 run()：timer_block_date = now（get_timer 从开局起算）
  rt.game:reset_timer_block()   -- 解除加载期封锁（此后 step 才会派发事件/推进线程）
  -- 官方语义（HAT_BLOCKS + block_metadata）：
  --   on_running_group_activated：带 group_id、在 finish_out_of_run_group 表里
  --     → 只在"进入某屏幕时"启动该屏幕的脚本（切屏时旧屏的被销毁）
  --   start_on_click / start_on_click_2：不带 group_id、只是普通 runnable
  --     → **作品开始播放时启动一次**，且跨切屏存活
  local started = rt.game.sched:fire_green_flag(rt.game.cur_screen)
  local more = rt.game.sched:fire("start_on_click", {})
  local more2 = rt.game.sched:fire("start_on_click_2", {})
  return started
end

function rt.step(dt)
  local host = rt.host
  if host.take_events then
    local pend = host:take_events()
    if pend then
      local q = rt.game.sched.input_queue
      for i = 1, #pend do q[#q + 1] = pend[i] end
    end
  end
  rt.game:step(dt or (1 / 60))
end

function rt.broadcast(message, param)
  return rt.game.sched:broadcast(message, param, nil)
end

-- 声明/初始化一个变量，返回可直接用于 args.variable 的 key
function rt.var(name, value)
  local key = "v:" .. tostring(name)
  rt.game.var_names[key] = tostring(name)
  rt.game.vars[key] = value or 0
  return key
end

function rt.list(name)
  local key = "l:" .. tostring(name)
  rt.game.lists[key] = {}
  return key
end

return rt
