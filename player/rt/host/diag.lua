-- 真机取证（diag）：把日志 / 逐帧截图 / 状态快照写到"电脑能读到"的目录
--
-- 只在 conf.lua 的 STARTUP.diag = true 时启用；发布包默认 false（不产生任何文件）。
--
-- 为什么要它：headless 测试全绿 != 真机正常。真机上的问题（错位、黑屏、闪烁、
-- 音频叠播、卡顿、闪退）必须**看到画面 + 拿到运行日志**才能定位。
-- 这个模块把证据一次性落盘，电脑端直接读目录，不需要人工转述。
--
-- 落盘位置按优先级尝试（LÖVE 在 Android 上对外部存储的写权限因机型而异）：
--   1. <工作区>/player/probe_out/          ← 开发机直接读
--   2. /sdcard/<工作区>/player/probe_out/  ← 同上，别名
--   3. LOVE 的 save 目录 /diag             ← 兜底，需手动拷出
-- 成功的那条路径会写进画面底部 + 日志，截图时一眼能看到。
local D = {
  installed = false,
  out = nil,              -- 实际落盘目录
  marks = { 1, 30, 60, 120, 240, 480, 900, 1500 },
  buffer = {},            -- 日志缓冲
  shot_n = 0,
  frame = 0,
  errors = 0,
}

