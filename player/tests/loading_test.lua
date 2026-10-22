-- 加载期安全测试：还没 rt.start / 还没第一帧时，点击/按键/滑动都不能崩
package.path = "./?.lua;" .. package.path
local Headless = require("rt.host.headless")
local fails, checks = 0, 0
local function check(desc, ok)
  checks = checks + 1
  if not ok then fails = fails + 1; print(("  FAIL %s"):format(desc))
  else print(("  ok   %s"):format(desc)) end
end

local h = Headless.new()          -- 注意：没有 rt.load，也没有 rt.start
check("加载期点击不崩", pcall(function() h:click(10, 10, nil) end))
check("加载期按下不崩", pcall(function() h:on_mouse_pressed(10, 10, 1) end))
check("加载期抬起不崩", pcall(function() h:on_mouse_released(10, 10) end))
check("加载期按键不崩", pcall(function() h:on_key("a", true) end))
check("加载期滑动不崩", pcall(function() h:swipe("left") end))
print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
