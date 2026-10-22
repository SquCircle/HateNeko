-- 变量/列表 monitor 的纯布局计算（headless 可测试）
-- 舞台坐标（左上原点）→ 窗口坐标；只乘一次 stage fit 和一次 widget scale。
local M = {}

local function fit_of(host, g)
  if not g then return 1, 0, 0, 0, 0 end
  local sw, sh = g.stage_w or 900, g.stage_h or 562
  local x1, y1 = host:world_to_screen(-sw / 2, sh / 2, g)
  local x2, y2 = host:world_to_screen(sw / 2, -sh / 2, g)
  local fit = (x2 - x1) / sw
  if not fit or fit <= 0 then fit = 1 end
  return fit, x1, y1, x2, y2
end

function M.stage_rect(host, g, m, base_w, base_h, base_font)
  local fit, ox, oy = fit_of(host, g)
  local pos = m.position or {}
  local scale = tonumber(m.scale) or 1
  if scale < 1 then scale = 1 elseif scale > 2 then scale = 2 end
  local s = fit * scale
  local x = ox + (tonumber(pos.x) or 0) * fit
  local y = oy + (tonumber(pos.y) or 0) * fit
  local w = (base_w or 120) * s
  local h = (base_h or 64) * s
  -- 不越出舞台可视区域（超宽时也压回舞台）
  local sw, sh = g.stage_w or 900, g.stage_h or 562
  local left, top = ox, oy
  local right, bottom = ox + sw * fit, oy + sh * fit
  if w > right - left then w = right - left end
  if h > bottom - top then h = bottom - top end
  local font = (base_font or 16) * s
  if x + w > right then x = math.max(left, right - w) end
  if y + h > bottom then y = math.max(top, bottom - h) end
  if x < left then x = left end
  if y < top then y = top end
  return x, y, w, h, font, fit
end

function M.fit(host, g)
  return fit_of(host, g)
end

-- 变量行内部水平分配：名称区 + 值框。
-- value_want 是“值文字宽 + 左右内边距”，没有任何硬编码最小宽度；
-- 空间不足时先压缩名称，再压缩值框；值框始终右对齐并收在根面板内。
function M.variable_columns(x, w, name_want, value_want, scale)
  local s = tonumber(scale) or 1
  if s <= 0 then s = 1 end
  local pad_l, gap, pad_r = 12 * s, 12 * s, 10 * s
  w = tonumber(w) or 0
  x = tonumber(x) or 0
  name_want = math.max(0, tonumber(name_want) or 0)
  value_want = math.max(0, tonumber(value_want) or 0)
  local inner = math.max(0, w - pad_l - pad_r)
  local value_w = math.min(value_want, math.max(0, inner - gap))
  local name_max = math.max(0, inner - value_w - gap)
  local name_w = math.min(name_want, name_max)
  local vx = x + w - pad_r - value_w
  local vw = value_w
  return name_w, vx, vw
end

return M
