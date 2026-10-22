-- 采样式性能剖析（低开销）：用 debug.sethook 按指令数取样本，统计热点函数。
-- 用途：实机 step 30ms / draw 1ms 这种"脚本层慢"的定位——面板会列出 top 函数。
-- 开关：conf.lua 的 STARTUP.profile = true，或运行中点右上角（面板第 8 页）。
--
-- 关键：Lua 5.1/LuaJIT 的 debug hook 是**按协程**的；只对主线程 sethook 看不到
-- 调度器里的作品脚本。这里同时 hook 现有 thread.co，并包住 Sched.spawn 给新线程挂。
local P = {
  on = false,
  samples = 0,
  counts = {},      -- "文件:行 函数名" → 样本数
  every = 20000,    -- 每 2 万条指令采一次（约 0.2% 开销）
}

local hooked = {}
local sched_ref = nil
local orig_spawn = nil
local wrapped_spawn = nil

local function key_of(info)
  local src = tostring(info.short_src or "?")
  local line = tostring(info.currentline or 0)
  local name = tostring(info.name or "?")
  return src .. ":" .. line .. " " .. name
end

local function hook()
  local info = debug.getinfo(2, "Snl")
  if not info then return end
  local k = key_of(info)
  P.counts[k] = (P.counts[k] or 0) + 1
  P.samples = P.samples + 1
end

local function hook_co(co)
  if not co or hooked[co] then return end
  if coroutine.status(co) == "dead" then return end
  if pcall(debug.sethook, co, hook, "", P.every) then hooked[co] = true end
end

function P.start()
  if P.on then return end
  P.on = true
  hooked = {}
  debug.sethook(hook, "", P.every)

  local ok, rt = pcall(require, "rt.init")
  if ok and rt.game and rt.game.sched then
    sched_ref = rt.game.sched
    for _, th in ipairs(sched_ref.threads) do hook_co(th.co) end
    orig_spawn = sched_ref.spawn
    wrapped_spawn = function(self, ...)
      local t = orig_spawn(self, ...)
      if P.on and t and t.co then hook_co(t.co) end
      return t
    end
    sched_ref.spawn = wrapped_spawn
  end
end

function P.stop()
  if not P.on then return end
  P.on = false
  pcall(debug.sethook)
  for co in pairs(hooked) do pcall(debug.sethook, co) end
  hooked = {}
  if sched_ref and wrapped_spawn and sched_ref.spawn == wrapped_spawn then
    sched_ref.spawn = orig_spawn
  end
  sched_ref, orig_spawn, wrapped_spawn = nil, nil, nil
end

function P.reset()
  P.counts, P.samples = {}, 0
end

--- 返回 top-n 行（供面板显示）
function P.top(n)
  local rows = {}
  for k, v in pairs(P.counts) do rows[#rows + 1] = { k = k, v = v } end
  table.sort(rows, function(a, b) return a.v > b.v end)
  local out = {}
  for i = 1, math.min(n or 10, #rows) do
    local pct = P.samples > 0 and (rows[i].v / P.samples * 100) or 0
    out[#out + 1] = ("%5.1f%% %s"):format(pct, rows[i].k)
  end
  return out, P.samples
end

return P
