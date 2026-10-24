-- 公共常量与工具（不注册原语，只供 impl 内部 require）（来自 motion_looks.lua）


local V = require("rt.values")
local M = {}


M.MAX_SCALE_PCT = 9999

M.MAX_STAMP_PX  = 8192

local function clamp_scale(v)
  v = V.num(v)
  if v ~= v then return 100 end          -- NaN 保护
  return math.max(-M.MAX_SCALE_PCT, math.min(M.MAX_SCALE_PCT, v))
end

M.clamp_scale = clamp_scale
-- 官方涉及舍入的块目前保持官方四舍五入；未来需要“不舍入”时统一改这里。

M.ROUNDING = true

function M.round_to(v, n)
  if not M.ROUNDING then return v end
  local p = 10 ^ (n or 0)
  return math.floor(v * p + 0.5) / p
end

local function glide(th, ms, setter)
  if ms <= 0 then setter(1) return end
  local start = require("rt.core").now_ms()
  while true do
    local p = (require("rt.core").now_ms() - start) / ms
    if p >= 1 then setter(1) break end
    setter(p)
    coroutine.yield()
  end
end

---------------------------------------------------------------- motion

local function finite(v)
  return type(v) == "number" and v == v and v ~= math.huge and v ~= -math.huge
end

-- 画笔颜色：官方块对外是 HSV（hue/saturation/brightness）；brush 内部保存 HSL。
-- 这里做 hex <-> HSL，以及 g.kO/g.Iv 等价的 HSL <-> HSV。

local function clamp01(v) return math.max(0, math.min(1, v)) end

local function pen_move_tick(self, th)
  local g = th and th.sched and th.sched.game
  if g and g.host and g.host.pen_tick then g.host:pen_tick(self, g) end
end

local function delta_of(args, k1, k2)
  local v = V.num(args[k1] or args[k2])
  -- 官方 changeTargetPosition 对 !isFinite(n) 或 n==0 直接忽略（byte 1750630）。
  if not finite(v) then return 0 end
  local mode = tostring(args.increase or args.method or "increase"):lower()
  if mode == "decrease" or mode == "minus" or mode == "-1" or mode == "减少" then v = -v end
  return v
end

-- 显式导出（源文件里是 local，拆分后要跨模块用）
M.finite = finite
M.clamp01 = clamp01
M.delta_of = delta_of
M.glide = glide
M.pen_move_tick = pen_move_tick

return M
