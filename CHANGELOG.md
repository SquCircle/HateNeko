# Changelog

## 0.2.0 — 2026-10-24

发布摘要：

- **运行时语义**：切屏线程冻结模型、广播 one_frame、属性单位（百分比/两位小数）、透明特效写 alpha、
  列表宽松相等、text_contain NaN、造型号取整、ask 数值识别、未实现原语告警。
- **计时器**：官方两套时钟拆开 —— 「计时器值」= `TheatreStore.timerValue`（秒/两位小数，
  「执行计时器」start/stop/reset 控制），旧版 `get_timer`/`reset_timer` 仍是 `timer_block_date`。
- **输入**：`stage_fit`（contain/cover/stretch）绘制与反算统一；指针只在舞台 hitArea 内更新；
  黑边按下不产生 `mouse_down`。
- **条件槽真值**：官方编译成裸 `if(expr)`（JS 真值），文本 `"false"`/`"0"` 为真；
  `重复执行直到` 先跑一轮体再判条件。
- **函数_布尔**：`procedure_boolean` 编译为**布尔** `true`/`false`（不是文本）。
- **运动 NaN**：朝向/步数/坐标偏移非有限时不写入，避免实体坐标变 NaN 导致绘制消失。
- **UI**：右上角 **KEY** 开关（WASD/方向键面板显示/隐藏），`key_sim` 包默认显示。
- **工具链**：`./kn build <作品名>` 一站式（编译→打包），`kntl.compile`/`tools/pack.py` 只收作品名；
  `tests/tooling_test.py` 门禁。
- **回归**：Lua 测试 84 个 ×（lua5.1 + luajit）+ 6 个 Python 门禁，全绿。

### 详细记录（同日）

### 语义修复（每条以官方 bundle 为准，括号内为证据位置）

- **切屏线程模型**：官方 `step_code`（player.main:4829705）对跑出运行组的线程只销毁
  `finish_out_of_run_group`（仅 `on_running_group_activated`），其余**冻结**；切屏语句本身不中断解释器。
  旧实现把旧屏线程一律 `done`，并 `error(STOP_THIS)` 结束切屏线程 → 切回原屏后脚本永久失效、
  「切屏 → 后续语句」整段不执行。新增回归 `tests/screen_freeze_test.lua`（9 项）。
- **收到广播**：改为全局 one_frame 动作状态（player.main:2076685 / 4639096）；
  旧实现读线程 `th.event`，只有被广播 spawn 的线程里为真。新增 `tests/broadcast_state_test.lua`。
- **宽度/高度/坐标/角度**：官方 `getSceneOrActorProperty`（main.15ba0757.js 模块 40206）是
  `round(100*scale, 2)` 与 `round(pos, 2)`；`get_clone_index_property` / `on_bump_actor_value`
  不再按像素返回，`README`/`docs/units.md` 单位说明同步更正。
- **透明特效**：官方写 `actor.alpha`（player.main:2239194 的 `s` 函数），不是独立的 effects 槽；
  `effect_of_sprite(1)` 改为 `visible ? 100-alpha : 100`。
- **`lists_is_exist`**：官方 `t == VALUE || t == String(VALUE)`（宽松相等），不是 `===`。
- **`text_contain`**：任一侧 NaN/缺失 → `false`（官方显式 guard）。
- **`set_sprite_style`**：数字造型号按官方 `Math.round`，不再把 2.4 直接写进 `style_index`。
- **`self_ask` / `ask_and_choose`**：数值识别正则与官方 `/^(-?\d+)(\.\d+)?$/` 对齐（`"5."` 不再当数字）。
- **`bump_into_body_part`**：标为「需要摄像头与人体识别」——此前是 267 条目录里**唯一**未分类块，
  会静默落到 no-op。
- **未实现原语**：正式包首次命中时打一次 warn（每个名字只报一次），不再完全静默。

### 工具链易用性（作品名即可，路径可省略）

- **新增 `player/tools/kn.py` + 仓库根 `kn` 包装**：
  ```sh
  ./kn build atkn        # bcmkn/atkn.bcmkn → works/atkn.lua → builds/atkn.love
  ./kn build             # 用 conf.lua 的 STARTUP.work
  ./kn compile atkn      # 只编译
  ./kn pack atkn         # 只打包
  ./kn list              # 看作品/编译产物/已有包
  ```
  作品参数可写名字、`bcmkn/x.bcmkn`、`works/x.lua`；`-o/--out` 改输出；`--force/--reuse/-no-assets`
  控制编译；`--dry-run` 只打印步骤。
