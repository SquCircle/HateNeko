-- 点击/触摸动作状态（两个宿主共用，避免 love/headless 分叉）
--
-- 对齐官方 StageEvent 的动作状态机（player.main.63b4a46c.js）：
--   sprite_on_tap（每实体）：mouse_down → mouse_up（自动回 ""）
--   global_tap：mouse_down → mouse_up（自动回 ""）
--   global_click：仅**空白处点击**，one_frame
--   isMouseClickTarget[entity]：actor/scene click 后设置，帧末清空
local M = {}

local function add_scene_if_empty(game, hit_ids)
  if next(hit_ids) == nil and game and game.cur_screen then
    hit_ids[game.cur_screen] = true
  end
  return hit_ids
end

function M.press(host, game, hit_ids)
  host.tap_action = host.tap_action or {}
  hit_ids = add_scene_if_empty(game, hit_ids or {})
  for id in pairs(hit_ids) do host.tap_action[id] = "mouse_down" end
  host.global_tap = "mouse_down"
  return { kind = "mouse_down", type = "mouse_down", hits = hit_ids, empty = (next(hit_ids) == nil) }
end

-- release_ids：抬起时指针下的所有实体；press_ids：按下时的命中集合
-- 点击目标 = 两者交集（官方 actor:click 只在同目标 mousedown+mouseup 才触发）
function M.release(host, game, release_ids, press_ids)
  host.tap_action = host.tap_action or {}
  release_ids = add_scene_if_empty(game, release_ids or {})
  press_ids = press_ids or {}
  local clicks = {}
  for id in pairs(release_ids) do
    if press_ids[id] then clicks[id] = true end
  end
  for id in pairs(release_ids) do host.tap_action[id] = "mouse_up" end
  -- 按下过、但抬起时不在指针下（mouseupoutside）：官方发 ""，不是 mouse_up
  for id, st in pairs(host.tap_action) do
    if st == "mouse_down" and not release_ids[id] then host.tap_action[id] = "" end
  end
  host.global_tap = "mouse_up"
  host.click_targets = clicks
  local up = { kind = "mouse_up", type = "mouse_up", hits = release_ids, empty = (next(release_ids) == nil) }
  local click = { kind = "mouse_click", type = "mouse_click", hits = clicks, empty = (next(clicks) == nil) }
  return up, click
end

-- 每帧末：mouse_up 自动回 ""；click 目标清空；global_click 只保留一帧
function M.end_frame(host)
  for id, st in pairs(host.tap_action or {}) do
    if st == "mouse_up" then host.tap_action[id] = "" end
  end
  if host.global_tap == "mouse_up" then host.global_tap = "" end
  host.click_targets = nil
  host.global_click = false
end

return M
