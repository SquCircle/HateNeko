-- 游戏实例：变量/列表作用域、屏幕、指针、每帧推进
-- （原 rt/core.lua Game 段；2026-10-24 拆分）

local Values = require("rt.values")
local S = require("rt.core.state")
local Sched = require("rt.core.sched").Sched
local copy_value = S.copy_value

local Game = {}
Game.__index = Game

-- 官方 get_timer/reset_timer 语义：基于墙钟的秒数，和可见计时器状态无关。
function Game:now_ms()
  local h = self.host
  if h and h.now_ms then return h:now_ms() end
  if love and love.timer and love.timer.getTime then return love.timer.getTime() * 1000 end
  return os.clock() * 1000
end

function Game:reset_timer_block()
  self.timer_block_ms = self:now_ms()
end

function Game:get_timer_elapsed_s()
  if not self.timer_block_ms then return 0 end
  return (self:now_ms() - self.timer_block_ms) / 1000
end

-- 舞台计时器（官方 TheatreStore）：秒、两位小数；只在运行中累加。
function Game:stage_timer_value()
  local ms = self.timer_base_ms or 0
  if self.timer_running and self.timer_started_at then
    ms = ms + (self:now_ms() - self.timer_started_at)
  end
  return math.floor(ms / 10 + 0.5) / 100
end

function Game:stage_timer_start()
  if self.timer_running then return end
  self.timer_started_at = self:now_ms()
  self.timer_running = true
end

function Game:stage_timer_stop()
  if not self.timer_running then return end
  self.timer_base_ms = (self.timer_base_ms or 0)
    + (self:now_ms() - (self.timer_started_at or self:now_ms()))
  self.timer_started_at = nil
  self.timer_running = false
  self.timer = self:stage_timer_value()
end

function Game:stage_timer_reset()
  self.timer_base_ms = 0
  self.timer_started_at = self:now_ms()
  self.timer_running = true
  self.timer = 0
end

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
  g.timer_block_ms = nil -- 官方 timer_block_date：get_timer 的墙钟起点
  g.timer_visible = false
  g.timer_pos = { x = 720, y = 12 }
  -- 官方 run() 设 timer_block_date=now（crc_libs:1 byte 995434）：计时器从开局就在跑。
  g.timer_running = false
  -- 舞台计时器（官方 TheatreStore.timerValue，player.main:2474611 模块 26537）：
  -- 内部毫秒、对外秒且两位小数；只在「执行计时器(开始/重置)」后才走，停止时结算。
  -- 与 timer_block_ms（get_timer 的墙钟）是**两个独立计时器**。
  g.timer_base_ms = 0
  g.timer_started_at = nil
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
  -- 官方舞台计时器是**墙钟**（Date.now 差值），不是 dt 累加：掉帧/后台回来都不会漂
  if self.timer_running then self.timer = self:stage_timer_value() end
  local E = require("rt.impl.effects")
  if E.update then E.update(self, dt) end
  self.sched:step(dt)
end

return { Game = Game }
