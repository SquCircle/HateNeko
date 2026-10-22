-- 事件相关原语（hat 块的「注册」走 rt.on；这里是与事件相关的取值/判定块）
-- 统一签名：function(self, args, th)
local V = require("rt.values")

local M = {}

function M.received_broadcast(self, args, th)
  local ev = th.event
  if not ev then return false end
  return ev.message == args.message
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

local function attr_value(e, attr)
  if not e then return 0 end
  local a = tostring(attr or "x")
  local fx = e.effects or {}
  if a == "x" then return e.x or 0
  elseif a == "y" then return e.y or 0
  elseif a == "direction" or a == "rotation" then return e.dir or 0
  elseif a == "scale" then return (e.scale_x or 1) * 100
  elseif a == "width" then return (e.img_w or 0) * (e.scale_x or 1)
  elseif a == "height" then return (e.img_h or 0) * (e.scale_y or 1)
  elseif a == "visible" then return e.visible and 1 or 0
  elseif a == "style_index" or a == "styles" then return e.style_index or 0
  elseif a == "camp" then return e.camp or 0
  elseif a == "clone_index" then return e.clone_index or 0
  elseif a == "color" or a == "0" then return fx.color or 0
  elseif a == "opacity" or a == "1" then return fx.opacity or 0
  elseif a == "brightness" or a == "2" then return fx.brightness or 0
  elseif a == "pixelate" or a == "3" then return fx.pixelate or 0
  elseif a == "ripple" or a == "4" then return fx.ripple or 0
  elseif a == "distortion" or a == "5" then return fx.distortion or 0
  elseif a == "grayscale" or a == "6" then return fx.grayscale or 0
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
