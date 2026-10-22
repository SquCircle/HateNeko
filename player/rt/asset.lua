-- 资源尺寸解析：等价于官方的 texture.width / texture.height
-- （官方几何判定全部基于加载后的纹理尺寸；无头环境没有解码器，就读文件头）
local M = {}

local function be32(s, i) return s:byte(i) * 16777216 + s:byte(i + 1) * 65536 + s:byte(i + 2) * 256 + s:byte(i + 3) end
local function be16(s, i) return s:byte(i) * 256 + s:byte(i + 1) end

-- PNG: IHDR 在固定位置（宽 16..19，高 20..23）
local function png_size(s)
  if #s < 24 then return nil end
  return be32(s, 17), be32(s, 21)
end

-- JPEG: 扫描段，找 SOF0..SOF15（除 DHT/DAC 等）里的高宽
local function jpeg_size(s)
  local i = 3
  while i + 8 < #s do
    if s:byte(i) ~= 0xFF then i = i + 1
    else
      local m = s:byte(i + 1)
      if m == 0xD8 or m == 0x01 or (m >= 0xD0 and m <= 0xD7) then i = i + 2
      elseif m == 0xD9 or m == 0xDA then return nil
      else
        local len = be16(s, i + 2)
        if m >= 0xC0 and m <= 0xCF and m ~= 0xC4 and m ~= 0xC8 and m ~= 0xCC then
          return be16(s, i + 7), be16(s, i + 5) -- 高在前、宽在后
        end
        i = i + 2 + len
      end
    end
  end
  return nil
end

-- GIF: 逻辑屏幕描述符里的小端宽高
local function gif_size(s)
  if #s < 10 then return nil end
  local w = s:byte(7) + s:byte(8) * 256
  local h = s:byte(9) + s:byte(10) * 256
  return w, h
end

-- SVG: 读 width/height，或用 viewBox
local function svg_size(s)
  local head = s:sub(1, 4000)
  local w = head:match('width="([%d%.]+)')
  local h = head:match('height="([%d%.]+)')
  if w and h then return math.floor(tonumber(w) + 0.5), math.floor(tonumber(h) + 0.5) end
  local a, b, c, d = head:match('viewBox="([%-%d%.]+)[ ,]+([%-%d%.]+)[ ,]+([%-%d%.]+)[ ,]+([%-%d%.]+)"')
  if a then return math.floor(tonumber(c) + 0.5), math.floor(tonumber(d) + 0.5) end
  return nil
end

function M.size_from_bytes(s)
  if type(s) ~= "string" or #s < 10 then return nil end
  if s:sub(1, 8) == "\137PNG\r\n\26\n" then return png_size(s) end
  if s:sub(1, 2) == "\255\216" then return jpeg_size(s) end
  if s:sub(1, 3) == "GIF" then return gif_size(s) end
  if s:sub(1, 4) == "<svg" or s:find("<svg", 1, true) then return svg_size(s) end
  return nil
end

-- 读文件（优先 love.filesystem，其次标准 io）
function M.size(path)
  if not path then return nil end
  local ok, s
  if love and love.filesystem and love.filesystem.getInfo and love.filesystem.getInfo(path) then
    ok, s = pcall(function() return love.filesystem.read(path) end)
  end
  if (not ok or not s) and io then
    local f = io.open(path, "rb")
    if f then
      s = f:read(4096) and (function() f:seek("set", 0) return f:read("*a") end)()
      f:close()
    end
  end
  return M.size_from_bytes(s)
end

return M
