-- 性能基准（headless CPU 侧；绘制/GPU 仍需真机）
-- 用法: lua5.1 tools/perf_bench.lua [now帧数]
--       luajit tools/perf_bench.lua
-- 只打印数字，不做阈值断言（不同机器差异大；回归看趋势）。
package.path = "./?.lua;" .. package.path
io.stdout:setvbuf("line")

local rt = require("rt.init")
local Headless = require("rt.host.headless")
local Scene = require("rt.scene")
local Hit = require("rt.hit")

local NOW_FRAMES = tonumber(arg and arg[1]) or 1200

local function bench_work(name, frames)
  local h = Headless.new(); rt.set_host(h)
  local g = rt.load(require("works." .. name), h)
  local errs = 0
  g.on_error = function() errs = errs + 1 end
  rt.start()
  local t0 = os.clock()
  local mx = 0
  for _ = 1, frames do
    local a = os.clock()
    rt.step(1 / 60)
    local d = os.clock() - a
    if d > mx then mx = d end
  end
  local ms = (os.clock() - t0) / frames * 1000
  print(("%-14s step avg %7.3f ms  max %7.1f ms  ents %3d  thr %3d  errs %d")
    :format(name, ms, mx * 1000, #g.entities, #g.sched.threads, errs))
  return g
end

local g_now = bench_work("now", NOW_FRAMES)
bench_work("custom_latest", 300) -- k3t V2：每 0.1s 模型重建一次
bench_work("perf_extreme", 300)
bench_work("perf_layers", 300)

-- 渲染列表（每帧 O(n) 检查 + 必要时排序）
do
  local t0 = os.clock()
  local n = 0
  for _ = 1, 3000 do n = #Scene.render_list(g_now) end
  print(("render_list    %7.3f us/call  (%d ents, last n=%d)")
    :format((os.clock() - t0) / 3000 * 1e6, #g_now.entities, n))
end

-- alpha 取样（命中热路径）：1e6 次
do
  local rgba = string.rep("\1\2\3\255", 512 * 512)
  local px = { w = 512, h = 512, rgba = rgba }
  local t0 = os.clock()
  local sum = 0
  for i = 1, 1000000 do
    sum = sum + Hit.alpha_at(px, (i * 7919) % (512 * 512) + 1)
  end
  print(("alpha_at       %7.1f ns/call (sum=%d)") :format((os.clock() - t0) / 1e6 * 1e9, sum))
end

-- 克隆列表缓存（20 个 hat × 300 克隆；模拟 fire_bump 的候选扫描）
do
  local h = Headless.new(); rt.set_host(h)
  local g = rt.load({
    stage_w = 900, stage_h = 562, vars = {}, screens = {},
    actors = { { id = "root", name = "R", x = 0, y = 0, styles = { "s1" }, style_index = 1 } },
    assets = {}, audios = {},
  }, h)
  rt.start()
  local root = g:find("root")
  root.clones = 300
  for _ = 1, 300 do local c = root:clone_self(); g.entities[#g.entities + 1] = c end
  local hats = {}
  for i = 1, 20 do hats[i] = { owner = root } end
  local t0 = os.clock()
  local n = 0
  for _ = 1, 2000 do
    for _, s in ipairs(hats) do n = n + #g:clones_of(s.owner) end
  end
  print(("clones_of      %7.3f us/1000 hats (%d cands)")
    :format((os.clock() - t0) / 2000 * 1e6, n))
end
