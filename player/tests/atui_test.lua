-- AtLua UI 的 headless 逻辑：页面文本、无 love 时不启用、点击捕获路由。
package.path = "./?.lua;" .. package.path
local atui = require("rt.host.atui")

local fails, checks = 0, 0
local function check(desc, got, want)
  checks = checks + 1
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-44s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-44s %s"):format(desc, tostring(got)))
  end
end
local function contains(s, sub)
  return type(s) == "string" and s:find(sub, 1, true) ~= nil
end

check("headless 不启用 AtLua", atui.available, false)
check("headless 点击不前挡舞台", atui.mousepressed(1, 1, 1), false)
check("headless 加载界面不启用", atui.draw_loading(0.5), false)
check("headless 加载 update 不启用", atui.loading_update(1 / 60), false)

local game = {
  frame = 12, cur_screen = "scene-x", stage_w = 900, stage_h = 562,
  entities = {
    { name = "A", kind = "actor", x = 1, y = 2, order = 1, seq = 1, visible = true },
    { name = "B", kind = "actor", x = 3, y = 4, order = 2, seq = 2, visible = true },
  },
  sched = { threads = { { hat = "on_running_group_activated", done = false } } },
  vars = { v = 7 }, host = { mouse_x = 10, mouse_y = 20, mouse_is_down = false },
  describe = function(_, k) return tostring(k) end,
  pointer_world = function() return 0, 0 end,
}
check("页面1含 FPS", contains(atui.page_text(game, 1, { build = "b1", fps = 59 }), "59 FPS"), true)
check("页面2含角色", contains(atui.page_text(game, 2), "A"), true)
check("页面3含线程", contains(atui.page_text(game, 3), "on_running_group_activated"), true)
check("页面4含变量", contains(atui.page_text(game, 4), "v = 7"), true)
check("页面5含指针", contains(atui.page_text(game, 5), "mouse="), true)
check("页面5含 profiler", contains(atui.page_text(game, 5, { profiler = true, profiler_rows = { "10% a", "5% b" } }), "10% a"), true)
check("页面1含平均耗时", contains(atui.page_text(game, 1, { avg_step = 12.5, max_step = 20, avg_draw = 2.1, max_draw = 3 }), "avg draw 2.1"), true)

-- 用假 At 验证“UI 按下 → capture；release 只给 UI”
atui.available = true
atui.At = {
  mousepressed = function() return true end,
  mousereleased = function() return true end,
  keypressed = function() return false end,
  textinput = function() return false end,
  wheelmoved = function() return false end,
  update = function() end,
}
check("UI 按下被捕获", atui.mousepressed(5, 5, 1), true)
check("capture=true", atui.capture, true)
check("release 由 UI 消费", atui.mousereleased(5, 5, 1), true)
check("capture 复位", atui.capture, false)
-- 方案一：At 自带 tab 关闭；console 状态以 isOpen 为准
local src = io.open("rt/host/atui.lua", "rb"):read("*a")
check("At Console tab=false", src:find("tab = false", 1, true) ~= nil, true)
local fake = { visible = false }
function fake:isOpen() return self.visible end
function fake:toggle() self.visible = not self.visible end
function fake:openAmount() return self.visible and 1 or 0 end
atui.available = true
atui.console = fake
atui.console_visible = false
check("LOG 打开", atui.toggle_console(), true)
check("console_visible 同步开", atui.console_visible, true)
check("LOG 关闭", atui.toggle_console(), false)
check("console_visible 同步关", atui.console_visible, false)
atui.console = nil
atui.available = false

-- 图层与命中一致性：变量/列表 monitor 在控制台之下 → 命中先给控制台，命中后不再下传
local order = {}
atui.available = true
atui.capture = false
atui.At = {
  mousepressed = function() order[#order + 1] = "at-press"; return true end,
  mousereleased = function() order[#order + 1] = "at-release"; return true end,
  wheelmoved = function() order[#order + 1] = "at-wheel"; return false end,
  keypressed = function() return false end,
  textinput = function() return false end,
  update = function() end,
}
local top = { visible = true }
function top:isOpen() return self.visible end
function top:openAmount() return self.visible and 1 or 0 end
function top:mousepressed(x, _y) order[#order + 1] = "console-press"; return x >= 10 end
function top:mousereleased() order[#order + 1] = "console-release"; return true end
function top:wheelmoved() order[#order + 1] = "console-wheel"; return true end
atui.console = top
check("控制台在 monitor 上：按下先给控制台", atui.mousepressed(20, 20, 1), true)
check("命中后不再下传 At", table.concat(order, ","), "console-press")
check("capture 被设置", atui.capture, true)
atui.mousereleased(20, 20, 1)
check("release 让控制台收尾并复位 capture", table.concat(order, ","),
  "console-press,console-release,at-release")
check("capture 已复位", atui.capture, false)
check("wheel 归控制台", atui.wheelmoved(0, 1), true)
check("wheel 未下传 At", table.concat(order, ","),
  "console-press,console-release,at-release,console-wheel")
order = {}
check("控制台外按下落到 At（不挡 monitor）", atui.mousepressed(1, 1, 1), true)
check("console 未命中 → At", table.concat(order, ","), "console-press,at-press")
atui.capture = false
atui.console = nil
atui.available = false

-- 绘制顺序：main 必须先画 monitor，再画 AtUI（控制台），否则变量/列表会盖住控制台
local main_src = io.open("main.lua", "rb"):read("*a")
local i_mon = main_src:find("monitors:draw", 1, true)
local i_ui = main_src:find("atui.draw(rt.game)", 1, true)
check("main 先画 monitor 再画 AtUI", i_mon ~= nil and i_ui ~= nil and i_mon < i_ui, true)

print(("结果：%d 项检查，%d 项失败"):format(checks, fails))
if fails > 0 then os.exit(1) end
