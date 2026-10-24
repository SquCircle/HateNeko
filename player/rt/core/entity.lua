-- 实体（角色 / 屏幕）
-- （原 rt/core.lua Entity 段；2026-10-24 拆分）

local S = require("rt.core.state")
local copy_value = S.copy_value

local Entity = {}
Entity.__index = Entity

function Entity.new(spec)
  spec = spec or {}
  local e = setmetatable({}, Entity)
  e.kind = spec.kind or "actor"        -- "actor" | "screen"
  e.seq = (Entity._seq or 0) + 1        -- 创建序号：同 layer/order 时的稳定裁决（后建的在上）
  Entity._seq = e.seq
  -- ★ 编译器给出的元数据必须**整块**拷过来（漏一个就让整块功能空转：
  --   order 漏了 → 图层顺序空转；img_w 漏了 → 碰撞恒假；scene/scenes 漏了 → 角色不随屏幕显隐）
  for _, k in ipairs({ "order", "layer", "scene", "scenes", "is_global",
                       "img_w", "img_h", "center_point" }) do
    if spec[k] ~= nil then e[k] = spec[k] end
  end
  -- 大小只有两轴倍数（scale_x/scale_y，1.0 = 原尺寸）；不再有 scale 字段。
  -- 编译产物里的 scale 是**百分比输入**，在这里换算一次。
  local _k = (spec.scale or 100) / 100
  e.scale_x = spec.scale_x or _k
  e.scale_y = spec.scale_y or _k
  e.styles = spec.styles or {}                 -- 造型列表
  e.style_index = spec.style_index or 1        -- 当前造型下标（默认第一个）
  e.layer = spec.layer                 -- 「移到最上层/最下层」设置的层号
  e.scene = spec.scene                 -- 所属屏幕（单值，兼容旧数据）
  e.scenes = spec.scenes               -- 所属屏幕列表（编辑器里可能在多个屏幕）
  e.is_global = spec.is_global         -- 被所有屏幕共享（编辑器"所有屏幕"）
  e.scene_ok = true                    -- 场景门：当前屏幕是否包含它（与自身 visible 分开，互不覆盖）
  e.id = spec.id or spec.name or ("e" .. tostring(math.random(1e6)))
  e.name = spec.name or ""
  e.x = spec.x or 0
  e.y = spec.y or 0
  e.dir = spec.dir or spec.rotation or 0 -- 假设 0 = 朝右、逆时针为正（待与官方播放器比对）
  e.scale_x, e.scale_y = (spec.scale_x or _k or 1), (spec.scale_y or _k or 1)
  e.visible = (spec.visible ~= false)
  e.alpha = spec.alpha or 100
  e.layer = spec.layer or 0
  e.rotation_style = spec.rotation_style or "all" -- all | left_right | none
  e.styles = spec.styles or {}
  e.style_index = spec.style_index or 1
  e.effects = { color = 0, opacity = 0, brightness = 0, pixelate = 0, ripple = 0, distortion = 0, grayscale = 0 }
  e.text_effect = nil
  if spec.effects then for k, v in pairs(spec.effects) do e.effects[k] = v end end
  e.vars = {}
  e.lists = {}
  e.pen = { down = false, size = 1, color = "#000000", hsl = { 0, 0, 0 }, alpha = 1, drawing = {} }
  e.draggable = false
  e.edge_bounce = false
  e.clones = 0
  e.clone_index = 0
  e.is_clone = false
  e.parent = nil
  e.deleted = false
  return e
end

function Entity:style_id()
  return self.styles[self.style_index]
end

function Entity:set_style_by_id(id)
  for i = 1, #self.styles do
    if self.styles[i] == id then self.style_index = i return true end
  end
  return false
end

function Entity:clone_self()
  local c = setmetatable({}, Entity)
  for k, v in pairs(self) do c[k] = v end
  c.vars = {}
  for k, v in pairs(self.vars) do c.vars[k] = v end
  c.lists = {}
  for k, v in pairs(self.lists) do
    local src, dst = v, {}
    for i = 1, #src do dst[i] = src[i] end
    c.lists[k] = dst
  end
  c.effects = {}
  for k, v in pairs(self.effects) do c.effects[k] = v end
  if self.text_effect then
    c.text_effect = {}
    for k, v in pairs(self.text_effect) do c.text_effect[k] = v end
  end
  local ph = self.pen.hsv or self.pen.hsl or { 0, 0, 0 }
  c.pen = { down = self.pen.down, size = self.pen.size, color = self.pen.color,
    hsv = { ph[1] or 0, ph[2] or 0, ph[3] or 0 },
    hsl = { ph[1] or 0, ph[2] or 0, ph[3] or 0 },
    alpha = self.pen.alpha or 1, drawing = {} }
  c.is_clone = true
  c.parent = self
  -- 克隆体要有**自己的创建序号**：否则复制父体 seq，同 order 时排序不稳。
  -- 官方克隆体作为新 child 加在父体之后（更上层）；bottom_first 用 seq 打破同 order。
  c.seq = (Entity._seq or 0) + 1
  Entity._seq = c.seq
  -- 克隆体编号**单调递增**：删掉的编号不回收（官方也是这样，作品常拿它当唯一键
  -- 往列表里登记；用"存活数+1"会复用编号，导致新克隆体继承旧条目、点了删不掉）
  self.clone_seq = (self.clone_seq or 0) + 1
  c.clone_index = self.clone_seq
  c.id = self.id .. "#" .. c.clone_index
  c.clones = 0
  c.deleted = false
  return c
end

----------------------------------------------------------------------
-- 线程（= 官方 interpreter）

return { Entity = Entity }
