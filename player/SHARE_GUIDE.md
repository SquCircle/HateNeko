# KN Player 源码分享包 — 使用与开发指南

这是 `knplayer` 的可运行源码与开发资料，不包含官方 bundle、历史 `.love` 包和完整素材库。

---

## 1. 这是什么

`knplayer` 把探月编程 / KittenN（KN）作品 `.bcmkn` 编译为 Lua，在 LÖVE 11.5 中运行。

两条明确边界：

- `kntl/`：Python 编译期，负责 `.bcmkn` → Lua；
- `rt/` + `main.lua`：Lua 运行期，不负责解析作品 JSON。

当前运行时包含：

- 角色/造型/场景/坐标；
- 运动、外观、声音、画笔；
- 事件、广播、克隆、等待；
- 变量/列表；
- 运算/文本/类型转换；
- LÖVE 宿主；
- AtLua 变量/列表 monitor；
- headless 测试宿主。

---

## 2. 环境

必需：

```text
Python 3.8+
LÖVE 11.5（至少 11.x）
```

测试/素材工具建议：

```text
lua5.1 或 luajit
rsvg-convert（处理 SVG 造型）
```

Windows/macOS/Linux 均可；LÖVE 需要支持窗口运行。

---

## 3. 直接运行示例作品

本包根目录的 `conf.lua` 默认：

```lua
STARTUP.work = "variables_ui"
```

在包根目录执行：

```sh
love .
```

示例作品包含：

```text
9 个变量/列表
any / list / public / private / private_list
icon_coin 样式
实体列表
列表弹窗
```

窗口尺寸可在 `conf.lua` 的 `t.window` 修改；`KN_WINDOW=900x562` 也可测试不同窗口。

---

## 4. 编译新的 .bcmkn

```sh
python3 -m kntl.compile path/to/work.bcmkn works/mywork.lua
```

默认会下载并校验素材：

```text
works/assets/<id>.png
works/assets/<id>.mp3
```

只生成 Lua、不下载素材：

```sh
python3 -m kntl.compile path/to/work.bcmkn works/mywork.lua --no-assets
```

编译后修改 `conf.lua`：

```lua
STARTUP.work = "mywork"
```

再运行：

```sh
love .
```

素材缺失时编译器会失败退出，不会静默生成缺图作品。

---

## 5. 测试

完整 headless 回归：

```sh
sh tests/all.sh
```

它大致执行：

```text
Python 预编译 tests/fixtures/*.bcmkn -> tests/fixtures/compiled
Lua 运行时测试
编译测试
```

只跑运行时：

```sh
lua5.1 tests/run.lua
```

只跑某个测试：

```sh
lua5.1 tests/variables_types_test.lua
lua5.1 tests/monitor_layout_test.lua
```

注意：AtLua UI 的真实绘制需要 LÖVE；`monitor_layout_test` 只测舞台→窗口的纯布局数学。

---

## 6. 目录说明

```text
main.lua / conf.lua       LÖVE 入口与启动配置
kntl/                     Python 编译器
kn_spec/                  块规格表（生成物，随包提供）
rt/                       Lua 运行时
  core.lua                Game / Entity / Sched
  impl/                   各域原语
  host/love.lua           LÖVE 宿主
  host/headless.lua       测试宿主
  host/monitors_at.lua    AtLua 变量/列表 UI
  host/monitor_layout.lua 舞台/窗口布局换算
At/                       AtLua UI 框架与字体
tools/                    预编译、打包、构建号、规格表生成
tests/                    测试与 fixtures
docs/                     设计/坐标/官方对照资料
works/                    编译产物与示例素材
archive/                  历史 monitor 存档（不参与运行）
```

---

## 7. 开发入口

### 7.1 增加一个积木原语

1. 在 `kntl/spec.py` / `kn_spec/block_catalog.json` 确认块规格；
2. 在 `kntl/emit.py` 的映射里把块分派到运行时原语；
3. 在 `rt/impl/*.lua` 实现：
   ```lua
   function M.block_name(self, args, th)
   end
   ```
4. 在 `rt/init.lua` 的原语表注册；
5. 增加 headless 测试。

原语约定：

```lua
f[block_type](self, args, th)
```

### 7.2 变量/列表 UI

当前：

```text
rt/host/monitors_at.lua
```

使用 AtLua：

```text
At.Panel
At.Label
At.Button
```

坐标转换在：

```text
rt/host/monitor_layout.lua
```

只做一次：

```text
舞台坐标 + stage fit + widget scale
```

输入统一走：

```text
At.registry
```

旧的 `archive/monitors_legacy.lua` 仅存档，不参与运行。

### 7.3 宿主

`rt/host/love.lua` 负责：

- 窗口/舞台适配；
- 资源加载；
- draw；
- 输入；
- 运行时错误显示。

`rt/host/headless.lua` 负责测试：

- 不依赖 LÖVE 图形；
- 可跑 `rt.load/rt.start/rt.step`；
- 验证变量、线程、坐标和原语。

---

## 8. 打包 .love

需要正常安装 Python 3：

```sh
sh tools/pack.sh output.love
```

或：

```sh
python3 tools/pack.py output.love
```

打包前建议：

```sh
sh tests/all.sh
```

---

## 9. 已知边界

- 本包不包含官方 bundle、原版网页和第三方美术素材；
- `works/` 只带少量示例；
- 变量/列表 UI 正在向 AtLua 风格收敛，尚未做官方像素级全量复原；
- 字体使用包内 AtLua 字体，未替换为官方前端字体；
- 需要 LÖVE 的视觉验证不能用 headless 代替。

---

## 10. 许可

AtLua 相关许可见：

```text
ATLUA_LICENSE
ATLUA_THIRD_PARTY_NOTICES.md
LICENSES/
```

其他代码随项目交付；引用官方资源时请遵守原平台条款。
