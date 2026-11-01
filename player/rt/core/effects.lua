-- 角色特效：默认值与亮度换算（官方实现 = player.main:5401491 的 Effects 类）
--
-- 官方字段初值：brightness = **100**（中性），其它滤镜 0。
-- 旧实现把 brightness 默认写成 0，渲染端又用 `~= 0` 判断"是否启用亮度"，
-- 于是「设置亮度 = 0」被当成「没有亮度效果」→ 变黑失效（本次修复的 bug）。
local M = {}

M.DEFAULTS = {
  color = 0, opacity = 0, brightness = 100,
  pixelate = 0, ripple = 0, distortion = 0, grayscale = 0,
}

function M.new()
  local t = {}
  for k, v in pairs(M.DEFAULTS) do t[k] = v end
  return t
end

function M.default(k)
  local v = M.DEFAULTS[k]
  if v == nil then return 0 end
  return v
end

-- 读取特效值：表里缺键时退回官方默认（brightness 缺省 = 100，不是 0）
function M.get(fx, k)
  if fx then
    local v = fx[k]
    if v ~= nil then return v end
  end
  return M.default(k)
end

-- 官方 set_brightness：uniform = clamp(-1, 1, value/100 - 1)
--   0 → -1（全黑）、100 → 0（中性）、200 → +1。
function M.brightness_uniform(fx)
  local v = M.get(fx, "brightness")
  local b = v / 100 - 1
  if b < -1 then b = -1 elseif b > 1 then b = 1 end
  return b
end

-- 灰度（官方 saturate 取负：grey 0..100 → 饱和 1..0）
function M.saturation_of(fx)
  local g = M.get(fx, "grayscale")
  if g == 0 then return 1 end
  return math.max(0, 1 - g / 100)
end

-- 官方 PIXI ColorMatrixFilter.hue 矩阵（player.main:5329351，set_hue 5401585）：
--   rad = deg/180*PI; n = cos, r = sin; i = 1/3; a = sqrt(i)
--   [ n+(1-n)i     i(1-n)-a r   i(1-n)+a r ]
--   [ i(1-n)+a r   n+i(1-n)     i(1-n)-a r ]
--   [ i(1-n)-a r   i(1-n)+a r   n+i(1-n)   ]
-- 返回 LÖVE mat3 需要的 **列主序** 9 个数（col0, col1, col2）。
function M.hue_matrix(deg)
  local rad = math.rad((deg or 0) % 360)
  local n = math.cos(rad)
  local r = math.sin(rad)
  local i = 1 / 3
  local a = math.sqrt(i)
  local one = 1 - n
  local m00 = n + one * i
  local m01 = i * one - a * r
  local m02 = i * one + a * r
  local m10 = i * one + a * r
  local m11 = n + i * one
  local m12 = i * one - a * r
  local m20 = i * one - a * r
  local m21 = i * one + a * r
  local m22 = n + i * one
  return m00, m10, m20, m01, m11, m21, m02, m12, m22
end

-- 是否需要启用特效着色器（亮度中性、无其它特效时返回 false）
function M.needs_shader(fx, opts)
  opts = opts or {}
  local hue = M.get(fx, "color")
  local bright = M.brightness_uniform(fx)
  local sat = M.saturation_of(fx)
  local pixel = M.get(fx, "pixelate")
  local twist = M.get(fx, "distortion")
  local ripple = M.get(fx, "ripple")
  return hue ~= 0 or bright ~= 0 or sat ~= 1 or pixel > 1 or twist ~= 0 or ripple ~= 0
end

return M
