-- 临时真机探针：console 不可见、love.filesystem 写入不可见时，用 error() 把
-- 环境能力走 LÖVE 错误页显示。只在 b1_probe.on / KN_B1_PROBE=1 时触发。
-- 注意：error() 会终止本次运行；三个 section 合并在同一错误页，无法同一次分帧。
local P = {}

function P.enabled()
  -- 只用包内文件标记；不依赖环境变量（真机无法可靠设置 env）。
  local ok, inf = pcall(function() return love.filesystem.getInfo("b1_probe.on") end)
  return ok and inf ~= nil
end
local enabled = P.enabled

local function probe_frame()
  return 245
end

-- 探针包不写文件：给 H:draw 一个只负责 ACTIVE 判定的替身。
function P.overlay_dump()
  return {
    from = 200, to = 250, active = false, out = "<dry-run>",
    in_range = function(self, f) return f >= self.from and f <= self.to end,
    begin_frame = function(self, g)
      local f = tonumber(g and g.frame) or 0
      self.active = self:in_range(f)
      return self.active
    end,
    mark_drawn = function() end,
    before = function() end,
    after = function() end,
    end_frame = function() end,
  }
end

local hist = {}
local target_names = { ["总PP"] = true, ["星"] = true, ["支持者内容"] = true }
local source_line = {
  ["总PP"] = "now.lua:1759 self_move_to(get_mouse_info x/y)",
  ["星"] = "now.lua:1512 self_move_to(get_mouse_info x/y)",
  ["支持者内容"] = "now.lua:3612 self_move_to(get_mouse_info x/y)",
}

local function one_line(g, e)
  return ("name=%q id=%q x=%s y=%s scale=(%s,%s) rot=%s order=%s layer=%s seq=%s")
    :format(tostring(e.name), tostring(e.id), tostring(e.x), tostring(e.y),
      tostring(e.scale_x), tostring(e.scale_y), tostring(e.dir),
      tostring(e.order), tostring(e.layer), tostring(e.seq))
end

function P.maybe_throw(g, host)
  if not (g and enabled()) then return end
  local f0 = tonumber(g.frame) or 0

  -- f200-f210 每帧记录三个实体的 x/y（NaN 归因）。
  if f0 >= 200 and f0 <= 210 then
    for _, e in ipairs(g.entities or {}) do
      if target_names[e.name] then
        local row = hist[e.name]
        if not row then row = {}; hist[e.name] = row end
        row[#row + 1] = string.format("%d:%s,%s", f0, tostring(e.x), tostring(e.y))
      end
    end
  end

  if f0 ~= probe_frame() then return end

  local out = {}
  out[#out + 1] = "[1/3] love.filesystem"
  local ok, dir = pcall(function() return love.filesystem.getSaveDirectory() end)
  out[#out + 1] = ("getSaveDirectory ok=%s val=%s"):format(tostring(ok), tostring(dir))
  local ok2, ret, err = pcall(function() return love.filesystem.write("probe.txt", "x") end)
  out[#out + 1] = ("write ok=%s ret=%s err=%s"):format(tostring(ok2), tostring(ret), tostring(err))
  local ok3, info = pcall(function() return love.filesystem.getInfo("probe.txt") end)
  out[#out + 1] = ("getInfo ok=%s type=%s size=%s"):format(tostring(ok3), tostring(info and info.type), tostring(info and info.size))

  out[#out + 1] = "[2/3] env / frame"
  out[#out + 1] = ("KN_DRAW_DUMP=%q KN_DRAW_DUMP_FRAMES=%q"):format(
    tostring(os.getenv("KN_DRAW_DUMP")), tostring(os.getenv("KN_DRAW_DUMP_FRAMES")))
  out[#out + 1] = ("frame=%d entities=%d"):format(tonumber(g.frame) or -1, #(g.entities or {}))
  local function has(name)
    local ok, inf = pcall(function() return love.filesystem.getInfo(name) end)
    return ok and inf ~= nil
  end
  out[#out + 1] = ("markers draw_dump.on=%s b1_probe.on=%s diag.on=%s"):format(
    tostring(has("draw_dump.on")), tostring(has("b1_probe.on")), tostring(has("diag.on")))
  if host and host.draw_dump then
    out[#out + 1] = ("draw_dump from=%s to=%s active=%s out=%s"):format(
      tostring(host.draw_dump.from), tostring(host.draw_dump.to),
      tostring(host.draw_dump.active), tostring(host.draw_dump.out))
  else
    out[#out + 1] = "draw_dump=<nil>"
  end

  out[#out + 1] = "[3/3] NaN / draw order"
  for _, name in ipairs({ "总PP", "星", "支持者内容" }) do
    local row = hist[name] or {}
    out[#out + 1] = ("%s src=%s"):format(name, source_line[name] or "?")
    out[#out + 1] = "  " .. table.concat(row, " ")
  end
  for _, e in ipairs(g.entities or {}) do
    if target_names[e.name] then out[#out + 1] = one_line(g, e) end
  end
  local ok4, sorted = pcall(function() return require("rt.scene").render_list(g) end)
  if ok4 then
    local first, last = {}, {}
    for i = 1, math.min(5, #sorted) do first[#first + 1] = tostring(sorted[i].name) end
    for i = math.max(1, #sorted - 4), #sorted do last[#last + 1] = tostring(sorted[i].name) end
    out[#out + 1] = ("render first5=%s"):format(table.concat(first, " | "))
    out[#out + 1] = ("render last5=%s"):format(table.concat(last, " | "))
    local all = {}
    for i = 1, #sorted do
      all[#all + 1] = ("%s:%s"):format(tostring(sorted[i].name), tostring(sorted[i].order))
    end
    local line = "render all(name:order)=" .. table.concat(all, "|")
    if #line > 1800 then line = line:sub(1, 1800) .. "…" end
    out[#out + 1] = line
  else
    out[#out + 1] = "render_list error=" .. tostring(sorted)
  end

  local msg = table.concat(out, "\n")
  if #msg > 4200 then msg = msg:sub(1, 4200) .. "\n…truncated" end
  error(msg, 0)
end

return P