- `kntl/compile.py`：第一个参数可用**作品名**（自动搜索 仓库根 `bcmkn/`、`player/bcmkn/`、
  `tests/fixtures/`），输出默认 `works/<作品>.lua`（`-o -` 输出到 stdout），`--assets-dir` 默认相对
  `player/`；找不到作品时列出可用名字。
- `tools/pack.py`：位置参数可以是**作品名**（默认输出 `builds/<作品>.love`）、`.bcmkn` 路径，
  或旧写法的输出 `.love`；新增 `-o/--out`、`--list`、`--dry-run`；作品未编译时提示先跑 `kn build`。
- `tools/build_love.py`：改为 `kn build` 的兼容壳（1~2 个位置参数都支持）。
- `tools/pack.sh`：按后缀分派（名字 / `.bcmkn` / `.love`），旧写法保持可用。
- 新增 `tests/tooling_test.py`（22 项）并接入 `tests/all.sh`：名字解析、默认输出、dry-run 不落盘、
  list、错误提示与退出码。README「快速开始」同步改写。

### 追加功能（右上角 KEY 开关：键盘按键显示/隐藏）

- `rt/host/ui_keys.lua`：键盘模拟面板的开关从「右侧中腰 48×48」移到**右上角**
  （AtUI 的 DBG 左侧同一行，58×26，右缘=屏宽-72，窄屏自动左移不出屏）。
- 开关**始终可用**：不再要求 `key_sim=true`。`key_sim=true` 的包面板默认显示；
  其它包默认隐藏、只留右上角 KEY，点一下即可打开（键码仍走 `host:simulate_key_down/up`，
  与真键盘同一路径）。
- 开关按下时颜色变淡提示"已隐藏"。
- 新增 `tests/ui_keys_test.lua`（25 项：右上角布局/窄屏、两种 key_sim 默认值、显隐切换、
  绘制数量）。产物：`builds/texturepen-keytoggle.love`。

### 追加修复（条件槽 = JS 真值：文本 "false" 为真）

- **根因（官方编译器源码，player.main）**：条件槽一律**裸 `if(expr)`**，不做布尔转换：
  - `compile_conditional`（≈4757858）：`if_cond = !if_matched && <expr>`，随后 `if (if_cond) {…}`
  - `compile_wait_until`（4765283）：`while(true){ …; if (<condition>) break; … }`
  - `compile_repeat_forever_until`（4761616）：同上。
  即 **JS 真值**：文本 `"false"`、`"0"` 为真；`0`、`""`、`NaN`、`false`、`nil` 为假。
- **旧实现**：`if` / `wait_until` 用 `V.bool`（Scratch 口径：`"false"`/`"0"` 当假），
  `repeat_forever_until` 用 Lua 裸真值（`0`/`""`/`NaN` 当假）。于是 atkn 介绍3 的
  `等待直到 <过程返回文本 "false">` 被当成"条件未满足"而**空转阻塞**：
  外层的「绘制旋转进度条」只在条件变真（手指按在其圆形区域内）时才再执行一次，
  白点因此只在命中时出现。
- **修复**：`kntl/emit.py` 的 `controls_if` / `wait_until` / `repeat_forever_until` 与
  `rt/core/sched.lua` 的 `when` 条件、`rt/impl/control.lua` 的 `wait_until` 兜底，
  统一改用 `V.js_boolean`（JS 真值）。**字段解析**（拖拽 "0"/"1"、音频循环）仍用 `V.bool`，
  那是官方字段语义，不是条件槽。
- **附带修正**：`repeat_forever_until` 官方是**先跑一轮再判条件**
  （`while(true){ <DO>; if (condition) break; }`，player.main:4761616），
  我们的编译把判断放在体前 → 条件一开始就成立时一轮都不跑。已改为 body-first。
- **验证**：重新编译 `bcmkn/atkn.bcmkn`→`works/atkn.lua` 后，鼠标放在圆圈外时
  `self_point_towards` 10 帧调用 10 次（修复前 1 次）。新增 `tests/text_truthiness_test.lua`
  （`tests/fixtures/text_cond.bcmkn`，8 项：JS 真值 + 循环体先跑）。
