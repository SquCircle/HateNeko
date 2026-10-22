-- 试跑一个作品（编译 + 无头运行），报告：未知块 / 运行错误 / 缺失原语
io.stdout:setvbuf("line")
-- 用法: lua5.1 tools/trywork.lua <作品.bcmkn> [帧数]
package.path = "./?.lua;" .. package.path

local json = require("rt.json")
local PyCompile = require("tools.pycompile")
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local path = arg[1] or error("需要作品路径")
local frames = tonumber(arg[2]) or 300

local t0 = os.clock()
local lua_src, report = PyCompile.compile(path)
print(("编译完成：%.1fs，生成 %d 行"):format(os.clock() - t0, select(2, lua_src:gsub("\n", "\n"))))

local unknown = {}
for k, v in pairs((report and report.unknown) or {}) do
  unknown[#unknown + 1] = ("%s(%s)"):format(tostring(k), tostring(v))
end
table.sort(unknown)
print("未知块类型: " .. (#unknown == 0 and "无" or (#unknown .. " 种 → " .. table.concat(unknown, ", "))))

local host = Headless.new()
rt.set_host(host)
local ok, work = pcall(function() return assert((loadstring or load)(lua_src, "@work"))() end)
if not ok then
  print("编译产物加载失败: " .. tostring(work))
  os.exit(1)
end

local game = rt.load(work, host)
game.trace_errors = true  -- 出错时打印协程栈，便于定位
local errors, first_err = 0, nil
game.on_error = function(th, e)
  errors = errors + 1
  if not first_err then first_err = tostring(e) end
end

rt.start()
local t1 = os.clock()
for _ = 1, frames do rt.step(1 / 60) end
print(("跑完 %d 帧：用时 %.1fs，实体 %d，存活线程 %d，运行错误 %d")
  :format(frames, os.clock() - t1, #game.entities, #game.sched.threads, errors))
if first_err then print("首个错误: " .. first_err) end

local miss = rt.missing_report()
table.sort(miss)
print("缺失原语: " .. (#miss == 0 and "无" or table.concat(miss, ", ")))

local seen, n = {}, 0
for _, s in ipairs(host.stamps or {}) do
  if not seen[s.text] and s.text ~= "" then seen[s.text] = true n = n + 1 end
end
print("文字印章种类: " .. n)
