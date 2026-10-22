-- 官方「特效」块语义：强调动画、入场/退场、文字特效、全局动画
-- 时间线数值/时长来自官方 stage_animation.cb05e28c.chunk.js；坐标单位 = 舞台像素。
local V = require("rt.values")
local core = require("rt.core")

local M = {}
local now_ms = function() return core.now_ms and core.now_ms() or 0 end

-- ---------------------------------------------------------------- easing
local function bezier(x1, y1, x2, y2)
  return function(t)
    local lo, hi = 0, 1
    for _ = 1, 18 do
      local mid = (lo + hi) / 2
      local x = 3 * (1-mid)*(1-mid)*mid*x1 + 3 * (1-mid)*mid*mid*x2 + mid*mid*mid
      if x < t then lo = mid else hi = mid end
    end
    local u = (lo + hi) / 2
    return 3 * (1-u)*(1-u)*u*y1 + 3 * (1-u)*u*u*y2 + u*u*u
  end
end
local E = {
  linear = function(t) return t end,
  default = bezier(0.33, 0, 0.67, 1),
  ease1 = bezier(0.45, 0, 0.9, 0.45),
  ease2 = bezier(0.2, 0, 0.2, 1),
  ease3 = bezier(0.4, 0, 0.95, 0.75),
  ease4 = bezier(0.07, 0.4, 0.62, 1),
  ease5 = bezier(0.5, 0, 0.84, 1),
  ease6 = bezier(0.5, 0, 0.5, 1),
  ease7 = bezier(0.5, 0.5, 1, 1),
  ease8 = bezier(0.17, 0, 0.83, 1),
  ease9 = bezier(0.71, 0, 0.88, 0.51),
  ease10 = bezier(0.33, 0, 0.97, 0.36),
  ease11 = bezier(0.2, 0, 0.2, 1),
  ease12 = bezier(0.51, 0, 0.63, 1),
  ease13 = bezier(0.38, 0, 0.52, 1),
  ease14 = bezier(0.1, 0.39, 0.67, 1),
  ease15 = bezier(0.39, 0, 0.96, 0.54),
  ease16 = bezier(0.08, 0.43, 0.67, 1),
  ease17 = bezier(0.44, 0, 0.92, 0.75),
  ease18 = bezier(0.1, 0, 0.67, 1),
  ease19 = bezier(0.33, 0, 0.67, 1),
  ease20 = bezier(0.5, 0, 0.67, 1),
}

local function base_state(e)
  return { x = e.x, y = e.y, sx = e.scale_x or 1, sy = e.scale_y or 1,
    dir = e.dir or 0, alpha = e.alpha or 100, visible = e.visible }
end
local function copy(t)
  local o = {}
  for k, v in pairs(t or {}) do o[k] = v end
  return o
end
local function apply(e, s)
  if s.x then e.x = s.x end
  if s.y then e.y = s.y end
  if s.sx then e.scale_x = s.sx end
  if s.sy then e.scale_y = s.sy end
  if s.dir then e.dir = s.dir end
  if s.alpha then e.alpha = s.alpha end
  if s.visible ~= nil then e.visible = s.visible end
end

-- 构造一条时间线；每段记录 from/to 和回放函数，结束时恢复 base
local function new_anim(e, kind, base)
  return { e = e, kind = kind, base = base, cur = copy(base),
    tracks = {}, elapsed = 0, total = 0,
    initial = nil, done = false }
end
local function add(anim, dur, vals, ease)
  local from = copy(anim.cur)
  local to = copy(anim.cur)
  for k, v in pairs(vals or {}) do to[k] = v end
  local t0 = anim.total
  anim.total = anim.total + dur * 1000
  anim.tracks[#anim.tracks + 1] = { t0 = t0, t1 = anim.total, from = from, to = to,
    ease = ease or E.linear }
  anim.cur = to
end
local function set_initial(anim, vals)
  for k, v in pairs(vals or {}) do anim.cur[k] = v end
  anim.initial = copy(anim.cur)
end

local function sign_contains(dir, list)
  for _, v in ipairs(list) do if v == dir then return -1 end end
  return 1
end