- **`procedure_boolean` = 布尔（按用户确认 + 官方归一化）**：`函数_布尔` 过程返回的"成立/不成立"
  是**布尔值**（官方 `processBooleanReturnType`，player.main:1223350 把 HEXAGONAL 返回的
  `"true"/"false"` 归一化成布尔字面量）。编译器现在产出 `true`/`false`（之前误产出文本，
  `"false"` 在 JS 真值下为真 → 条件语义全错）。
- **运动原语 NaN 保护**：移动端抬起后鼠标坐标是 NaN（官方 `setMousePosition({NaN,NaN})`）。
  `self_point_towards` 之前把 NaN 写进 `dir`，随后 `self_go_forward` 把坐标算成 NaN →
  那一笔画不出来。现在朝向/步数/坐标偏移非有限时**不写入**（与已有 `move_to`/`set_position`
  的"NaN 不得污染实体"一致；官方 `moveTargetTo` 同样校验 NaN/Infinity，player.main:2236402）。
  实测：atkn 介绍3 首帧（未触摸）现在能画出 (110,-150) 的白点。
- 产物：`builds/atkn-truthfix.love`。

### 追加修复（计时器两套时钟 / 输入坐标域）

- **计时器**：官方是两套独立时钟，之前混成一套：
  - 「计时器值」(timer) = `TheatreStore.timerValue`（player.main:2100640 / 2474611）：
    秒、两位小数；start/stop/reset 由「执行计时器」(control_timer) 控制；reset = 归零并继续走。
  - 旧版 `get_timer` / `reset_timer` = `timer_block_date`（player.main:4826245），与舞台计时器无关。
  旧实现让 `timer` 也读 `timer_block_date`：`停止` 不生效、`执行计时器` 会误改旧时钟、
  `重置` 只是"顺手"把旧时钟起点清零才看起来对。现在按官方拆分，并用墙钟差值计算（不再是 dt 累加，
  掉帧/后台回来不漂）。
- **输入坐标域**：`screen_to_world` 之前固定按 contain 反算，而绘制按 `stage_fit`
  （contain/cover/stretch）—— cover/stretch 下"画在这里、点在那里"。现在两边共用
  `Coords.fit_axes`，并新增三种模式的往返测试。
- **输入命中域**：指针只在**整个舞台 hitArea** 内更新（官方 `stage.hitArea = Rectangle(-w/2,-h/2,w,h)`）；
  黑边按下不再产生 `stage:mousedown`；抬起在舞台外时保留最后一次舞台内坐标（PC 语义，
  官方 `mouseupoutside` 不改坐标）。
- 测试：`timer_semantics_test` 重写为两套时钟（14 项）；`coords_test` 增加 contain/cover/stretch
  （27 项，并修正"汇总提前打印、末尾 4 项不计分"的旧问题）。
- 产物：`builds/atkn-inputfix.love` 供真机复验。

### 追加修复（nodevm：缩放角色点不中）

- **根因**：`rt/hit.lua` 的像素反变换把「纹理半宽」当成「显示半宽」再除 scale：
  `i = r.x-n.x + texture.width/2; round(i/scale.x)`。官方用 PIXI `Sprite.width`
  （= `|scale| × texture.width`，main-vendors:694860），等价 `round(r.x/scale.x + texture.width/2)`
  （player.main:5447038 / crc_libs:1172650）。scale=0.2、纹理 100×100 时中心被映射到 (250,250)，
  纹理只有 100×100 → 永远越界 → `is_touching` 恒 false，点击/碰撞全部失效。
- `coord_in_texture` 改为 `r + texture*scale/2`；`texture_probe` 的 `offx/offy` 同步修正。
- `Hit.overlaps` 的每帧碰撞缓存在 `game.frame == nil` 时 `cache=nil` 会崩，一并加健壮性判断。
- 回归：`tests/hit_test.lua` 增加 scale 0.2 / 2.0 / 旋转+缩放 / 左右半透明区分 / 碰撞 /
  真实点击路径（不强制 sprite_id）共 14 项；全量回归 0 失败。
- 产物：`builds/nodevm-clickfix.love`（20.4MB, sha256 `14d63ba8…2e813f`）供真机复验。

### 复核后确认「原实现正确 / 证据不足暂不改」

- `get_mouse_info`：LÖVE 宿主 `pointer_valid` 初值就是 `false`（`rt/host/love.lua:22`），
  官方 `getMousePosition() ?? {NaN,NaN}` 的 NaN 语义已经满足。
