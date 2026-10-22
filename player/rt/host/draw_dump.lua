-- B1：逐实体绘制/状态 dump（默认关；只在 KN_DRAW_DUMP=1 时构造）。
-- 纯格式化 + 写盘；不碰 love.graphics，不改绘制逻辑。
local M = {}

local SHADER_KEYS = { "hue", "opacity", "brightness", "pixelate", "ripple", "twist", "grayscale" }

local function q(v)
  if v == nil then return "null" end
  if type(v) == "string" then return string.format("%q", v) end
  return tostring(v)
end

local function num(v)
  if v == nil then return "null" end
  return string.format("%.4f", tonumber(v) or 0)
end

local function shader_str(e)
  local fx = e and e.effects or {}
  local parts, any = {}, false
  for _, k in ipairs(SHADER_KEYS) do
    local v = fx[k]
    if v ~= nil then
      any = true
      parts[#parts + 1] = k .. "=" .. num(v)
    else
      parts[#parts + 1] = k .. "=null"
    end
  end
  if not any then return "null" end
  return "{" .. table.concat(parts, ",") .. "}"
end

-- 单行、可直接粘贴。缺值一律 null，不跳过实体。
function M.format_line(g, e, phase, idx, drawn, in_hit)
  local ML = require("rt.impl.motion_looks")
  local rot, flip = ML.draw_rotation(e)
  local opacity = (e.effects and e.effects.opacity or 0) / 100
  if opacity < 0 then opacity = 0 elseif opacity > 1 then opacity = 1 end
  local alpha = ((e.alpha or 100) / 100) * (1 - opacity)
  return table.concat({
    "frame=" .. tostring(g and g.frame or -1),
    "phase=" .. tostring(phase),
    "idx=" .. (idx ~= nil and tostring(idx) or "null"),
    "name=" .. q(e.name),
    "id=" .. q(e.id),
    "kind=" .. q(e.kind),
    "x=" .. num(e.x),
    "y=" .. num(e.y),
    "scale_x=" .. num(e.scale_x),
    "scale_y=" .. num(e.scale_y),
    "rot=" .. num(rot),
    "flip=" .. tostring(flip and true or false),
    "alpha=" .. num(alpha),
    "order=" .. (e.order ~= nil and tostring(e.order) or "null"),
    "layer=" .. (e.layer ~= nil and tostring(e.layer) or "null"),
    "seq=" .. (e.seq ~= nil and tostring(e.seq) or "null"),
    "drawn=" .. tostring(drawn and true or false),
    "in_hit=" .. tostring(in_hit and true or false),
    "shader=" .. shader_str(e),
  }, " ")
end

function M.parse_range(s)
  s = tostring(s or ""):gsub("%s", "")
  if s == "" then s = "200-250" end          -- 默认只写 200-250，避免文件爆炸
  if s == "all" or s == "*" then return 0, math.huge end
  local a, b = s:match("^(%d+)%-(%d+)$")
  if a then
    a, b = tonumber(a), tonumber(b)
    if a > b then a, b = b, a end
    return a, b
  end
  local n = tonumber(s)
  if n then return n, n end
  return 200, 250
end

local function mkdir(path)
  pcall(function() os.execute(('mkdir -p "%s" 2>/dev/null'):format(path)) end)
  if love and love.filesystem and love.filesystem.createDirectory then
    pcall(love.filesystem.createDirectory, path)
  end
end

local function write_at(dir, rel, data)
  if not dir then return false end
  local f = io.open(dir .. "/" .. rel, "wb")
  if not f then return false end
  local ok = pcall(function() f:write(data) end)
  f:close()
  return ok
end

local Dump = {}
Dump.__index = Dump

function M.new(opts)
  opts = opts or {}
  local self = setmetatable({}, Dump)
  self.from, self.to = M.parse_range(opts.frames or os.getenv("KN_DRAW_DUMP_FRAMES"))
  self.out = opts.out or os.getenv("KN_DRAW_DUMP_DIR")
  self.diag = nil
  self.announced = false
  self.active = false
  -- 首帧 mark_drawn 可能发生在 begin_frame 之前（例如背景屏在帧段外也走绘制）；
  -- 这里先给出空表，mark_drawn 另有 active 守卫。
  self.drawn = {}
  self.lines = {}
  self.idx = {}
  self.hit = {}
  return self
end

function Dump:ensure_out()
  if self.out then
    mkdir(self.out)
    return self.out
  end
  local D = package.loaded["rt.host.diag"]
  if D and D.installed and D.out then
    self.diag = D
    self.out = D.out
  elseif love and love.filesystem and love.filesystem.getSaveDirectory then
    self.out = love.filesystem.getSaveDirectory() .. "/knplayer_draw"
    mkdir(self.out)
  else
    self.out = ".tmp/knplayer_draw"
    mkdir(self.out)
  end
  return self.out
end

function Dump:announce()
  if self.announced then return end
  self.announced = true
  local dir = self:ensure_out()
  print(("[draw_dump] frames=%d-%d out=%s"):format(self.from, self.to, tostring(dir)))
end

function Dump:write(rel, data)
  if self.diag then
    local ok = self.diag.write(rel, data)
    if ok then return true end
  end
  return write_at(self.out, rel, data)
end

function Dump:in_range(frame)
  return frame >= self.from and frame <= self.to
end

function Dump:begin_frame(g)
  self:announce()
  local f = tonumber(g and g.frame) or 0
  self.active = self:in_range(f)
  self.drawn = {}
  self.lines = {}
  self.idx = {}
  self.hit = {}
  if not self.active then return false end

  self.g = g
  self.frame = f

  local Scene = require("rt.scene")
  for i, e in ipairs(Scene.render_list(g)) do
    self.idx[e.id or e] = i
  end
  for _, e in ipairs(Scene.hit_list(g)) do
    self.hit[e.id or e] = true
  end
  return true
end

function Dump:is_hit(e)
  return self.hit[e.id or e] == true
end

function Dump:mark_drawn(e)
  if not self.active or not e then return end
  self.drawn[e.id or e] = true
end

function Dump:before(e, idx)
  if not self.active then return end
  self.lines[#self.lines + 1] = M.format_line(self.g, e, "BEFORE", idx, true, self:is_hit(e))
end

function Dump:after(e, idx)
  if not self.active then return end
  self:mark_drawn(e)
  self.lines[#self.lines + 1] = M.format_line(self.g, e, "AFTER", idx, true, self:is_hit(e))
end

function Dump:end_frame(g)
  if not self.active then return false end
  local lines = {}
  lines[#lines + 1] = ("# frame=%d entities=%d"):format(self.frame, #(g.entities or {}))
  -- 全量实体一行（含屏幕/隐藏/剔除/未入 render_list）；drawn 由实际绘制标记，
  -- in_hit 独立来自 Scene.hit_list，绝不从 render_list 推断。
  for _, e in ipairs(g.entities or {}) do
    lines[#lines + 1] = M.format_line(g, e, "STATE", self.idx[e.id or e], self.drawn[e.id or e] == true, self:is_hit(e))
  end
  for _, line in ipairs(self.lines) do lines[#lines + 1] = line end

  local ok = self:write(("draw_%04d.txt"):format(self.frame), table.concat(lines, "\n") .. "\n")
  self.active = false
  self.lines = {}
  return ok
end

return M
