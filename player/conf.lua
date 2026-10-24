-- LOVE 配置 + 启动参数（都在压缩包里；不涉及本地存储）
STARTUP = {
  probe = false,        -- true = 探针模式（真宿主脚本化操作 + 打印指标 + 截图 + 退出）
  diag  = false,        -- true = 真机取证：日志 + 逐帧截图 + 状态快照写到 probe_out/（见 rt/host/diag.lua）
  profile = false,
  color_debug = false,
  hide_variables = false,   -- 测试包：隐藏全部变量/列表 monitor
  test_values = false,
  key_sim = false,
  orientation = "auto",     -- auto | landscape | portrait           -- 右侧 AtLua A 键模拟按钮      -- 测试包：左上角测试数值通道      -- true = 采样式 profiler（P0 性能包打开）
  work = "variables_ui",      -- 跑哪个作品（switch=切屏机制测试 / now=大作品 / media / effects / real_vm）
  bg_fit = nil,         -- 背景铺法：nil(官方 adaption 规则) / native / cover / contain / stretch
  stage_fit = "contain",-- 舞台适配窗口：contain(留黑边) / cover(裁切铺满) / stretch
  ask = "var a = 0.1; var b = 0.2; print(a + b);", -- 「弹出输入框」的固定内容
}

function love.conf(t)
  t.identity = "knplayer"
  t.window.title = "KN Player"
  t.window.width = 562
  t.window.height = 900
  -- KN_WINDOW=1800x1124 可覆盖（用来验证 fit != 1 时画布坐标是否正确）
  local env = os.getenv("KN_WINDOW")
  if env then
    local w, h = env:match("^(%d+)x(%d+)$")
    if w then t.window.width, t.window.height = tonumber(w), tonumber(h) end
  end
  t.window.vsync = 1
  t.window.resizable = true
  -- 方向：按**作品舞台比例**决定窗口（横屏作品横着开、竖屏作品竖着开）。
  -- 部分 Android Loader 会按初始窗口比例请求屏幕方向，所以这里就要定。
  do
    local okw, w = pcall(require, "works." .. tostring(STARTUP.work or "now"))
    if okw and type(w) == "table" and w.stage_w and w.stage_h then
      local k = math.min(760 / w.stage_w, 760 / w.stage_h)
      t.window.width = math.floor(w.stage_w * k)
      t.window.height = math.floor(w.stage_h * k)
    end
  end
  t.modules.physics = false
  t.modules.joystick = false
end