- `text_select` 的 `end_index` 判定：官方用的是 **isUndefined**（模块 32790 `t.Z = e => void 0===e`），
  不是 isNaN —— 现有 `== nil` 是对的。
- `wait` 的 `nan_to_zero_conversion_blocks`、`lists_get_value` 的 legacy 开关依赖作品/播放器级配置，
  现有夹具里没有该字段，证据不足，本轮不改。


### 目录整理（A 档，零行为改动）
- `player/dist/`（378MB .love 产物）→ 仓库根 `builds/`，并更新 README / `tools/build_love.py` 示例。
- `git/`（68MB 整仓重复快照）→ `archive/snapshots/git-20261023/`，不再混在源码树。
- `player/NOTES.md`（224KB）→ `player/docs/NOTES.md`，补目录索引与路径迁移说明。
- `archive/backups/backup/*` 拍平为 `archive/backups/*`；重复的 `SHARE_GUIDE.md`、
  `love_color_candidate_20261021.lua` 移入 `archive/refactor/duplicates/`（保留单份）。
- 回归：`sh tests/all.sh` 通过（61 个 lua 测试 × lua5.1/luajit + Python 门禁）。

### 代码模块化（B 档，对外 ABI 不变）
- `rt/impl/op_sensing.lua`（929 行）→ `math` / `text` / `sensing` / `time` / `screen` 五个域文件。
- `rt/impl/motion_looks.lua`（808 行）→ `motion` / `looks` / `pen` + `common`（常量与内部工具）。
- `rt/core.lua`（1460 行）→ `rt/core/{state,entity,thread,sched,game}.lua`，`rt/core.lua` 只做装配。
- `rt/init.lua` 改为注册新模块；`op_sensing` / `motion_looks` 保留为兼容 re-export（旧 `require` 不变）。
- 回归：同一套全量测试 0 失败；`registry_test` 同名覆盖门仍为 0 冲突。

## 0.1.0-test.1 — 2026-10-23

首个 HateNeko 项目测试版本。

### 运行时 / 语义
- KittenN `.bcmkn` → Lua 编译器（Python）与 LÖVE 11.5 运行时。
- JS 数字转字符串、文本 UTF-16、`convert_type`、列表索引、公式计算、JS 取模/逻辑。
- 点击/按键动作状态机，`sync_tell` 按官方语义改为同线程内联，修复 render 过程中间态。
- 音频等待轮询、文本特效阻塞、图片印章特效、背景 NONE 适配、失焦释放输入。

### 工程 / 测试
- `sh tests/all.sh`：62 个测试文件 × lua5.1/luajit，Lua 846 项/VM + Python 175 项，0 失败。
- 原语注册表 + schema 覆盖门；硬件/AI 块显式离线清单。
- 单作品打包：必带 `At/`，只收作品素材闭包，支持 `--key-sim`。
- 性能优化：效果画布池、alpha 采样、克隆候选缓存、k3t V2 常量表/运行时快路径。
- 代码结构整理：开发日志/备份归档到 `archive/`，官方参考到 `reference/`，
  发布包到 `player/dist/`，旧包/探针到 `player/archive/`。

### 后续修复（0.1.0-test.1）
- 修复 `self_listen_with_param` 在自身运行中广播丢事件：pending 广播在实例结束后用新参数续播。
- `图片渲染技术`（`bcmkn/picture.bcmkn`）可完整绘制全图（309 行）。
- 块目录补 `reset_timer`（267 条）。
- AtLua 超长列表虚拟化（列表弹窗不再为每一项建组件）；`get_timer/reset_timer` 按官方墙钟秒语义。
- 弹窗半高/文本顶部/长文本分页/选择框 2×2；弹窗期间舞台输入完全隔离。
- ask 输入框卡片外，带点击 hat 的可见舞台角色允许透传（nodevm 输入覆盖层）。
- AtLua TextInput 支持 UTF-8 光标、选择、Home/End/Delete、点击定位、水平滚动、剪贴板。
- 打包脚本支持一站式：`sh tools/pack.sh <作品.bcmkn> <输出.love>` 自动编译并打包。

### 已知限制
- 硬件/在线 AI 类积木不支持；绘制/GPU/触摸/音频需真机验收。
- 源码包不包含 `player/works/assets` 大素材，需按作品重新编译/同步。
