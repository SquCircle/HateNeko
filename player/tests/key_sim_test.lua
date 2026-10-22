-- 模拟按键输入（AtUI 方向键依赖）
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()
for _, code in ipairs({ 87, 65, 83, 68, 37, 38, 39, 40 }) do
  h:simulate_key_down(code)
  assert(next(h.keys) ~= nil, "key down 未注入 " .. code)
  h:simulate_key_up(code)
end
assert(h:key_down("w") == false, "key up 未释放")
print("key sim ok")
