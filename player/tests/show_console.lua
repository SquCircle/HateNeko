-- 跑一个编译产物，并把作品「画」在 Console 上的文字（文字印章）打印出来
-- 用法: lua5.1 tests/show_console.lua <作品.lua> <帧数> [输入文件|-] [代码文本]
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local path = arg[1] or "works/real_vm.lua"
local frames = tonumber(arg[2]) or 1600
local ask
local askfile = arg[3]
if askfile == "-" then
  ask = arg[4]
elseif askfile then
  local fh = io.open(askfile)
  if fh then ask = fh:read("*a") fh:close() end
end

local src = assert(io.open(path, "rb")):read("*a")
local work = assert((loadstring or load)(src, "@" .. path))()
local host = Headless.new()
if ask then host.ask_value = ask end
rt.set_host(host)
local game = rt.load(work, host)
local errors = 0
game.on_error = function(th, e) errors = errors + 1 if errors <= 3 then print("[err] " .. tostring(e)) end end
rt.start()
local ui = require("rt.impl.ui")
for _ = 1, frames do
  rt.step(1 / 60)
  local d = ui.current_dialog(game)
  if d and d.type == "ask" and ask then ui.submit_answer(ask, game) end
end

print("--- 作品输出（印章文本，按出现顺序去重）---")
local seen = {}
for _, s in ipairs(host.stamps or {}) do
  if not seen[s.text] and s.text ~= "" and s.text ~= "█" then
    seen[s.text] = true
    print("  " .. s.text)
  end
end
-- 也把 Console / errorMsg 变量里的内容摊出来（作品把输出存在这里）
local function flatten(v, out, depth)
  if type(v) ~= "table" then out[#out + 1] = tostring(v) return end
  if depth > 4 then return end
  for _, vv in pairs(v) do flatten(vv, out, depth + 1) end
end
for k, v in pairs(game.vars) do
  local nm = game:describe(k)
  if nm == "Console" or nm == "errorMsg" or nm == "LexerProgress" then
    local out = {}
    flatten(v, out, 1)
    print(("[%s] %s"):format(nm, table.concat(out, " | "):sub(1, 300)))
  end
end
print(("--- 运行错误 %d，剩余线程 %d ---"):format(errors, #game.sched.threads))
