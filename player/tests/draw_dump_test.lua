-- B1 headless：字段完整性 + 独立 in_hit（隐藏/剔除但可命中）+ 写盘路径。
package.path = "./?.lua;" .. package.path

local D = require("rt.host.draw_dump")
local Scene = require("rt.scene")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-46s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-46s %s"):format(desc, tostring(got)))
  end
end

local g = { frame = 240, stage_w = 100, stage_h = 100, entities = {} }
local drawn = { id = "drawn", name = "Drawn", kind = "actor", x = 1, y = 2,
  scale_x = 1, scale_y = 1, dir = 90, alpha = 50, order = 1, layer = 2, seq = 7,
  visible = true, effects = { hue = 30 } }
-- 在舞台外（不会被 H:draw 画到），但仍在 hit_list 里：
local hidden = { id = "hidden", name = "Hidden", kind = "actor", x = 9999, y = 0,
  scale_x = 1, scale_y = 1, dir = 0, alpha = 100, order = 2, layer = 1, seq = 8,
  visible = true, effects = {} }
local nulls = { id = "nulls", kind = "actor", visible = true }
g.entities = { drawn, hidden, nulls }

local hl = {}
for _, e in ipairs(Scene.hit_list(g)) do hl[e.id] = true end
check("hit_list 含舞台外实体（in_hit 独立来源）", hl.hidden, true)

local line = D.format_line(g, drawn, "BEFORE", 1, true, true)
for _, k in ipairs({ "frame", "phase", "idx", "name", "id", "kind", "x", "y",
  "scale_x", "scale_y", "rot", "flip", "alpha", "order", "layer", "seq",
  "drawn", "in_hit", "shader" }) do
  check("字段存在 " .. k, line:find(k .. "=", 1, true) ~= nil, true)
end
check("rot 来自 draw_rotation", line:find("rot=90.0000", 1, true) ~= nil, true)
check("shader 参数", line:find("hue=30.0000", 1, true) ~= nil, true)

local nline = D.format_line(g, nulls, "STATE", nil, false, false)
check("缺 name → null", nline:find("name=null", 1, true) ~= nil, true)
check("缺 x → null", nline:find("x=null", 1, true) ~= nil, true)
check("缺 order → null", nline:find("order=null", 1, true) ~= nil, true)
check("缺 seq → null", nline:find("seq=null", 1, true) ~= nil, true)
check("缺 shader → null", nline:find("shader=null", 1, true) ~= nil, true)

-- 回归：首帧 mark_drawn 可能早于/脱离 begin_frame 的 active 段。
local inert = D.new({ out = out, frames = "200-250" })
check("new 时 drawn 已初始化", type(inert.drawn), "table")
local g1 = { frame = 1, stage_w = 100, stage_h = 100, entities = { drawn } }
check("帧段外 begin_frame 返回 false", inert:begin_frame(g1), false)
check("帧段外 mark_drawn 不报错", pcall(inert.mark_drawn, inert, { id = "screen" }), true)
check("帧段外不写入 drawn", next(inert.drawn), nil)

-- 模拟开关关闭/未初始化：mark_drawn 必须先看 active，不得触碰 drawn。
local off = D.new({ out = out, frames = "240-240" })
off.active = false
off.drawn = nil
check("关闭时 mark_drawn 不访问 drawn", pcall(off.mark_drawn, off, { id = "x" }), true)

local out = ".tmp/draw_dump_test"
os.execute(('mkdir -p "%s" 2>/dev/null'):format(out))
os.remove(out .. "/draw_0240.txt")
local dump = D.new({ out = out, frames = "240-240" })
check("begin_frame 帧内", dump:begin_frame(g), true)
dump:mark_drawn(drawn)
check("end_frame 写盘", dump:end_frame(g), true)

local f = io.open(out .. "/draw_0240.txt", "rb")
local text = f and f:read("*a") or ""
if f then f:close() end
check("文件存在且有 3 条 STATE", select(2, text:gsub("phase=STATE", "phase=STATE")), 3)
check("drawn 实体 drawn=true", text:find('name="Drawn".-drawn=true', 1) ~= nil, true)
check("舞台外实体 drawn=false / in_hit=true",
  text:find('name="Hidden".-drawn=false.-in_hit=true', 1) ~= nil, true)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
