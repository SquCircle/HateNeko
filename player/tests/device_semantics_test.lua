-- PC / Mobile 两种交互语义
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")

local function load(dev)
  local h = Headless.new({ device = dev })
  h.play_audio = function(_, _, loop) return loop and 0 or 100000 end
  rt.set_host(h)
  local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
  rt.start()
  return h, g
end
local function mouse_info(g, typ)
  local th = g.sched:system_thread()
  return rt.f.get_mouse_info(nil, { type = typ }, th)
end
local function is_nan(v) return type(v) == "number" and v ~= v end

-- PC: 未收到输入前 NaN；mouseup 后保留最后位置
local h, g = load("pc")
h.pointer_valid = false
assert(is_nan(mouse_info(g, "x")), "PC 初始不应有鼠标位置")
h:on_mouse(450, 281)
assert(h.pointer_valid == true, "PC mousemove 未使 pointer 有效")
h:on_mouse_pressed(450, 281)
h:on_mouse_released(450, 281)
assert(h.pointer_valid == true, "PC mouseup 后 pointer 失效")
assert(h.mouse_is_down == false, "PC mouseup 后 mouse_is_down 未复位")
assert(not is_nan(mouse_info(g, "x")), "PC mouseup 后 get_mouse_info 应为有限值")

-- Mobile: 按住时有效；touchend 后 NaN
local hm, gm = load("mobile")
hm:on_touch_pressed(450, 281, 1)
assert(hm.pointer_valid == true, "Mobile touchstart 未使 pointer 有效")
assert(not is_nan(mouse_info(gm, "x")), "Mobile 按住时 get_mouse_info 应有限")
hm:on_touch_moved(500, 300, 1)
assert(hm.mouse_x == 500 and hm.mouse_y == 300, "Mobile touchmove 未更新位置")
hm:on_touch_released(500, 300, 1)
assert(hm.pointer_valid == false, "Mobile touchend 后 pointer 未失效")
assert(hm.mouse_is_down == false, "Mobile touchend 后 mouse_is_down 未复位")
assert(is_nan(mouse_info(gm, "x")), "Mobile touchend 后 get_mouse_info 应为 NaN")
assert(is_nan(mouse_info(gm, "y")), "Mobile touchend 后 get_mouse_info(y) 应为 NaN")
print("device semantics ok pc/mobile")
