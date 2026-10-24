-- 事件相关原语（hat 块的「注册」走 rt.on；这里是与事件相关的取值/判定块）
-- 统一签名：function(self, args, th)
local V = require("rt.values")

local M = {}

function M.received_broadcast(self, args, th)
  -- 官方 received_broadcast（player.main:2076685 段）：读**全局** broadcast 动作状态
  -- （`get_action_state_value({action_id:"broadcast", sub_type:message})`），
  -- 状态由 Sched:broadcast 写入、每帧开始清空（statefulness.automatic_transitions="one_frame"，
  -- 见 player.main:4639096 perform_automatic_state_transitions）。不是当前线程的 event。
  local g = th and th.sched and th.sched.game
  local name = args and args.message
  if not g or name == nil then return false end
  return g.bcast_state ~= nil and g.bcast_state[tostring(name)] == true
end

function M.self_listen_param(self, args, th)
  return (th.event and th.event.param) or ""
end

function M.self_listen_value(self, args, th)
  return (th.event and th.event.param) or ""
end

function M.get_current_clone_index(self)
  return self.clone_index or 0
end

function M.get_clone_num(self, args, th)
  local game = th.sched.game
  local target = self
  if args and args.sprite and args.sprite ~= "--self" then
    target = game:find(args.sprite) or self
  end
  while target and target.is_clone and target.parent do target = target.parent end
  return target and target.clones or 0
end

-- 官方 getSceneOrActorProperty（main.15ba0757.js 模块 40206 的 I 函数）：
--   x/y/scale/width/height/direction 全部 round(...,2)；width/height = 100×scale（**百分比**）
--   透明(1) = visible ? round(100×(1-alpha),2) : 100
local function round2(v)
  if type(v) ~= "number" or v ~= v then return v end
  return math.floor(v * 100 + 0.5) / 100
end

local function attr_value(e, attr)
  if not e then return 0 end
  local a = tostring(attr or "x")
  local fx = e.effects or {}
  if a == "x" then return round2(e.x or 0)
  elseif a == "y" then return round2(e.y or 0)
  elseif a == "direction" or a == "rotation" then return round2(e.dir or 0)
  elseif a == "scale" then return round2((e.scale_x or 1) * 100)
  elseif a == "width" then return round2((e.scale_x or 1) * 100)
  elseif a == "height" then return round2((e.scale_y or 1) * 100)
  elseif a == "visible" then return e.visible and 1 or 0
  elseif a == "style_index" or a == "styles" then return e.style_index or 0
  elseif a == "camp" then return e.camp or 0
  elseif a == "clone_index" then return e.clone_index or 0
  elseif a == "color" or a == "0" then return round2(fx.color or 0)
  elseif a == "opacity" or a == "1" then
    if e.visible == false then return 100 end
    return round2(100 - (e.alpha or 100))
  elseif a == "brightness" or a == "2" then return round2(fx.brightness or 0)
  elseif a == "pixelate" or a == "3" then return round2(fx.pixelate or 0)
  elseif a == "ripple" or a == "4" then return round2(fx.ripple or 0)
  elseif a == "distortion" or a == "5" then return round2(fx.distortion or 0)
  elseif a == "grayscale" or a == "6" then return round2(fx.grayscale or 0)
  elseif a == "layer" then return e.layer or 0
  end
  return 0
end

function M.get_clone_index_property(self, args, th)
  local game = th.sched.game
  local target = self
  if args and args.sprite and args.sprite ~= "--self" then
    target = game:find(args.sprite) or self
  end
  if not target then return 0 end
  local idx = tonumber(args and (args.index or args.list_index)) or 1
  idx = math.floor(idx + 0.5)
  -- 官方 index=0 表示原型本体；>0 才按原型 clone 列表 1-based。
  while target and target.is_clone and target.parent do target = target.parent end
  if idx == 0 then return attr_value(target, args and args.attribute) end
  local list = {}
  for _, e in ipairs(game.entities or {}) do
    if e.is_clone and e.parent == target and not e.deleted then list[#list+1] = e end
  end
  local e = list[idx]
  return attr_value(e, args and args.attribute)
end

function M.on_bump_actor_value(self, args, th)
  local ev = th.event
  if not ev or not ev.target then return 0 end
  return attr_value(ev.target, args and (args.attribute or args.attr))
end

return M