local function candidates()
  local list = {}
  -- 0) 和 .love 放一起（LOVE Loader 常常有全盘权限；玩家最容易找到）
  local ok_src, src = pcall(function() return love.filesystem.getSource and love.filesystem.getSource() end)
  if ok_src and type(src) == "string" and src ~= "" and not src:match("%.love$") then
    list[#list + 1] = src .. "/knplayer_diag"
  elseif ok_src and type(src) == "string" and src:match("%.love$") then
    list[#list + 1] = (src:gsub("[/\\][^/\\]*$", "")) .. "/knplayer_diag"
  end
  local ws = "/storage/emulated/0/Codemao/HateNeko/HateNeko_ws/player/probe_out"
  list[#list + 1] = ws
  list[#list + 1] = ("/sdcard%s"):format(ws:sub(#"/storage/emulated/0" + 1))
  local ok, save = pcall(function() return love.filesystem.getSaveDirectory() end)
  if ok and type(save) == "string" and save ~= "" then
    list[#list + 1] = save .. "/diag"
    list[#list + 1] = save
  end
  return list
end

local function write_at(dir, rel, data)
  if not dir then return false end
  local f = io.open(dir .. "/" .. rel, "wb")
  if not f then return false end
  local ok = pcall(function() f:write(data) end)
  f:close()
  return ok
end

function D.write(rel, data)
  if not D.out then return false end
  return write_at(D.out, rel, tostring(data))
end

local function mkdir(d)
  -- 先试着建目录（外部路径 io.open 不会自动建；Android 上有 /system/bin/sh）
  pcall(function() os.execute(('mkdir -p "%s" 2>/dev/null'):format(d)) end)
end

local function pick_dir()
  D.tried = {}
  for _, d in ipairs(candidates()) do
    mkdir(d)
    if write_at(d, "where.txt", "knplayer diag\n") then
      os.remove(d .. "/where.txt")
      return d
    end
    D.tried[#D.tried + 1] = d
  end
  return nil
end

function D.log(line)
  D.buffer[#D.buffer + 1] = tostring(line)
  if #D.buffer > 4000 then
    -- 防无限增长：超了就把前半截丢掉（真机跑很久时日志别把内存吃光）
    local keep = {}
    for i = #D.buffer - 2000, #D.buffer do keep[#keep + 1] = D.buffer[i] end
    D.buffer = keep
  end
end

function D.flush()
  if not D.out then return end
  D.write("diag.log", table.concat(D.buffer, "\n") .. "\n")
end

function D.state(game, tag)
  if not game then return "" end
  local out = {}
  local function add(s) out[#out + 1] = s end
  add(("# %s  frame=%d  screen=%s  entities=%d  threads=%d  errors=%d")
    :format(tag or "", game.frame or -1, tostring(game.cur_screen), #(game.entities or {}),
      #((game.sched and game.sched.threads) or {}), D.errors))
  -- 缺失/未知原语（真机上"某个块不生效"的第一现场）
  local miss = {}
  for k, v in pairs((require("rt.init").stats or {}).missing or {}) do
    miss[#miss + 1] = ("%s×%s"):format(tostring(k), tostring(v))
  end
  if #miss > 0 then add("# 缺失原语: " .. table.concat(miss, " ")) end
  -- 变量
  local vn = 0
  for k, v in pairs(game.vars or {}) do
    vn = vn + 1
    if vn <= 60 then add(("var %s = %s (%s)"):format(tostring(game:describe(k)), tostring(v), type(v))) end
  end
  -- 实体（截断，够定位即可）
  local n = 0
  for _, e in ipairs(game.entities or {}) do
    n = n + 1
    if n <= 300 then
      add(("ent %-24s id=%-14s kind=%-7s pos=(%.1f,%.1f) dir=%.1f scale=%.1f sx=%.2f sy=%.2f vis=%s style=%s")
        :format(tostring(e.name), tostring(e.id):sub(1, 14), tostring(e.kind),
          e.x or 0, e.y or 0, e.dir or 0, e.scale or 100, e.scale_x or 1, e.scale_y or 1,
          tostring(e.visible), tostring(e.style_index)))
    end
  end
  if n > 300 then add(("# …其余 %d 个实体省略"):format(n - 300)) end
  return table.concat(out, "\n") .. "\n"
end

local function save_png(imgdata, name)
  local ok, fd = pcall(function() return imgdata:encode("png") end)
  if not ok or not fd then return false end
  local ok2, s = pcall(function() return fd:getString() end)
  if not ok2 or not s then return false end
  D.shot_n = D.shot_n + 1
  return D.write("shots/" .. name, s)
end

--- 安装：接管日志 + 崩溃处理器，并记录环境信息
function D.install(host, cfg)
  if D.installed then return D end
  D.installed = true
  D.cfg = cfg or {}
  D.out = pick_dir()
  if not D.out then
    -- 保底：先让 love.filesystem 把 save 目录建出来（它会自动建目录），再用 io.open 写
    pcall(function() love.filesystem.write("diag_probe.txt", "ok") end)
    D.out = pick_dir()
  end
  if D.out then
    -- 目录可能不存在：先尝试创建（love.filesystem 只能建 save 目录下的，外部路径靠
    -- 开发机预先建好；这里失败就说明该路径不可写，pick_dir 已经跳过了）
    pcall(function() love.filesystem.createDirectory("shots") end)
  end

  -- 日志 tee：宿主 log 全进缓冲
  local orig_log = host.log
  host.log = function(self, msg, level)
    D.log(("[%s] %s"):format(tostring(level or "info"), tostring(msg)))
    if orig_log then return orig_log(self, msg, level) end
  end

  -- 崩溃：LÖVE 默认错误屏之外，把 traceback 也落盘
  local orig_err = love.errorhandler
  if orig_err then
    love.errorhandler = function(msg)
      D.errors = D.errors + 1
      D.log("=== 未捕获错误 ===\n" .. debug.traceback(tostring(msg), 2))
      D.flush()
      return orig_err(msg)
    end
  end

  local meta = {
    "knplayer diag",
    ("love %s"):format(tostring(select(1, love.getVersion and love.getVersion() or "?"))),
    ("os %s"):format(tostring(love.system and love.system.getOS and love.system.getOS() or "?")),
    ("window %dx%d"):format(love.graphics.getWidth(), love.graphics.getHeight()),
    ("dpiscale %.2f"):format(love.graphics.getDPIScale and love.graphics.getDPIScale() or 1),
    ("work %s"):format(tostring(D.cfg.work or "?")),
    ("out %s"):format(tostring(D.out or "（没有可写目录！）")),
  }
  if D.out then
    -- 建立截图目录
    pcall(function()
      local f = io.open(D.out .. "/shots/.keep", "wb")
      if f then f:write(""); f:close() end
    end)
    D.write("meta.txt", table.concat(meta, "\n") .. "\n")
  end
  D.log(table.concat(meta, " | "))
  if not D.out and D.tried then
    D.log("可写目录尝试结果（全失败）：" .. table.concat(D.tried, ", "))
  end
  return D
end

--- 每帧调用（love.update 末尾）：到点就存状态
function D.tick(game, host)
  if not D.installed then return end
  D.frame = (D.frame or 0) + 1
  if not game then return end
  local f = game.frame or D.frame
  D._want_shot = nil
  for _, m in ipairs(D.marks) do
    if f == m then
      D.write(("state_%04d.txt"):format(f), D.state(game, "frame " .. f))
      D._want_shot = f
    end
  end
  if f % 120 == 0 then D.flush() end
end

--- 每帧绘制末尾调用：把这一帧存成 png（回调在本帧渲染完成后执行）
function D.after_draw(game)
  if not D.installed then return end
  if D._want_shot then
    local f = D._want_shot
    D._want_shot = nil
    local ok = pcall(function()
      love.graphics.captureScreenshot(function(imgdata)
        if imgdata then save_png(imgdata, ("frame_%04d.png"):format(f)) end
      end)
    end)
    if not ok then D.log("截图失败 frame=" .. tostring(f)) end
  end
  -- （底部状态条已移除：没有可写目录时它只剩一条黑带，挡画面）
  love.graphics.setColor(1, 1, 1)
end

return D
