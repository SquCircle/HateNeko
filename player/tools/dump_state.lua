-- 全量状态快照：在若干帧数处 dump 实体/变量/线程/印章，便于做"时间切片对比"
-- 用法: lua5.1 tools/dump_state.lua <作品.bcmkn> <帧1,帧2,…> [输出前缀]
-- 例:   lua5.1 tools/dump_state.lua tests/fixtures/now.bcmkn 5,600 $TMPDIR/now
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local PyCompile = require("tools.pycompile")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local path = arg[1] or error("需要作品路径")
local frames = {}
for s in tostring(arg[2] or "5,600"):gmatch("[^,]+") do frames[#frames + 1] = tonumber(s) end
table.sort(frames)
-- 默认写到 $TMPDIR（Android/Termux 上 /tmp 不可写）
local prefix = arg[3] or ((os.getenv("TMPDIR") or ".") .. "/state")

local work = assert((loadstring or load)((PyCompile.compile(path)), "@w"))()

local host = Headless.new()
rt.set_host(host)
local game = rt.load(work, host)
local errors = 0
game.on_error = function(th, e) errors = errors + 1 end
host:preload(game)      -- 无头：立即完成
rt.start()

local function dump(frame)
  local out = {}
  out[#out + 1] = ("# 帧 %d  舞台 %dx%d  当前屏幕 %s  实体 %d  线程 %d  运行错误 %d")
    :format(frame, game.stage_w, game.stage_h, tostring(game.cur_screen):sub(1, 8),
      #game.entities, #game.sched.threads, errors)

  out[#out + 1] = "\n## 实体（按名字、坐标排序）"
  local es = {}
  for _, e in ipairs(game.entities) do
    if e.kind ~= "screen" then
      local w, h = require("rt.hit").actor_size(e, game)
      es[#es + 1] = ("%-12s vis=%-5s pos=(%7.1f,%7.1f) dir=%6.1f scale=%5.1f size=%sx%s layer=%s style=%s scene=%s")
        :format(tostring(e.name), tostring(e.visible ~= false), e.x or 0, e.y or 0, e.dir or 0,
          (e.scale_x or 1) * 100, w and math.floor(w) or "-", h and math.floor(h) or "-",
          tostring(e.layer or 0), tostring(e:style_id()):sub(1, 8), tostring(e.scene):sub(1, 8))
    end
  end
  table.sort(es)
  for _, l in ipairs(es) do out[#out + 1] = l end

  out[#out + 1] = "\n## 变量（非空/非零）"
  local vs = {}
  for k, v in pairs(game.vars) do
    local name = game:describe(k)
    if name and name ~= "" and type(v) ~= "table" and v ~= 0 and v ~= "" and v ~= false then
      vs[#vs + 1] = ("%s = %s"):format(name, tostring(v))
    elseif name and name ~= "" and type(v) == "table" then
      local n = 0
      for _ in pairs(v) do n = n + 1 end
      if n > 0 then vs[#vs + 1] = ("%s = [列表 %d 项]"):format(name, n) end
    end
  end
  table.sort(vs)
  for _, l in ipairs(vs) do out[#out + 1] = l end

  out[#out + 1] = "\n## 每个实体在跑什么（实体 → 线程的 hat，附带存活帧数/是否阻塞）"
  local by_owner = {}
  for _, th in ipairs(game.sched.threads) do
    local owner = th.owner
    local key = tostring(owner and owner.name) .. "@" .. tostring(owner and owner.id):sub(1, 6)
    by_owner[key] = by_owner[key] or {}
    local age = th.born_frame and (game.frame - th.born_frame) or -1
    local state = th.done and "已结束" or (th.blocked_until and th.blocked_until > 0 and "等待中" or (th.wait_for and "等待条件" or "运行"))
    by_owner[key][#by_owner[key] + 1] = ("%s(龄%d,%s)"):format(tostring(th.hat), age, state)
  end
  local okeys = {}
  for k in pairs(by_owner) do okeys[#okeys + 1] = k end
  table.sort(okeys)
  for _, k in ipairs(okeys) do
    table.sort(by_owner[k])
    out[#out + 1] = ("%-26s %s"):format(k, table.concat(by_owner[k], " "))
  end

  out[#out + 1] = "\n## 没有任何线程的实体（脚本可能从未开始）"
  local running = {}
  for _, th in ipairs(game.sched.threads) do
    if th.owner then running[th.owner] = true end
  end
  local idle = {}
  for _, e in ipairs(game.entities) do
    if e.kind ~= "screen" and not running[e] then
      idle[#idle + 1] = ("%s(vis=%s pos=%.0f,%.0f)"):format(tostring(e.name),
        tostring(e.visible ~= false), e.x or 0, e.y or 0)
    end
  end
  table.sort(idle)
  if #idle == 0 then out[#out + 1] = "(无)" end
  for i = 1, math.min(#idle, 60) do out[#out + 1] = idle[i] end
  if #idle > 60 then out[#out + 1] = ("…另有 %d 个"):format(#idle - 60) end

  out[#out + 1] = "\n## 印章文本（去重）"
  local seen = {}
  for _, s in ipairs(host.stamps or {}) do
    if s.text ~= "" and not seen[s.text] then seen[s.text] = true out[#out + 1] = s.text end
  end

  local fh2 = assert(io.open(("%s_%d.txt"):format(prefix, frame), "w"))
  fh2:write(table.concat(out, "\n"))
  fh2:close()
  print(("已写出 %s_%d.txt（实体 %d，变量行 %d，印章 %d）"):format(prefix, frame, #es, #vs, #(host.stamps or {})))
end

local maxf = frames[#frames] or 600
for i = 1, maxf do
  rt.step(1 / 60)
  for _, fr in ipairs(frames) do if fr == i then dump(fr) end end
end
