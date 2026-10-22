-- 跑一个「编译产物」：lua5.1 tests/run_compiled.lua /tmp/real_work.lua [帧数]
-- 用来压测编译器输出（语法 + 运行时行为 + 缺失原语报告）
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local path = arg[1]
local frames = tonumber(arg[2]) or 60
-- 第三个参数：输入框（弹出输入框积木）的固定内容；也可以 --ask-file=<路径>
local ask = arg[3]
for _, a in ipairs(arg or {}) do
  local f = tostring(a):match("^%-%-ask%-file=(.+)$")
  if f then
    local h = assert(io.open(f, "rb"), "打不开 " .. f)
    ask = h:read("*a")
    h:close()
  end
end
assert(path, "用法: lua tests/run_compiled.lua <编译产物.lua> [帧数] [输入框内容]")

local chunk, err = (loadstring or load)(assert(io.open(path, "rb")):read("*a"), "@" .. path)
if not chunk then
  print("语法错误: " .. tostring(err))
  os.exit(1)
end
local work = chunk()

local host = Headless.new { verbose = true }
if ask then host.ask_value = ask end
rt.set_host(host)
local game = rt.load(work, host)
if game.missing_primitives then
  print("缺失原语 " .. #game.missing_primitives .. " 个：" .. table.concat(game.missing_primitives, ", "))
end

rt.start()
local errors = 0
game.on_error = function(th, e)
  errors = errors + 1
  if errors <= 5 then
    print(("[运行错误] hat=%s owner=%s → %s"):format(tostring(th.hat), tostring(th.owner and th.owner.id), tostring(e)))
  end
end

local ui = require("rt.impl.ui")
for i = 1, frames do
  rt.step(1 / 60)
  local d = ui.current_dialog(game)
  if d and d.type == "ask" and ask then ui.submit_answer(ask, game) end
end

local alive = 0
for i = 1, #game.sched.threads do
  local th = game.sched.threads[i]
  if not th.done then
    alive = alive + 1
    print(("  [线程] hat=%s owner=%s blocked=%s warp=%d")
      :format(tostring(th.hat), tostring(th.owner and th.owner.name),
              tostring(th.blocked_until > host:now_ms()), th.warp_frames))
  end
end
print(("跑了 %d 帧：实体 %d，存活线程 %d，运行错误 %d"):format(frames, #game.entities, alive, errors))
local vars = {}
for k, v in pairs(game.vars) do
  if type(v) ~= "table" then vars[#vars + 1] = ("%s=%s"):format(game:describe(k), tostring(v)) end
end
table.sort(vars)
if #vars > 0 then print("变量：" .. table.concat(vars, "  ")) end
local missing = rt.missing_report()
if #missing > 0 then print("降级（未实现）原语：" .. table.concat(missing, ", ")) end
