-- 坐标换算（纯 Lua，无 LÖVE 依赖，便于单元测试）
--
-- 三层坐标（见 docs/coords.md）：
--   舞台坐标：原点在舞台中心，y 向上，单位 = 设计像素（900×562 作品即 x∈[-450,450]）
--   画布像素：原点画布左上，y 向下；舞台画布尺寸 = 舞台尺寸（1 舞台单位 = 1 像素）
--   屏幕像素：窗口像素；= 画布像素 × fit + 黑边偏移
--
-- **画布内部一律用画布像素**；fit 只在"把画布画到窗口"时乘一次。
local M = {}

--- 舞台坐标 → 画布像素
function M.canvas_pos(g, x, y)
  return g.stage_w / 2 + (x or 0), g.stage_h / 2 - (y or 0)
end

--- 画布像素 → 舞台坐标
function M.stage_pos(g, px, py)
  return (px or 0) - g.stage_w / 2, g.stage_h / 2 - (py or 0)
end

--- 画布 → 窗口（fit + 黑边居中）
function M.fit(g, win_w, win_h)
  local s = math.min(win_w / g.stage_w, win_h / g.stage_h)
  local cx = (win_w - g.stage_w * s) / 2
  local cy = (win_h - g.stage_h * s) / 2
  return s, cx, cy
end

--- 舞台坐标 → 屏幕像素
function M.world_to_screen(g, x, y, win_w, win_h)
  local s, cx, cy = M.fit(g, win_w, win_h)
  return cx + ((x or 0) + g.stage_w / 2) * s,
         cy + (g.stage_h / 2 - (y or 0)) * s
end

--- 屏幕像素 → 舞台坐标
-- 屏幕像素 → **舞台坐标**（原点在舞台中心、y 向上）。
-- 之前漏了「减去舞台半宽 / 加回半高」：窗口=舞台时看不出来（cx=cy=0 但整体平移半个舞台），
-- 结果点右上角读到 (800,-30) 而不是 (~450,~281)，命中检测全错 → 点击类事件（通知）永远点不中。
function M.screen_to_world(g, sx, sy, win_w, win_h)
  local s, cx, cy = M.fit(g, win_w, win_h)
  return ((sx or 0) - cx) / s - g.stage_w / 2,
         g.stage_h / 2 - ((sy or 0) - cy) / s
end

return M
