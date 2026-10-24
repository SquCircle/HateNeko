# knplayer — 探月编程 (KittenN / KN) 作品播放器

把 KN 作品（`.bcmkn`，一块 JSON，含嵌套 `nekoBlockJsonList`）**编译成 Lua 模块**，
在 [LÖVE 11.5](https://love2d.org) 里运行。桌面 / Android 均可，纯运行时（不含编辑器）。

> **接手请先读第 11 节"踩过的坑"** —— 那 12 条都是真金白银换来的，重犯一次就要重新排查一遍。

---

## 1. 现状（一句话版）

- ✅ 能跑：`works/now.lua`（osu! 风格作品，1.4MB / 110 实体 / 268 造型）、`works/new2.lua`（3D 三角形）
- ✅ 性能：`0~180` 帧段稳定 60fps（**官方 Web 版同段 <1fps**）
- ✅ 编译器已迁到 **Python**（Lua 只留运行时）
- ✅ **仓库自包含**：块规格表 `kn_spec/block_catalog.json` 由 `tools/gen_block_catalog.py`
  从编辑器 bundle 重新生成（不再依赖 `/workspace/kn_spec/`）
- ✅ 回归全绿：`sh tests/all.sh` → **Lua 846 项 × 2 个 VM（lua5.1 + luajit）+ Python 175 项 / 0 失败**
  （62 个测试文件；缺 luajit 时脚本**硬失败**，要跳过必须显式 `KN_ALLOW_MISSING_LUAJIT=1`）
- ✅ 官方语义对齐（阶段 1）：文本 UTF-16、`convert_type`、`calculate` 公式求值（移植官方
  `lex→toPostfix→postfixEval`）、JS 取模/逻辑真值、`check_key` 状态、点击动作状态机、
  `distance_to` 两位小数/`--mouse`
- ✅ P1/H 修复：JS `Number#toString`、列表索引（<1 夹到 1、越界 NaN）、背景 `NONE` 自适应、
  鼠标坐标两位小数、文本特效阻塞一帧、图片印章带特效、`restart` 重置旋转方式、
  `碰到鼠标`悬停语义、播放直到结束轮询、失焦释放输入、完整 keyCode 表、触摸坐标（LÖVE 像素）
- ✅ 性能（CPU 侧，headless）：`now` 2.82→2.20ms/帧（-22%）、`perf_extreme` 1.56→1.33ms（-15%）；
  克隆候选扫描 38×、alpha 取样不再重建整张 alpha 串、效果画布池化、非颜色作品不再每帧整屏拷贝
- ✅ **k3t V2 专项（原子性优先）**：`sync_tell` 改为官方同线程内联（不再 spawn+join），
  render 过程递归不再被切开；常量参数表/脚本变量/列表快路径保留。headless
  `custom_latest` **LuaJIT ~41–49ms/帧、Lua5.1 ~150ms/帧**，proc 挂起 254→0；
  真机 `wait 0.1` 下约 4fps（官方 2fps）。详见 NOTES 5.146–5.148
- ✅ 阶段 4：原语注册表（同名覆盖硬失败）+ 生成式 schema/覆盖门；补齐 `script_variables_set`、
  `change_script_variables`、`get_sprite_property`、`math_trig_rad`、`sound_color`；硬件/AI 块
  有显式「离线不支持」清单，编译期打印并在产物里记 `M.unsupported_blocks`
- ⚠️ 已知缺口见第 10 节（真机视觉/音频/触摸验证、GPU/绘制侧性能、topmost 点击派发）

---

## 2. 架构

```
 .bcmkn (JSON)
     │
     │  kntl/  ← Python 编译器（编译期）
     │   ├─ spec.py     块规格表（读 kn_spec/block_catalog.json，267 条）
     │   ├─ emit.py     代码生成：JSON → Lua 源码
     │   └─ compile.py  入口：编译 + **下载并校验全部素材**（含 SVG 栅格化）
     ▼
 works/<名>.lua     ← 每帧一个"数据表 + 每个 hat 一个 body 闭包"
     │
     │  rt/  ← Lua 运行时（运行期，仅此一处是 Lua）
     │   ├─ init.lua     rt.load / rt.screen / rt.actor / rt.on / rt.f（原语表）
     │   ├─ core.lua     装配层（对外 ABI 不变）
     │   ├─ core/        state（常量/宿主/诊断）· entity · thread · sched · game
     │   ├─ impl/        各域原语，一域一文件：
     │   │                 math · text · sensing · time · screen
     │   │                 motion · looks · pen · common（内部工具）
     │   │                 data · audio · ui · effects · event · control
     │   │                 formula.lua = 官方 calculate 求值器（lex→postfix→eval）
     │   │                 aliases.lua = 旧块名兼容层（lists_* / math_single …）
     │   │                 op_sensing.lua / motion_looks.lua = 拆分后的兼容 re-export
     │   ├─ host/        love.lua（LÖVE 宿主）、headless.lua（测试）、taps.lua（共用点击状态机）
     │   └─ hit.lua / scene.lua / asset.lua / values.lua（JS 真值语义）
     ▼
 LÖVE 11.5
```

**语言划分铁律**：`kntl/`（Python）= 编译期；`rt/` + `main.lua` = 运行期。
`legacy/compiler-lua/` 是旧 Lua 编译器，仅存档参考（1021 行，输出与新编译器逐字节一致）。

---

## 3. 目录

| 路径 | 说明 |
|---|---|
| `main.lua` / `conf.lua` | LÖVE 入口与配置（`STARTUP.work` 决定跑哪个作品） |
| `kntl/` | Python 编译器 |
| `kn_spec/block_catalog.json` | 块规格表（**生成物**，由 `tools/gen_block_catalog.py` 从 `../bundle` 抽） |
| `rt/` | Lua 运行时：`core/`（调度内核）· `impl/`（按域原语）· `host/`（LÖVE/无头宿主） |
| `rt/impl/` | 一域一文件；`common.lua` 只给 impl 内部用（不注册原语） |
| `rt/impl/op_sensing.lua`、`motion_looks.lua` | **兼容 re-export**（拆分后保留旧 `require` 路径） |
| `works/` | 编译产物 `<名>.lua` + `works/assets/` 素材 |
| `tests/` | 回归（`all.sh` 一键） |
| `tools/` | 预编译 / 打包 / 构建号 / 试跑 / 状态快照 / **规格表生成** |
| `docs/` | `coords.md`（坐标系）、`units.md`（单位）、`official_notes.md`、`*_audit.md` |
| `legacy/` | 旧 Lua 编译器存档 |

---

## 4. 快速开始

```sh
# 重新生成块规格表（编辑器 bundle 更新后跑一次；生成物已入库）
python3 tools/gen_block_catalog.py          # → kn_spec/block_catalog.json（265 条）

# 编译一个作品（缺素材会自己下载；有一个下不来就编译失败退出）
python3 -m kntl.compile tests/fixtures/now.bcmkn works/now.lua

# 只生成 Lua，不碰素材
python3 -m kntl.compile tests/fixtures/now.bcmkn works/now.lua --no-assets

# 按 SVG 内在尺寸重做历史素材（改了 SVG 规则后跑一次）
python3 -m kntl.compile tests/fixtures/now.bcmkn works/now.lua --repair-svg

# 预编译测试作品（测试链依赖）
python3 tools/precompile.py

# 全量回归（Python 预编译 + svg 尺寸检查 + lua5.1/luajit 各一遍）
sh tests/all.sh

# 运行 / 探针
love .
love . probe                       # 打印指标 + 截图 + 退出
KN_WINDOW=1800x1124 love . probe   # 用指定窗口跑（验证非 1 倍缩放）

# 一站式：.bcmkn → 自动编译 → 打包 .love（内部作品名默认取输出文件基本名）
# 产物统一放仓库根的 builds/（player/ 内不再放 .love）
sh tools/pack.sh bcmkn/now.bcmkn ../builds/now.love
sh tools/pack.sh bcmkn/now.bcmkn ../builds/now-mobile.love --key-sim

# 旧用法（已编译作品）：默认按 conf.lua 的 STARTUP.work；--work=名 覆盖
sh tools/pack.sh ../builds/now.love --work=now
sh tools/pack.sh ../builds/now-diag.love --diag --work=now
```

启动参数在 `conf.lua` 的 `STARTUP`（`work`、`--debug-center` 等），不读写任何本地存储。

---

## 5. 编译器（Python）

### 5.1 输出的 Lua ABI（运行时契约）

```lua
local M = {}
M.stage_w, M.stage_h = 900, 562          -- 舞台（设计分辨率）
M.vars     = { { id=…, name=…, value=… } }
M.screens  = { { id=…, styles={…}, style_index=… } }
M.cur_scene = "<场景排序第一屏>"          -- ★ 不是 currentSceneId
M.actors   = { { id=…, x, y, rotation, scale, visible, scenes={…}, is_global, order, styles={…}, style_index } }
M.assets   = { ["<styleId>"] = { id, url, file="assets/<id>.png", name, center, styleType, adaption } }
M.audios   = { ["<audioId>"] = { id, url, file="assets/<id>.mp3", name } }
M.requires = { "<原语名>", … }             -- 加载期自检
function M.register(rt, game, ents) … end   -- 每个 hat → rt.on(owner, hat, args, function(th, self) … end)
```

原语调用约定：`f[<块类型>](self, args, th)`；控制流内联，循环尾插 `th:iter_n()/iter_w()/iter_d()`。

### 5.2 素材规则（**踩过两次大的**）

- 落地文件名：`<assets_dir>/assets/<id>.<ext>`，`<id>` 是**造型/音频 id**。
- `ext`：URL 先去 `?query` 再取扩展名；**`svg` 一律落成 `png`**（编译期已栅格化）。
- **SVG 按内在尺寸栅格化**：`width/height` 属性，缺失则 `viewBox`。
  （曾一律 `rsvg-convert -w 512` → 120×120 的 circle 被放大 4.27 倍。）
- 保留 `<id>.svg` 旁挂文件便于复算，但**不进包**。
- 编译期强制校验：缺一个素材就 `return 1` 失败退出，绝不"静默缺图"。

### 5.3 确定性

- 所有字典遍历都排序（`PARAMS0,1,2…10` 用**自然序**），编译结果可复现。
- Lua 标识符清洗按**字节**模拟 `gsub("%W","_")`（中文名 → 每个字节一个下划线），
  因为 Lua 5.1 标识符只允许 `[A-Za-z_][A-Za-z0-9_]*`。

---

## 6. 运行时（Lua）

- **调度**：每个 hat 一个协程；`Sched:step` 每帧推进，`iter_n/w/d` 是让出点；
  `warp`（一步执行）内用 `iter_w`。
- **实体**：`core.Entity`，字段含 `x,y,dir,scale,scale_x,scale_y,effects,pen,styles,style_index,…`。
- **绘制管线（`rt/host/love.lua` 的 `H:draw`）**：
  1. `push("all")` + 清 scissor（**状态护栏**，任何泄漏不跨帧）
  2. 画进 **舞台尺寸画布**（900×562）：背景 → 笔层 → 文字印章 → 角色（带 scissor 裁剪）
  3. `pop()`
  4. 把画布按 `fit` 缩放到窗口（**`fit` 只在这里乘一次**）
- **声音**：一个声音一个 `Source`；重播=重启；新的**循环**音把旧的循环停掉。
- **字体**：**单基准字体（128px）+ 缩放绘制**（LÖVE 文字必须过 Font 对象；
  曾经每字号一字体 → GPU 纹理耗尽 → 闪退）。
- **JS 真值语义**：`if` 条件一律 `V.bool(...)`（Lua 里 `nan` 是真值，会和官方不一致）。

---

## 7. 坐标系与单位（详见 `docs/coords.md`、`docs/units.md`）

**单一事实来源：`rt/host/coords.lua`**（纯 Lua，可单测）

| 层 | 原点 | 单位 |
|---|---|---|
| 舞台坐标（角色位置） | **舞台中心**，y **向上** | 设计像素（900×562 → x∈[-450,450]） |
| 画布像素（舞台画布内） | 左上，y 向下 | 1 舞台单位 = 1 像素 |
| 屏幕像素（窗口/触摸） | 左上，y 向下 | 设备像素 |

**铁律**：`H:draw` 里画进画布的内容**一律用 `canvas_pos`**；`world_to_screen` 只许出现在
"画到窗口"和"输入换算"。`tests/coords_test.lua` 会**静态审计**这条（扫 `H:draw` 源码）。

**单位表（官方证据见 `docs/units.md`）**

| 量 | 单位 |
|---|---|
| 位置 / 移动距离 / 笔迹 | 舞台像素 |
| `set_scale` / `change_scale` / 宽高缩放 | **百分比**（100 = 原尺寸） |
| `appearance_of_sprite`：`scale` | **百分比**（作品里 `115 - appearance` 只有百分比成立） |
| `appearance_of_sprite`：`width/height` | **百分比**（官方 `getSceneOrActorProperty` = `round(100*scale,2)`；main.15ba0757.js 模块 40206） |
| `appearance_of_sprite`：`direction` | 度（逆时针为正，`round(...,2)`） |
| 字号 | 舞台像素 |
| 音量 / 透明度 / 特效强度 | 0–100 |

---

## 8. 官方参考代码（`/workspace/tanyue_kn/`）

- **有**：编辑器侧 `static/js/crc_libs.*.js` —— 角色类、舞台、笔层、印章（`draw_text_stamp` /
  `draw_image_stamp`）、`anchor.set(.5)`、`transform_position.y = -y`、`set_pixi_rotation(-v)`。
- **有**：`main.*.js` —— 积木定义与 `#message/#callee` 对应表、`appearance_of_sprite` 选项、
  `self_change_scale` 的「增加/减少」下拉。
- **缺**：**播放器运行时**是懒加载 chunk，仓库里没有 ✗ —— 所以像
  `add_width_height_scale` 究竟是"加百分比"还是"按当前尺寸乘"这类，只能靠**作品用法反推**。

**取证方法（推荐）**：先看作品里同一原语的**算式上下文**，再定单位。
例：`(115 - appearance)`、`(100 - appearance) / 5`、`math_round(appearance)` → 只可能是百分比。

---

## 9. 测试与调试

```sh
sh tests/all.sh                # 全部（含预编译 + schema + svg + 62 个测试文件 × 2 VM）；当前 0 失败
lua5.1 tests/units_test.lua     # 单位（14 项）
lua5.1 tests/coords_test.lua    # 坐标（15 项，含静态审计）
lua5.1 tests/vm_test.lua        # 黄金用例：3.5MB JS 解释器作品跑出 0.3（5 项）
lua5.1 tests/json_test.lua      # JSON 解码器 + 3.6MB 真实作品压测
python3 tests/svg_size_test.py  # SVG 内在尺寸一致性（5 项）
python3 tests/test_compile.py   # 编译器（111 项：结构/确定性/素材命名/初始屏幕/未知块）
```

> 无头测试跑在 `rt/host/headless.lua` 上；它必须与 `rt/host/love.lua` **同一套输入语义**
> （点击在抬起时判定、按下与抬起都要命中同一对象）。两边不一致时以真机为准，然后改 headless。

性能基准（与本机 CPU 相关，只看趋势；绘制/GPU 仍以真机为准）：

```sh
lua5.1 tools/perf_bench.lua 1200
luajit tools/perf_bench.lua 1200
```

最近一次（本机）：`now` step 2.20ms/0.89ms、`perf_extreme` 1.33ms/0.27ms（lua5.1/luajit）；
`render_list` 110µs/25µs、`alpha_at` 284ns/7.5ns、`clones_of` 36.7µs/2.1µs per 1000 hats。

调试工具：

| 工具 | 用途 |
|---|---|
| `love . probe` | 真宿主脚本化操作 + 指标（实体/线程/笔层像素/舞台墨迹包围盒）+ 截图 |
| `KN_WINDOW=WxH` | 覆盖窗口尺寸（**验证非 1 倍缩放必用**） |
| `lua5.1 tools/trywork.lua <作品> [帧]` | 编译 + 无头试跑，报未知块/运行错误/缺失原语 |
| `lua5.1 tools/dump_state.lua <作品> 5,600` | 多帧状态快照（对比时间切片） |
| `python3 tools/gen_schema.py` | 从块目录生成 `rt/schema.lua`（参数 schema / 事件 / 编译期 / 离线清单）；`--check` 可当门禁 |
| `python3 tools/gen_build.py` | 生成 `rt/build.lua`（源码+**素材**指纹，左上角显示） |
| `lua5.1 tools/perf_bench.lua` | CPU 侧性能基准（now / k3t V2 / perf_extreme / render_list / alpha_at / clones_of；luajit 也跑一遍） |
| `sh tools/pack.sh knplayer-diag.love --diag` | **真机取证包**：启动即把日志/逐帧截图/状态快照写到 `probe_out/`（`rt/host/diag.lua`） |
| `sh tools/pack.sh out.love --work=custom_latest --key-sim` | 包内 conf 打开屏幕按键（只改包内，不改仓库 conf） |

真机取证的落盘位置（按顺序尝试，成功的那条会显示在画面底部，截图里能看到）：
`<工作区>/player/probe_out/` → `/sdcard/.../probe_out/` → `.love` 同级 `knplayer_diag/` →
LÖVE 的 save 目录。**目录加载**时直接在 `player/` 里放一个空的 `diag.on` 也能启用（正式包白名单不含它）。

---

## 10. 已知缺口（TODO）

1. ✅ **`calculate`（公式计算）已按官方实现移植**（`rt/impl/formula.lua`：
   `lex → toPostfix → postfixEval`，角度制、`1/0→"Infinity"`、非法公式抛错）。
   已用官方库 1.4.0 生成 oracle 覆盖 21 条公式回归。
2. **3 个装饰动画**（`self_stress_animation` / `self_appear_animation` / `global_animation`）：
   已按官方动画时间线实现（`rt/impl/effects.lua`），但曲线/时长尚无逐帧像素对照，仍需真机抽查。
3. ✅ **`get_play_audio`** 已作为 LEGACY_BLOCK 收进目录（267 条），运行期也保留兜底原语。
4. **大作品性能**（`iiiiiiii` 200+ 段）：官方同段也是 0fps，属作品本身负载；
   若要继续压，方向是**印章合批**（同帧印章合成一张，一次提交）。
5. ✅ **`tests/run.lua` 的调度语义夹具已恢复**（`tests/fixtures/test_basic.lua`），缺失即硬失败。
6. **`rt/host/love.lua` 无法在本机验证**：Termux 里没有 `love` 包、也没有显示器，
   只有 `rt/host/headless.lua` 一条通路。改了绘制/着色器/文字渲染/触摸后必须由用户
   在真机（LÖVE Android）跑 `love . probe` 复核。
7. **触屏落点仍需真机确认**：已按 LÖVE ≥0.10 文档（touch 回调坐标=窗口像素）去掉旧的
   `touch_px()` 二次换算；但本机没有 LÖVE，最终落点精度要真机点一次确认。
8. **点击帽目前对指针下所有重叠角色派发**（`Hit.hit_list_at`）；PIXI 官方只派发给最上层
   target。改成 topmost-only 会改变 `now` 的"手指光标"交互，需单独设计 + 真机对照，未做。
9. **图片印章的特效**已接角色效果着色器（单 pass 等价），但 twist/displacement 与官方
   PIXI 多 pass 的像素差异仍需真机截图对照。
10. **硬件/AI 块离线不支持**：micro:bit / CatBit / 魔棒 / 机器人 / 人脸/人体/物体识别 / 摄像头 /
   在线 AI / 排行榜等已在 `kntl/support.py` 显式分类；编译期打印清单，运行期是 no-op/0。
   这**不是已实现**；用到这些块的作品在 LÖVE 上不会有对应功能。

---

## 11. 踩过的坑（**读这一节能省好几天**）

---

## 11. 踩过的坑（**读这一节能省好几天**）

1. **画布内用窗口坐标 → `fit` 乘了两次**：窗口=舞台时看不出来，手机上（2.5 倍）字大、位置错、尺寸全偏。
   → 画布内一律 `canvas_pos`，`fit` 只乘一次。
2. **SVG 按固定 512 栅格化** → 120×120 的造型放大 4.27 倍。→ 按**内在尺寸**。
3. **SVG 落成 `.svg` 文件** → 运行时找 `<id>.svg`，包内又排除了 `.svg` → "素材全炸"。→ **一律落 `.png`**。
4. **`appearance_of_sprite` 单位改成小数** → `set_scale` 全体缩小 100 倍（"更糟"）。→ 百分比。
5. **`add_width_height_scale` 写废弃字段 `w/h`** → 改了等于没改。
6. **`self_change_scale` / 宽高缩放无视「减少」下拉** → 只长不缩。
7. **每字号一个 Font** → GPU 纹理耗尽 → 跑几百帧后闪退。→ 单基准字体 + 缩放。
8. **`play_audio` 每次 `newSource`** → 音乐叠播 + 泄漏。→ 单实例 + 重播重启 + 循环互斥。
9. **初始屏幕用 `currentSceneId`** → 开局进错场景。→ `sortList[0]`，并在 `rt.load` 里显式设定。
10. **`pairs` 顺序不确定** → 编译结果不可复现、参数错位。→ 排序 + 自然序。
11. **Lua `%W` 按字节**，Python `\W` 按 Unicode → 中文参数名清洗不一致、生成非法标识符。
12. **`pack.py` 直接写最终文件** → 用户拷到半截包 → `Bad CRC (main.lua)`。
    → 临时文件 + `testzip()` + 原子改名 + 打印 sha256。
13. **绘制状态泄漏**（scissor/canvas）→ 竖屏黑边"花屏"。→ 每帧 `push("all")/pop()` + 入口清 scissor。
14. **加载期点击** → `fit(nil)` 崩。→ 所有输入处理器判空（`love` 与 `headless` 两边都要）。
15. **Lua 同名方法重复定义**：`headless.lua` 里 `on_mouse_released` 写了两遍，后一个简易版
    把前面完整的"按下→抬起判定"整个盖掉 → 无头里点角色永不触发，被误判成"无头模拟不准"。
    → 同一个宿主文件里输入处理只留一份；改完用 `tests/event2_test.lua` + `tests/screen_test.lua` 验证。
16. **测试里用显示名当变量键**：`game.vars` 的键是**变量 id**（`v_tap`），显示名（`被点击`）
    在 `variablesDict` 里。曾经因此把一个已经正常的事件误判为"不触发"。
17. **`bump_into` 只读了一个槽**：官方是 `(主体1, 主体2)` 二元碰撞，第二槽可以是
    `--mouse` / `--edge_bottom/left/top/right` / `--screen` / `camp_*` / 角色 UUID。
    只读 `sprite` 时，`{sprite="--self", sprite1="--edge_bottom"}` 恒为假 →
    `now` 的雪花克隆体永不退出循环（90 秒堆 300+ 克隆、500+ 线程，越跑越卡）。
18. **枚举是大写**：`math_number_property` 的 `type` 是 `COMPOSITE/PRIME/EVEN/…`，
    按小写比较会全部落到 false。同一坑也适用于 `logic_compare` 的 `OP`、`boundary` 的数字串。
19. **「增加/减少」下拉被忽略**：`self_change_coordinate_x/y`、`self_change_pen_size`、
    `self_change_effect`、`self_glide_coordinate_*` 曾只看 value、不看 `increase`
    → 作品里"减少 y"变成"增加 y"，`now` 的雪花往天上飞。统一走 `delta_of()`。
20. **`get_mouse_info` 未按下返回 NaN**：一句没证据的推断，导致 `now` 的视差背景
    `(a + mouse_x/15 - x)/15` 把 NaN 永久写进坐标（lerp 永远回不来）。
    → 改成"始终返回最后已知指针位置"（未移动过 = 0,0）。
21. **文本索引按 Lua 字节算**：官方 JS 是 UTF-16 码元（中文 1、emoji 2）。
    `text_select` 曾只取第 1 个字符、还会把汉字切成半个字节（输出 �）；`text_length` 中文放大 3 倍。
    → `rt/values.lua` 的 `utf16_len / utf16_substring0 / utf16_char_at0`，别再直接 `#s` / `s:sub`。
22. **点击帽按"物理事件"而不是"动作状态"派发**：官方 `sprite_on_tap` 是
    mouse_down → mouse_up（自动回 ""），click 另有每帧清空的 `isMouseClickTarget`。
    曾把 type=mouse_down 的帽在按下和抬起各派发一次（一次点击跑两遍）。
    → 两个宿主共用 `rt/host/taps.lua`；`Sched:tap_match` 统一按 type 过滤。
23. **场景作为点击目标**：hat 的 sprite 可能是**屏幕 UUID**。它等价于"点到舞台空白"
    （事件主体=当前场景），不是 `--screen`（任意点击）。把二者混同会让"点角色切屏"误触发。
24. **打包漏 `At/`**：`pack.py` 的 include 曾没有 `At`，按脚本重打的包会静默失去
    变量/列表 monitor、控制台、DBG 面板与屏幕按键。另外发布包必须**单作品 staging**
    （旧脚本把所有 works/*.lua 和素材并集全打进去，190MB+）。现在两者都有断言。
25. **回归静默跳过 luajit**：`all.sh` 的 `command -v luajit || continue` 会让人误以为
    "lua5.1 + luajit 各跑一遍"，实际只有一端。而 LÖVE Android 跑的是 LuaJIT。
    → 缺 luajit 默认硬失败（`KN_ALLOW_MISSING_LUAJIT=1` 才允许显式跳过并大字报）。
26. **数字转字符串用 `%.14g`**：`1e15→"1e+15"`、`0.1+0.2→"0.3"`，与 JS `String()` 不同。
    → `rt/values.lua` 的 `js_number_to_string`（最短可回读 + ECMAScript 定点/指数规则）；
    `0.1+0.2` 现在和官方一样打印 `0.30000000000000004`。
27. **列表索引按"直觉"处理**：官方告警 `ILLEGAL_LIST_INDEX` 写明 **"有效值需≥1，已自动取 1"**；
    所以 0/负数索引是**夹到 1**，不是 JS `splice` 的负索引。只有 `list_item` 越界返回 NaN。
28. **文本特效是异步的**：官方 `set_text/size/color` 都拿 thread_lock 等渲染应用；不阻塞会让
    紧接着的语句/截图早一帧。→ 三个原语各让出一帧（`th:block(0)`）。
29. **`play_audio_and_wait` 不能用固定时长**：官方等 PLAY_END/FAIL/TIMEOUT；循环音/手动停止
    都会改变结束时刻。→ 每帧轮询 `host:audio_playing(id)`。
30. **输入转发要成对**：AtUI 控制台会吞掉 `keypressed/mousepressed`，但抬起以前仍无条件转发
    → 作品收到"凭空松开/点击"。→ main 记录运行时是否真的收到按下；失焦时 `release_all_input`。
31. **触摸坐标不是 0..1**：LÖVE ≥0.10 的 touch 回调是窗口像素；再乘宽高会让触摸全部落到屏外。
32. **模块 merge 静默覆盖**：`get_answer`、动画桩等同名实现后写胜出，只有读代码才发现。
    → `rt/registry.lua` 登记每个原语的来源；同名不同实现默认启动即 error，确实要覆盖必须登记
    allow（本仓库目前为 0 个例外）。
33. **块目录缺历史块**：`get_play_audio` 这种 shadow 块不在编辑器新目录里，编译器会当未知块。
    → `LEGACY_BLOCKS` + `tools/gen_block_catalog.py` 重新生成；`tools/gen_schema.py --check`
    防止 `rt/schema.lua` 与目录脱节。
34. **硬件/AI 块静默 no-op**：以前作品用了 micro:bit/AI 也只是“什么都不发生”。
    → `kntl/support.py` 单一分类源；编译期打印「离线不支持」清单，产物写 `M.unsupported_blocks`，
    回归测试 `support_test.py` 校验分类与报告。
35. **`sound_color` 不是音效滤镜**：官方是 TTS 语音音色（per/speed/pitch/volume），离线 LÖVE
    没有语音合成；只保存配置并调用可选宿主钩子，不会假装改变了正在播放的音乐。
36. **trampoline 不是免费的，但叶子直调会破坏过程原子性**：把"体内没有 `th:call_proc`"的
    叶子过程改成直调能快约 2 倍，但叶子里的循环让出会发生在父过程栈上，k3t V2 的
    `proc_74d5…` 递归会暴露中间状态。→ 叶子直调改为**可选** `--leaf-procs`，默认关闭；
    原子性优先时全部过程走 trampoline（fps 约 4，官方 2）。
37. **常量参数表每帧分配**：`f["x"](self, { TEXT="a" }, th)` 每次都新建 args 表。
    → 全常量参数 hoist 到模块级 `__CONST[i]`。**不能每个常量一个 local**：Lua 5.1 单函数
    上限 200 个 local，now 有 140+ 个常量会直接编译失败（已踩）。
38. **k3t V2 的尖峰是作品自身的 10Hz 渲染**：`wait 0.1` 的 render 循环每次 `clear_drawing`
    并重建 3D 模型，单帧约 27 万次原语调用（正常帧约 1k）。优化单位置的调用开销，不要
    改渲染频率（那是作品语义）。
39. **`sync_tell` 不能 spawn+join**：官方 `eval_sync_tell` 是同一解释器内联执行（切换
    `target_entity`，`async:false`），spawn 的是 `tell`。用 spawn+join 会在 render 的
    `proc_74d5…` 递归中途挂起线程，暴露中间状态；且换 non-trampoline 也修不了（join 还在）。

---

## 12. 发布清单

```sh
python3 tools/precompile.py          # 1. 测试产物
sh tests/all.sh                      # 2. 回归（须 0 失败；已知失败见第 10 节）
python3 -m kntl.compile tests/fixtures/now.bcmkn works/now.lua   # 3. 重编
python3 tools/gen_build.py           # 4. 构建号（含素材指纹）
sh tools/pack.sh knplayer-<作品>-<版本>.love --work=<作品>   # 5. 单作品打包（校验 + sha256）
```

交付时**同时给出**：`大小` + `sha256` + `build 号`（左上角可见）。
用户传完先核 sha256，不一致=传输截断，重拷即可。

---

## 13. 交接提醒

- 改**原语单位**前：先 `docs/units.md`，再在作品里找 2~3 处**算式上下文**佐证，别只看名字。
- 改**绘制**前：先看 `docs/coords.md` 的铁律，改完跑 `coords_test`（它会拦 `H:draw` 里的 `world_to_screen`）。
- 改**素材**管线前：跑 `svg_size_test`（拦尺寸不一致）。
- 动**共享原语**（如 `appearance_of_sprite`）前：**先列出全部调用点**，再改（这条踩过）。
- 编译产物**不要手改**；要改就改 `kntl/emit.py` 后重编。
- 无头测试与真机不一致时，**以真机为准**，然后去修 `headless`，不要改测试期望值。
  （反例教训见第 11 节第 15 条：`headless` 里同名方法定义了两遍，后一个把完整点击逻辑整个盖掉，
   于是"点角色不触发"被误判成"无头模拟不准"，其实是真 bug。）
- **本机环境（Termux/Android）**：`python3`、`lua5.1`、`luajit`、`rsvg-convert` 齐备；
  **没有 `love`**（Termux 仓库不提供、也没有显示器）→ 真宿主探针必须在真机跑。
  安装包请用 `pkg install`；本镜像的 `dpkg` wrapper 对绝对路径 .deb 会装到嵌套目录，
  装不上时用 `dpkg-deb -x` + 合并到 `$PREFIX` 的兜底（见 `../reference/analysis/README.md`）。
- 规格表是**生成物**：改了 `block_catalog.json` 请同步改 `tools/gen_block_catalog.py`，
  否则下次重新生成会把手工补的条目冲掉。