local function build_anim(e, kind, animation, direction)
  local b = base_state(e)
  local a = new_anim(e, kind, b)
  if animation == "shake" then
    local d = b.dir
    add(a, .067, { dir = d + 4 }, E.ease20)
    add(a, .083, { dir = d - 13 }, E.ease19)
    add(a, .1, { dir = d + 6 }, E.ease20)
    add(a, .083, { dir = d - 8 }, E.ease19)
    add(a, .067, { dir = d + 2 }, E.ease20)
    add(a, .05, { dir = d }, E.ease19)
  elseif animation == "scale" then
    add(a, .3, { sx = b.sx * .76, sy = b.sy * .76 }, E.default)
    add(a, .2, { sx = b.sx * 1.07, sy = b.sy * 1.07 }, E.default)
    add(a, .2, { sx = b.sx * .97, sy = b.sy * .97 }, E.default)
    add(a, .15, { sx = b.sx, sy = b.sy }, E.default)
  elseif animation == "bounce" then
    local h = e.img_h or 64
    add(a, .1, { sx = b.sx * 1.2, sy = b.sy * .8, y = b.y - h * .1 }, E.ease20)
    add(a, .083, { sx = b.sx, sy = b.sy, y = b.y }, E.ease18)
    add(a, .25, { y = b.y + 12 }, E.ease14)
    add(a, .25, { y = b.y }, E.ease15)
    add(a, .15, { y = b.y + 5 }, E.ease16)
    add(a, .15, { y = b.y }, E.ease17)
  elseif animation == "slideIn" then
    local c = sign_contains(direction, { "left", "down" })
    local x, y = b.x, b.y
    if direction == "left" or direction == "right" then x = b.x + 200 * c
    else y = b.y + 150 * c end
    set_initial(a, { x = x, y = y, alpha = 0 })
    add(a, .15, { x = b.x, y = b.y, alpha = b.alpha }, E.ease1)
    add(a, .05, { sx = b.sx * 1.2, sy = b.sy * .8 }, E.linear)
    add(a, .15, { sx = b.sx * .9, sy = b.sy * 1.1 }, E.linear)
    add(a, .15, { sx = b.sx * 1.06, sy = b.sy * .94 }, E.linear)
    add(a, .1, { sx = b.sx, sy = b.sy }, E.linear)
  elseif animation == "bounceIn" then
    local o = sign_contains(direction, { "left", "down" })
    local u, h, f = 22 * o, -25 * o, -6 * o
    local x, y = b.x, b.y
    local x2, y2 = b.x, b.y
    local x3, y3 = b.x, b.y
    if direction == "left" or direction == "right" then x = x + u; y = y + h; x3 = x3 + f
    else y = y + u; x = x + h; y3 = y3 + f end
    set_initial(a, { x = x, y = y, alpha = 0 })
    add(a, .3, { x = x2, y = y2, alpha = b.alpha }, E.ease2)
    add(a, .2, { x = b.x, y = b.y }, E.ease3)
    add(a, .15, { x = x3, y = y3 }, E.ease4)
    add(a, .15, { x = b.x, y = b.y }, E.ease5)
  elseif animation == "flyIn" then
    local h = sign_contains(direction, { "left", "down" })
    local f = sign_contains(direction, { "left", "up" })
    local x, y = b.x, b.y
    local off = 150 * h
    if direction == "left" or direction == "right" then x = x + off else y = y + off end
    set_initial(a, { x = x, y = y, alpha = 0, dir = b.dir + 16 * f })
    add(a, .4, { x = b.x, y = b.y, alpha = b.alpha, dir = b.dir - 6 * f }, E.ease2)
    add(a, .2, { dir = b.dir + 2 * f }, E.ease6)
    add(a, .15, { dir = b.dir - 1.2 * f }, E.ease7)
    add(a, .15, { dir = b.dir }, E.ease7)
  elseif animation == "slideOut" then
    local f = sign_contains(direction, { "left", "up" })
    local x, y = b.x, b.y
    if direction == "left" or direction == "right" then
      local c = b.x - 40 * f
      add(a, .15, { sx = b.sx * 1.3 }, E.ease19)
      add(a, .2, { sx = b.sx * .95, sy = b.sy * 1.05, x = c }, E.ease19)
      x = b.x + 250 * f
    elseif direction == "up" then
      y = b.y + 50 * f
      add(a, .15, { sx = b.sx * .7, sy = b.sy * 1.1 }, E.ease19)
      add(a, .2, { sx = b.sx * 1.1, sy = b.sy * .7, y = y }, E.ease19)
      y = b.y - 70 * f
    else
      y = b.y + 50 * f
      add(a, .15, { sy = b.sy * .7 }, E.ease19)
      add(a, .2, { sx = b.sx * .97, sy = b.sy * 1.03, y = y }, E.ease19)
      y = b.y - 70 * f
    end
    add(a, .3, { sx = b.sx, sy = b.sy }, E.ease8)
    add(a, .3, { x = x, y = y }, E.ease9)
    add(a, .3, { alpha = 0 }, E.ease10)
  elseif animation == "flyOut" then
    local o = sign_contains(direction, { "left", "down" })
    local x, y = b.x, b.y
    local off = 150 * o
    if direction == "left" or direction == "right" then x = x + off else y = y + off end
    add(a, .15, { dir = b.dir + 10 * o }, E.ease2)
    add(a, .1, { dir = b.dir - 7 * o }, E.ease12)
    add(a, .1, { dir = b.dir }, E.ease13)
    add(a, .3, { alpha = 0, x = x, y = y }, E.ease13)
  elseif animation == "bounceOut" then
    local o = sign_contains(direction, { "left", "down" })
    local x, y = b.x, b.y
    local x2, y2 = b.x, b.y
    if direction == "left" or direction == "right" then
      x = b.x - 35 * o; x2 = b.x + 45 * o
    else
      y = b.y - 35 * o; y2 = b.y + 45 * o
    end
    add(a, .3, { x = x, y = y }, E.ease2)
    add(a, .4, { x = x2, y = y2 }, E.ease4)
    add(a, .4, { alpha = 0 }, E.ease2)
  else
    return nil
  end
  return a
end

local function start(game, e, anim, th)
  if not game or not e or not anim then return end
  game._effect_anims = game._effect_anims or {}
  game._effect_anims[e] = anim
  anim.start = now_ms()
  if anim.initial then apply(e, anim.initial) end
  if th and anim.total > 0 then th:block(math.ceil(anim.total)) end
end

local function finish(game, e, anim)
  local b = anim.base
  apply(e, b)
  if anim.kind == "disappear" then e.visible = false
  elseif anim.kind == "appear" then e.visible = true end
  e._effect_anim = nil
  if game and game._effect_anims then game._effect_anims[e] = nil end
end

function M.update(game, dt)
  if not game then return end
  local t = now_ms()
  for e, a in pairs(game._effect_anims or {}) do
    local lt = t - (a.start or t)
    if lt >= a.total then
      finish(game, e, a)
    else
      local tr = a.tracks[#a.tracks]
      for _, q in ipairs(a.tracks) do
        if lt >= q.t0 and lt <= q.t1 then tr = q break end
      end
      local p = (tr.t1 > tr.t0) and (lt - tr.t0) / (tr.t1 - tr.t0) or 1
      local q = tr.ease(math.max(0, math.min(1, p)))
      local vals = {}
      for k, f in pairs(tr.from) do
        local to = tr.to[k]
        if type(f) == "number" and type(to) == "number" then vals[k] = f + (to - f) * q
        else vals[k] = to end
      end
      apply(e, vals)
    end
  end
  -- 全局动画：只保留状态，由宿主绘制；线程锁在 global_animation 中处理
  if game._global_anim then
    local a = game._global_anim
    a.elapsed = (a.elapsed or 0) + (dt or 0) * 1000
    if a.elapsed >= a.duration then game._global_anim = nil end
  end
end

-- ---------------------------------------------------------------- blocks
function M.self_stress_animation(self, args, th)
  local a = tostring(args.animation or args.ANIMATION or "shake")
  local g = th and th.sched and th.sched.game
  if not g or not self.visible then return end
  local anim = build_anim(self, "emphasis", a)
  if anim then start(g, self, anim, th) end
end

function M.self_appear_animation(self, args, th)
  local kind = tostring(args.appear or args.APPEAR or "appear")
  local animation = tostring(args.animation or args.ANIMATION or "slideIn")
  local direction = tostring(args.direction or args.DIRECTION or "left")
  local g = th and th.sched and th.sched.game
  if not g then return end
  if kind == "appear" and self.visible then return end
  if kind == "disappear" and not self.visible then return end
  if kind == "appear" then self.visible = true end
  local anim = build_anim(self, kind, animation, direction)
  if anim then start(g, self, anim, th) end
end

function M.global_animation(self, args, th)
  local g = th and th.sched and th.sched.game
  if not g then return end
  local a = tostring(args.animation or args.ANIMATION or "animation_salvo")
  local counts = {
    animation_salvo = 60, animation_firework = 30,
    animation_awkward = 45, animation_silent = 30,
  }
  local duration = math.floor((counts[a] or 60) / 30 * 1000)
  g._global_anim = { name = a, duration = duration, elapsed = 0, frame_count = counts[a] or 60 }
  if g.host and g.host.play_effect_audio then g.host:play_effect_audio(a) end
  if th then th:block(duration) end
end

-- ---------------------------------------------------------------- text
local function te(self)
  self.text_effect = self.text_effect or { text = "", size = 36, color = "#000000", active = false }
  return self.text_effect
end

-- 官方 selfTextEffectText/Size/Color：set_* 返回 Promise，解释器拿 thread_lock
-- 等到渲染应用后才继续。本运行时同步应用，等价地让出一帧（保证“下一句”在上屏之后）。
local function await_text_apply(th)
  if th and type(th.block) == "function" then th:block(0) end
end

function M.self_text_effect_text(self, args, th)
  local t = te(self)
  local s = V.str(args.text or args.TEXT or args.text_value or "")
  t.text = s:match("^%s*(.-)%s*$")
  t.active = true
  await_text_apply(th)
end

function M.self_text_effect_size(self, args, th)
  local t = te(self)
  local n = tonumber(args.size or args.SIZE or args.value)
  if not n or n ~= n then return end
  t.size = math.max(1, math.min(2000, n))
  if t.text and t.text ~= "" then t.active = true end
  await_text_apply(th)
end

function M.self_text_effect_color(self, args, th)
  local t = te(self)
  local c = V.str(args.color or args.COLOR or args.colour or "#000000")
  c = c:gsub("#", "")
  t.color = "#" .. c
  if t.text and t.text ~= "" then t.active = true end
  await_text_apply(th)
end

return M
