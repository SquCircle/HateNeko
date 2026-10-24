# NOTES — 移植工程长期记忆

> 目录整理后：官方参考在 `../reference/`（bundle/analysis/atlua），开发日志/备份在
> `../archive/`；正文中的 `bundle/`、`analysis/`、`../work/` 是历史路径记录。
>
> **本文件位置**：`player/docs/NOTES.md`（2026-10-24 从 `player/NOTES.md` 迁入）。
> 同期目录迁移：`player/dist/` → 仓库根 `../builds/`；`git/`（整仓快照）→
> `../archive/snapshots/git-20261023/`；`archive/backups/backup/*` → `../archive/backups/*`；
> 重复的 `SHARE_GUIDE.md`、候选 `love_*.lua` → `../archive/refactor/duplicates/`。
> 正文里出现的 `dist/`、`../work/` 都是**历史路径**，不代表当前结构。
>
> **2026-10-24 代码模块化（B 档）**，正文里的旧模块路径按此映射：
> - `rt/impl/op_sensing.lua` → `rt/impl/{math,text,sensing,time,screen}.lua`（旧文件保留为 re-export）
> - `rt/impl/motion_looks.lua` → `rt/impl/{motion,looks,pen,common}.lua`（同上）
> - `rt/core.lua`（1460 行）→ `rt/core/{state,entity,thread,sched,game}.lua` + `rt/core.lua` 装配层
> - `rt/init.lua` 的注册表已改为注册新模块；`op_sensing`/`motion_looks` **不再注册**，只给旧 require 用。
> - 对外 ABI 不变：`rt.f`、`rt.core.SIG/now_ms/diag/warn/copy_value`、`ML.draw_rotation` 等。
>
> **2026-10-24 R1 审计修复（已改的行为）**——正文 §1 表里这些条目的旧结论已过时：
> - 切屏：旧屏线程**冻结**而不是杀掉；只有 `on_running_group_activated` 销毁；切屏后的语句同帧继续
>   （`rt/core/sched.lua:thread_in_running_group`、`rt/impl/screen.lua`）。
> - `收到广播`：读全局 `game.bcast_state`（one_frame，每帧开始清空），不再读 `th.event`。
> - 宽度/高度：`getSceneOrActorProperty` = `round(100*scale,2)`（百分比），**不是像素**；
>   `get_clone_index_property` / `on_bump_actor_value` 已统一。
> - 透明特效写 `actor.alpha`（官方 `s` 函数），`effect_of_sprite(1)` = `visible ? 100-alpha : 100`。
> - `lists_is_exist` 用宽松相等；`text_contain` 对 NaN 返回 false；`set_sprite_style` 取整；
>   `self_ask` 数值正则与官方一致；`bump_into_body_part` 归为离线（人体识别）。
> - **计时器**：官方两套独立时钟——`timer`（计时器值）= TheatreStore.timerValue（秒/两位小数，
>   由「执行计时器」start/stop/reset；player.main:2100640/2474611）；`get_timer`/`reset_timer` =
>   timer_block_date（player.main:4826245）。旧实现把两者混成一套，现已拆分（`Game:stage_timer_*`）。
> - **条件槽真值**：官方 `compile_conditional` / `compile_wait_until` /
>   `compile_repeat_forever_until` 都是裸 `if(expr)` → JS 真值（文本 "false" 为真）。
>   `controls_if`/`wait_until`/`repeat_forever_until`/`when` 条件统一用 `V.js_boolean`；
>   字段解析仍用 `V.bool`。`repeat_forever_until` 官方是 body-first（`while(true){DO; if(cond)break;}`）。
>   `procedure_boolean` = 布尔（官方 `processBooleanReturnType` 归一化，player.main:1223350）。
>   运动原语遇 NaN 不写入（`self_point_towards`/`go_forward`/`change_coordinate`；
>   官方 `moveTargetTo` 校验 NaN/Infinity，player.main:2236402）。
> - **发布 0.2.0**：`tools/release.py` 一条命令产出 源码 zip（760 文件/28.7MB）+ 演示
>   `.love`（nodevm/20.4MB）+ RELEASE.md + SHA256SUMS；源码包含 `kn` 与 `bcmkn/`，解压即
>   `./kn build nodevm`。不含 reference/、archive/、now 的 190MB 素材。
> - **工具链**：`./kn build <作品名>` 一站式（compile→pack，默认 `builds/<名>.love`）；
>   `kntl.compile` / `tools/pack.py` 都接受作品名，路径可省；`tests/tooling_test.py` 守门。
> - **右上角 KEY 开关**：键盘模拟面板（WASD/方向键）默认按 `key_sim` 显示；
>   开关始终在右上角（DBG 左侧），点按切换显隐，键码走 host:simulate_key_down/up。
> - **输入坐标域**：`screen_to_world` 与绘制共用 `Coords.fit_axes`（contain/cover/stretch 一致）；
>   指针只在舞台 hitArea 内更新，黑边按下不再产生 stage:mousedown（官方 stage.hitArea）。
> - 复核后**未改**：`get_mouse_info`（已经是 NaN 语义）、`text_select` 的 end_index（官方是 isUndefined）、
>   `wait`/`lists_get_value` 的 legacy 开关（缺作品级配置证据）。
>
> 新对话先读本文件，不要从聊天记录推断。
> 源项目 = `bundle/`（KN 编辑器/引擎 bundle）。目标 = `player/`（Python 编译 + LÖVE 运行时）。
> 引用约定：bundle 的 JS 是**单行压缩**文件，行号统一写 `:1`，并用「byte N」给偏移；`analysis/` 内的文本有正常行号。

## 目录

- §1 源 → 目标映射（最新）——**先读这一节**
- §2 已完成 / 进行中 / 阻塞
- §3 已知可疑点（未验证的假设 → 需数值验证）
- §4 诊断脚本用法 / 上次快照数值
- §5 待办事项（挂起）

> §3、§4 下有 261 个 `###` 小节；按需检索而不是通读：
> `grep -n "^### " docs/NOTES.md`、`grep -n "关键词" docs/NOTES.md`。

---

## 1. 源 → 目标映射（最新）

状态：✅已实现 / ◐半实现 / ✗缺失 / ⚠可疑（有依据但需数值复核）

| 源（bundle / analysis） | 语义 | 目标 | 状态 |
|---|---|---|---|
| `bundle/static/js/main.15ba0757.js:1` byte≈2955000 `.d.ts` 块 ABI | 块类型 → 参数名/isEvent/callee | `player/kn_spec/block_catalog.json`（265 条）、`player/kntl/spec.py`、`player/tools/gen_block_catalog.py` | ✅（生成物；`--dump-dts` 可复现） |
| 同上 byte≈793974 / 1141900 块定义与下拉枚举 | 事件/运动/外观/侦测下拉的真实取值（如 rotation_type=0/1/2、time=year…second、swipe=up/down/left/right） | `player/kntl/emit.py` 的参数收集；`player/rt/impl/*.lua` 的键名解析 | ◐ 多处键名/枚举不一致（见 §3、§4） |
| 同上 byte 1597856–1688231（159 个 `(0,c.Z)(t,u.NS.name,…)`） | 官方 sprite 侧块实现（运动/外观/画笔/音频/列表/文本特效/摄像头…） | `player/rt/impl/motion_looks.lua`、`ui.lua`、`audio.lua`、`data.lua`、`op_sensing.lua` | ◐ 已抽到 `work/bundle_impls.txt`（研究副本），逐条对照中 |
| 同上 byte≈1552000–1553000、1639000 | 询问/选择/气泡弹窗（阻塞 + thread_lock + CHOICE0..3 + index/content） | `player/rt/impl/ui.lua` | ✗ 只打日志/立即返回；无 CHOICE、无 index |
| 同上 byte 1645809–1646546 `fw.selfTextEffect*` | 角色作为文字显示（text/size/color，size 1..2000，阻塞） | 无 | ✗ `now` 缺 3 个原语 |
| 同上 byte 1609639 `um.setTopBottomLayer` | 角色/画笔层序（peak=children 末尾=最上） | 无；`player/rt/scene.lua` 只用 order 排序 | ✗ 且 order 方向反了（见 §3-G6） |
| 同上 byte 1547801 `zW.getCloneIndexProperty` | 按克隆编号取属性（`getSceneOrActorProperty`，支持 x/y/…） | `player/rt/impl/event.lua:35` | ◐ 只认 "0".."6"，`now` 传 "x"/"y" 全返回 0 |
| 同上 byte 1541124 `on_bump_actor_value` | 从碰撞事件取被碰角色属性 | `player/rt/impl/event.lua:54` | ◐ `event.attr` 从未被赋值 → 恒 0 |
| `bundle/static/js/crc_libs.cce421af.js:1` byte≈864300 Config | max_warp_iterations=30000 / warp_time_limit=4ms / clone=300 | `player/rt/core.lua:12-17` | ✅ 常量一致 |
| 同上 byte 828619 `block_metadata` | `finish_out_of_run_group=["on_running_group_activated"]`、`restart_when_finished=["self_listen","self_listen_with_param","when"]` | `player/rt/core.lua:297-308`、`fire/fire_green_flag` | ◐ 表已抄；`fire_when`（core.lua:446）绕过 restart 守卫 |
| 同上 byte≈821800–826700 core domain 表（54 函数） | 文本/逻辑/数学/变量/广播/事件/控制/列表/calculate | `player/rt/impl/{op_sensing,data,control,aliases}.lua` + `analysis/official_domain_fns.txt` | ◐ `calculate`、`text_select`、`text_length`、`get_time`、lists 语义偏离 |
| 同上 byte 884500 / 836600 interpreter loop | warp 迭代/时间预算、wait_until 为 LOOP_BLOCK（条件真→Done，否则 Yield） | `player/rt/core.lua:162-205,570-630`；`player/kntl/emit.py:400-530` | ◐ `wait_until` **未内联**（emit 无该分支）→ 运行期 no-op |
| 同上 byte 1131200–1132000 actor transform | `anchor=.5`、y 取负、`set_pixi_rotation(-rotation)`、`Math.max(0,scale)`、LEFT_RIGHT 翻转状态 | `player/rt/host/love.lua:503-599`、`player/rt/hit.lua`、`player/rt/impl/motion_looks.lua:142` | ◐ LEFT_RIGHT 边界/持久翻转状态不等价 |
| 同上 byte 1167790 / 1172650 / 1170504 | `is_touching` 像素 alpha、AABB→2px 采样(≥5)、同 scene/visible、overstep 全出边 | `player/rt/hit.lua:29-224`、`player/rt/impl/op_sensing.lua:378-434` | ◐ 几何层接近；像素/透明度/旋转采样未验证，headless 无像素 |
| 同上 byte 1149891 / 1150325 brush stamp | `draw_text_stamp(text,size,align,rotation)` 画进**笔层**；`draw_image_stamp(true)` 画处理后的完整外观 | `player/rt/host/love.lua:763-797,933-1017` | ✗ 文字印章每帧重画、不进笔层、忽略 rotation/align；图片印章不处理特效 |
| 同上 byte 1133649 `update_adaptive_scale` | NONE：两轴都小于舞台才放大(max)，否则 1:1；CONTAIN/COVER/STRETCH | `player/rt/host/love.lua:445-478`、`rt/host/background.glsl` | ⚠ NONE 恒 1:1；CONTAIN 仍密铺整个舞台；滚动的 y 符号需实测 |
| `analysis/official_player/player.main.63b4a46c.js`（补充 oracle） | 官方播放器 core domain 逐字表 | `analysis/official_domain_fns.txt`、`analysis/kn_math_expr.js.txt` | 仅研究参考，不进包 |
| `bundle/static/media/**`、`bundle/static/css/**`、`bundle/index.html`、`bundle/ffmpeg/**`、`bundle/worklet/**`、`bundle/static/js/main-vendors.*` | Web 编辑器 UI/素材/转码/Worker/PIXI，与播放器图形栈绑定 | 不移植；由 LÖVE/宿主替代 | 明确不在移植范围 |

---

## 2. 已完成 / 进行中 / 阻塞

### 已完成（本对话接手前已存在，本次只做勘察与验证，未改业务代码）
- Python 编译器 + 265 条块规格表 + 15 个 fixture 编译链。
- LÖVE 运行时骨架：编译产物 ABI、调度器、场景门、坐标三层、素材/SVG 管线、打包脚本。
- headless 测试链（Lua5.1/LuaJIT）与真机 diag/panel 工具。

### 已完成（本对话）
- 阶段 A 勘察：源→目标映射、可观测性缺口、G1–G10 归组（见 §1/§3）。
- G3-1 证伪 + G5-1/G5-2/G9-2 连带降档（见 §3.13、§4.9）。
- C0 元 bug 修复：all.sh 退出码、compile_test 临时目录、run.lua 夹具、pycompile 失败检测。
- C2 七条最小验证：全部有数值结论（见 §4.9）。

### 进行中 / 待批
- C1-a（G2-1/G2-2/G1-1/G1-2/G9-1/G6-3）：主体已按用户判定通过；hit_test 已补“裸 table 用 game.entities 位置兜底”，`all.sh` 恢复 `EXIT=0`（见 §4.10/§4.11）。
- C1-c（雪克隆累积）：已完成诊断，结论“作品自身持续性雪 + 慢速下落，dispose 正常；非无限泄漏”，未修（见 §4.11）。
- C1-b（G4-4/G4-7/G6-5/G7-6边界/G10-8/G4-6）：已执行，`all.sh EXIT=0`；见 §4.14。
- B-order：用户实测确认“跨角色同帧按创建顺序”，已改 `emit.py:703/735` 为 JSON 插入顺序，新增 `hat_order_test.lua`，全部 works 已重编译；`all.sh EXIT=0`。见 §4.15。
- B1 逐实体绘制 dump：headless 部分已落地（§4.17），真机部分随包 2 验收；`draw_dump_test.lua` 32/0。

### 阻塞
- 真机 LÖVE 不可在本环境运行（无 `love` 可执行、无显示器）；所有视觉/音频结论必须由用户在真机跑诊断包回贴数值/截图。

---

## 3. 已知可疑点（未验证的假设 → 需数值验证）

1. **渲染/命中图层序反了**（高置信）。`scene.lua:41-47` 画的顺序是 order 大的先画（=底层），`scene.lua:60-67` 命中是 order 小的先命中；官方 `setTopBottomLayer` 以 `get_actor_ids()` 末尾为 peak（`main.15ba0757.js` byte 1609639），`get_actor_ids` 返回 children 顺序（`crc_libs` byte 1141200），即 **order 大 = 上层**。
   数值反证：构造 order=1/2 两角色，`render_list` 返回 `top(order2) -> bottom(order1)`，`hit_list` 返回 `bottom -> top`。
2. **headless 时间预算失真**。`budget_warp` 用 `now_ms()`，headless 的时钟按帧推进（`headless.lua:22-29`），warp 内时间永远不涨 → 每帧跑满 30000 次；`tests/run.lua:47` 还把这个值当期望。真机/LÖVE 时钟推进，行为不同。
3. **克隆体 render/hit 次序不稳**。`Entity:clone_self`（core.lua:103-127）复制父体 `seq`，排序键相同；PIXI 克隆体默认加在父体之后（更上）。
4. **文本长度/切片按字节**（`op_sensing.lua:294-296,248-279`），JS 是 UTF-16；中文/emoji 会差 3 倍，且 `string.sub` 可能切出非法 UTF-8（LÖVE `print` 会抛错）。
5. **`self_set_effect` 单位/范围**：官方 hue 0..360、brightness 0..200、pixelate≥1、twist/ripple 0..100（main.15ba byte 1751300）；`sprite.glsl` 的 brightness 用 `v/100-1`、twist 直接当角度。需按官方滤镜实测。
6. **`image_stamp`/`pen_stamp` 不处理角色特效**（只乘 alpha），官方传 `true` 走 processed image。
7. **`bump_into(--mouse)` 要求 mouse_is_down**（`op_sensing.lua:335-342`）；官方用 `getMousePosition()` 后判 NaN，不要求按下。
8. **clone 是否能收到广播/tap**：官方 `clone_target_do_add_responder_interpreters=false`；我们 tap 会把命中克隆体当 `self` 跑本体 hat（core.lua:350-357），广播则只跑本体。`now` 的克隆体多，需实测。
9. **`Sched:fire_green_flag` 的去重语义**（core.lua:394-415）：重进同一屏时"同一顶 hat 已在跑就不重启"，官方是否重启该屏解释器未取证。
10. **`push("all")` 状态护栏**：`H:draw` 进出平衡，但 `pen_stamp` 的 push 在 `end_frame` 收（love.lua:179-184），若同一帧 `pen_clear` 再 `pen_stamp`，状态栈顺序需实测。
11. **`self_set_pen_color_property` 的 hue/sat/bright 存进 `pen.*` 但绘制完全不读**（`love.lua:810-811` 只用 `pen.color`）。
12. **`self_gradually_show_hide` 起始 alpha**：官方从当前 alpha 渐变（`main.15ba` byte 1748404）；我们 `from = visible and 100 or 0`，当前 alpha=50 时仍从 100 开始。
13. **悬案：now 的 NaN 实体（总PP / 星 / 支持者内容）**。G3-1 已证伪：`get_mouse_info` 未按下返回 NaN 是**刻意语义**（官方 `player.main.63b4a46c.js:1` byte 1563856 直接取 `getMousePosition()`，无值即 NaN；`rt/impl/op_sensing.lua:521-524` 的注释也写明），不再归因于本原语。NaN 实体改为**作品语义层，待查**：B1 绘制 dump 落地后，从 f210 起逐帧记录这三个实体的 pos/scale/rot 来源（B1 日志里单独一个 tag），单独追一条；在数值证据出来前，禁止把它重新挂回 `get_mouse_info`。

---

## 4. 诊断脚本用法 / 上次快照数值

### 4.1 环境
- 本机：`lua5.1`、`luajit`、`python3` 可用；`love` **不可用**。
- 工作目录：`player/`；临时目录用 `player/.tmp`（`/tmp` 不可写，已见 `compile_test` 崩）。

### 4.2 一键回归
```sh
cd player
sh tests/all.sh; echo EXIT=$?
```
C0 已修：不再用 `| tail -3` 吞掉退出码；任一 Lua 测试非 0 → `status=1`。故意在 `units_test.lua` 末尾加 `error()` 验证：`EXIT=1`，日志含 `^^ tests/units_test.lua 退出码 1`。正常全量：`EXIT=0`，`run.lua` 35 项 / 0 失败（两端）。
```sh
cd player
for t in tests/*.lua; do echo "--- $t"; lua5.1 "$t" >/dev/null 2>&1; echo "exit=$?"; done
```
历史状态（C0 前）：`compile_test.lua` 崩在 `tests/compile_test.lua:37`（写 `/tmp` 失败）；`run.lua` 因缺夹具整体跳过。C0 后：`compile_test` 写 `.tmp/mini_compiled.lua`；`run.lua` 用 `tests/fixtures/test_basic.lua`，缺夹具则 `os.exit(1)`。Python：`svg_size_test` 5 项、`test_compile` 111 项全过。

### 4.3 单作品试跑（真编译 + headless）
```sh
cd player
lua5.1 tools/trywork.lua tests/fixtures/now.bcmkn 600
```
上次 15 个 fixture 各 600 帧：未知块/缺失原语/运行错误全 0；`big2` 9.0s、`new1` 13.0s、`new2` 9.4s（lua5.1 CPU 基线）。

### 4.4 now 关键数值（最重要）
```sh
cd player
# 需要先放好 ../work/probe_now.lua（本次勘察生成；阶段 B 会改成 tools/）
lua5.1 ../work/probe_now.lua
```
上次 300 帧：
- f60–f200：`ents=110 thr=2 errs=0 step=0.1–0.4ms`
- f240：`step≈1317ms`，`thr=86`，NaN 实体 = `总PP, 星, 支持者内容`
- 缺失原语（`M.requires` 静态检查）：`self_text_effect_color/self_text_effect_size/self_text_effect_text/set_top_bottom_layer`
- 慢线程定位：`on_running_group_activated@歌词` 单次 resume 1.1–1.7s，栈为 `works/now.lua:480 proc_eb9a…` 的 warp 循环。

### 4.5 假设验证（本次已做，未改 player 代码）
```sh
cd player
env FIX_LIST=1      lua5.1 ../work/hyp_test.lua
env FIX_LIST=1 FIX_MOUSE=1 lua5.1 ../work/hyp_test.lua
```
- 只修 `list_copy` 写回 `target_list`：f240 从 **1317ms → 3.5ms**，warp 线程正常结束。
- 同时把 `get_mouse_info` 改成“返回最后指针位置”：NaN 实体列表变空。**但 G3-1 已证伪**：官方未按下就是 NaN，这个替换是反语义的，只能证明“改了行为”，不能证明原行为错。
- 结论：`list_copy` 不写目标 → `7d5c…` 列表长度为 0 → `proc_eb9a` 的 `while index ~= list_length` 永不满足（warp 死循环）。NaN 实体改挂**作品语义层，待查**（见 §3.13），不再挂在 `get_mouse_info`。

### 4.6 渲染/命中序数值快照
```sh
cd player
lua5.1 - <<'LUA'
package.path="./?.lua;"..package.path
local rt=require("rt.init"); local H=require("rt.host.headless"); rt.set_host(H.new())
local w={stage_w=100,stage_h=100,cur_scene="s1",vars={},screens={{id="s1",styles={}}},
  actors={{id="a1",name="bottom",scenes={"s1"},order=1,styles={}},
          {id="a2",name="top",scenes={"s1"},order=2,styles={}}},assets={},audios={},
  register=function() end}
local g=rt.load(w,require("rt.host.headless").new())
local l=require("rt.scene").render_list(g); local o={} for _,e in ipairs(l) do o[#o+1]=e.name end
print("render bottom->top: "..table.concat(o," -> "))
local h=require("rt.scene").hit_list(g); o={} for _,e in ipairs(h) do o[#o+1]=e.name end
print("hit top->bottom: "..table.concat(o," -> "))
LUA
```
上次输出：
```
render bottom->top: top(order=2) -> bottom(order=1)
hit top->bottom: bottom -> top
```
与官方 order 大=上层 相反。

### 4.7 真机取证（用户跑）
```sh
cd player
sh tools/pack.sh knplayer-diag.love --diag
# 安装/打开 knplayer-diag.love，跑问题场景后把 probe_out/ 或 knplayer_diag/ 整个目录回贴
```
包内 `diag.on` 触发 `rt/host/diag.lua`：按帧 1/30/60/120/240/480/900/1500 写 `state_XXXX.txt` 与截图；日志 `diag.log`；落盘路径见 `meta.txt`。
**当前 diag 的已知失真**：`state` 里 `e.scale` 字段已废弃（`diag.lua:117` 恒 100）；panel 的列表页读 `game.lists`（`panel.lua:239`），而编译器的列表实际在 `game.vars`（`kntl/emit.py:666-688`），所以列表页恒空。

### 4.8 诊断工具现状
- `profiler.lua` 用 `debug.sethook`，只挂在主协程，调度器的协程不继承 → 实测主线程 0 样本；对 `thread.co` 手动挂 hook 后同一负载 300 样本（C2/G10-8）。
- `tools/pycompile.lua` 已修：区分 Lua 5.1（数字返回码）与 5.2+（true,"exit",code），失败时带 Python 日志；`assert(ok ~= nil and ok ~= false)` 的旧逻辑已删除。
- `main.lua` 的 `LoveProbe` 硬编码了 now 的 UUID/帧号（`main.lua:175-204`），不能复用到其它作品。

### 4.9 C0 / C2 验收记录

#### C0 改动文件
| 文件 | 改动 | 验收 |
|---|---|---|
| `tests/all.sh` | 用 `out=$(...); rc=$?` 取真实退出码；非 0 打尾 20 行并 `status=1` | 故意在 `units_test.lua` 末尾 `error()`：`sh tests/all.sh` → `EXIT=1`，日志含 `^^ tests/units_test.lua 退出码 1`；恢复后 `EXIT=0` |
| `tests/compile_test.lua` | 测试产物从 `/tmp` 改到 `.tmp`（`KN_TMPDIR` 可覆盖），写入失败给出明确 assert | 产物 `player/.tmp/mini_compiled.lua` 生成；Lua5.1/LuaJIT 均不再崩 |
| `tests/run.lua` + `tests/fixtures/test_basic.lua` | 重建手写夹具；缺夹具从“跳过 exit 0”改成“FAIL exit 1” | `lua5.1/luajit tests/run.lua` → 35 项 / 0 失败；删夹具会非 0 |
| `tools/pycompile.lua` | 新增 `exec_ok()`；stderr 落临时日志；失败抛 Python traceback | `compile("tests/fixtures/does_not_exist.bcmkn")` → `Python 编译失败(256): ...` + `FileNotFoundError`，不再是“读不到临时文件” |

#### C2 七条结果
| 项 | 命令 | 预期（官方） | 实际 | 结论 |
|---|---|---|---|---|
| G4-6 | `lua5.1 ../work/c2_get_time.lua` | date=18、weekday="Sunday"、weekday_num=7 | date=57、weekday=0、weekday_num=57（当天 2026-10-18 Sunday） | [复现] |
| G4-4 | `lua5.1 ../work/c2_rotation.lua`（切到屏幕 1c387224…） | `args.rotation_type=2` → 实体 rotation_type=NONE(2) | 实体 “打击、小姐、难度” 调用：`before=nil after=all`；65 个实体为 `all`、105 个 nil | [复现] |
| G4-7 | `lua5.1 ../work/c2_swipe.lua` | 只触发 `v_up` | `v_up/v_down/v_left/v_right` 全部 =1 | [复现] |
| G6-5 | `lua5.1 ../work/c2_ask_choice.lua` | 阻塞到选择；content="B"，index=2 | 同帧 `after=1`，`content=B index=B`，`threads after frame1 = 0` | [复现] |
| G7-6 | `lua5.1 ../work/c2_leftright.lua` | 90° flip=true；-270° flip=true；100/180 保持 true | 90° false、-270° false；100/180/0 两次均与官方一致 | [复现] 边界；**“无状态导致持久化差异”子结论 [已证伪]** |
| G8-1 | `lua5.1 ../work/c2_textlen.lua` + Python UTF-16 oracle | 中文=2、😀=2、中文😀=4 | 中文=6、😀=4、中文😀=10 | [复现] |
| G10-8 | `lua5.1 ../work/c2_profiler.lua` | 主线程 hook 看不到协程 | A 主线程 samples=0；B 对 `thread.co` 挂 hook samples=300 | [复现] |

C2 脚本位置：`work/c2_get_time.lua`、`c2_rotation.lua`、`c2_swipe.lua`、`c2_ask_choice.lua`、`c2_leftright.lua`、`c2_textlen.lua`、`c2_profiler.lua`（研究副本，不进包）。

#### C2 补充（3 个搭车细节）
- `get_time("weekday")` 官方返回 **本地化日名字符串**：`case"weekday":i="week.names".concat(o.getDay()),(0,y.rj)(i)`（byte 1565722）；`week.names0..6` 在 bundle 里有 en `Sunday..Saturday`、zh `星期日..星期六`、fr `Dimanche..Samedi`。所以 0/SUN 都不是该格式；`weekday_num` 是 `getDay()||7`（Sunday=7）。C2 的 `weekday=0`、`weekday_num=57` 均错。
- `askAndChoose`/`selfAsk` 官方先 `s.get_thread_lock(entity, interpreter)`，等待期间线程 **alive 且 blocked**；按钮/提交 callback 写入 choice/index（index=i+1）后 `c.stop()` 释放，同一线程继续。最终 `threads=0` 是正常结束，不是误杀；C2 的 `threads after frame1=0` 说明**根本没有阻塞**（frame1 就跑完了）。
- `tests/fixtures/test_basic.lua` 是**自拟参考夹具**，不是 oracle 对齐。以下 4 类是按运行时代码/现有测试期望构造的读码推断：① 每帧 warp 30000 次（headless 虚拟时钟导致 4ms 预算永不触发，是已知失真）；② wait 0.05s 的帧数；③ 广播/克隆/tell/作用域/列表/break/when 的调度次序；④ 只有 2 个实体（无 screen）以匹配 `tests/run.lua:40`。它只能当当前运行时的回归，不能当官方语义证据。

### 4.10 C1-a 执行记录（验收未通过，已停手）

改动：
- G2-1 `rt/impl/data.lua:281-295`：`list_copy` 解析源/目标（table 或 key），清空目标后逐项写入并 `bump`；不再返回新表。
- G2-2 `rt/impl/data.lua:334-365`：`list_index_of` 严格 `l[i] == v`；`list_is_exist` 按源宽松：`V.eq(l[i], raw) or V.eq(l[i], V.str(raw))`（**按源宽松，非任务包原指令**）；`list_is_exist_slow` 指向同一实现。
- G1-1 `kntl/emit.py:451-459`：`wait_until` 内联为 `while not V.bool(cond) do th:iter_n() end`。
- G1-2 `rt/impl/op_sensing.lua:558-574`：`reset` → `timer=0; timer_running=true`。
- G9-1 `rt/core.lua:699-701`：`Game.new` 的 `timer_running=true`。
- G6-3 `rt/scene.lua:33-68`、`rt/core.lua:117-122`：render 按 layer↑/order↑/seq↑，hit 严格反序；克隆体分配新 `seq`。
- 新增 `tests/fixtures/wait_until.bcmkn`、`tests/wait_until_test.lua`、`tests/layer_test.lua`，并加入 `tests/all.sh:12`。

验收原始结果：
- 编译 now：`输出：works/now.lua（5010 行 / 750.6 KB）`。
- hyp_test：f240 `step=4.5ms`（<10ms，通过）；`lyric=2`，但 warp 线程已结束（`warp_frames=0`，栈在 `works/now.lua:497` 的 timer 等待，不是 warp 循环）。
- probe_now：f240 `thr=86`、f300 `thr=91`；继续跑 f400 `thr=97`、f600 `thr=100`。失败：未回落，且缓慢增长；增长来自 `雪` 克隆线程（13→19→24），`歌词` 仍为 2（其中一个在等 timer）。
- wait_until_test：7 项 / 0 失败（`v_immediate=1` frame1，`v_after` 先 0 后 1，`v_timer=1`）。
- layer_test：5 项 / 0 失败（render `bottom,top`；hit `top,bottom`；父体→克隆 / 克隆→父体）。
- `sh tests/all.sh`：`EXIT=1`；`tests/hit_test.lua` 两端失败 “重叠时取最上层”，原因是 `hit_test` 用无 `seq` 的裸 table，而 `bottom_first` 取消了旧的 `_idx` 兜底。按指令未再改。
- 完整日志：`work/all_c1a.log`。

### 4.11 hit_test 依据 + C1-c 雪克隆诊断

#### hit_test（实现补兼容，测试未动）
- 官方没有“实体无 seq/order/layer”这个状态：每个 actor 都是 PIXI `actor_container` 的 child，位置由 children 顺序定义。
  - `get_actor_ids()` 返回 children 顺序：`crc_libs:1` byte 1141200。
  - `set_z_index` 把 0..children.length-1 作为 z：`crc_libs:1` byte 1162523。
  - 命中遍历从 children **末尾往前**：`main-vendors.1c189299.js:1` byte 609721 `for(var u=t.children,c=u.length-1;c>=0;c--)`。
- 所以官方有确定行为（创建/children 次序），不是“未定义”。真实实体在 `Entity.new` 一定分配 `seq`（`rt/core.lua:45-46`）；`hit_test.lua` 的裸 table 绕过了这个不变量。
- 处理：`rt/scene.lua:37-44` 的 `bottom_first` 增加 `a.seq or a._idx or 0` 兜底；`render_list`/`hit_list` 都写 `_idx = game.entities 位置`。测试文件未改。
- 结果：`lua5.1 tests/hit_test.lua` 11/0；`lua5.1 tests/layer_test.lua` 5/0；`sh tests/all.sh` → `EXIT=0`。

#### C1-c 雪克隆数值（无修改）
- 作品：`works/now.lua:3425-3444` 雪的主 hat 每轮 `mirror(--self)`，非冬季 `wait 0.15s`（约 10 帧一个）；克隆脚本 `3446-3459`：未碰到底边就按 COMPOSITE/PRIME 下落，碰到底边后 `set_pen_layer("peak")`、`image_stamp`、`dispose_clone`（3458）。
- 实测（无 patch，headless）：
  - f240 雪克隆 4、`root.clones=4`、mirror=4、dispose=0；
  - f300 雪克隆 10、dispose=0；
  - f600 雪克隆 21、累计 mirror=39、累计 dispose=18；
  - f1200 雪克隆 21（平台），累计 mirror=95、dispose=74；克隆寿命样本 116–240 帧；一个 index=1 的克隆从 f207 起停在 y=350 未下落（1 既非 PRIME 也非 COMPOSITE，3448/3450 两个分支都不命中），这是作品逻辑本身，不是 dispose 缺失。
- 克隆上限：`rt/core.lua:15` 300；官方 `per_entity_clone_limit=300`（`crc_libs:1` byte 864591），超过时自动 dispose 最旧（`crc_libs:1` byte 978854），我们的 `Sched:mirror`（`core.lua:649-650`）到 300 是**拒绝新建**而不是回收最旧。f1200 只有 21，未触发，记录为未验证差异。
- 官方 clone 生命周期：`mirror` → `clone_entity` + `generateCloneActor`（`main.15ba0757.js:1` byte 1545038）；`dispose_clone` → `destruct_entity`（byte 1545510）；clone order 从 1 开始（initCache `latestOrder:0`；`latestOrder++` byte 1897347）。我们的 `clone_index` 也从 1 开始，与作品 index=1 的判断结果一致。
- 结论：雪累积是 **now 作品自身的持续生成 + 慢速下落（约 20 个稳态）**，不是我们的 dispose 路径缺失；官方同作品也会累积。与 C1-a 六项无因果。唯一未验证差异是 300 上限时的“回收最旧 vs 拒绝新建”，当前剧本未触发。
- 诊断脚本：`work/c1c_snow.lua`、`work/c1c_snow_long.lua`、`work/c1c_snow_life.lua`、`work/c1c_snow_threads.lua`（研究副本，不进包）。

### 4.12 已知差异清单（不排期）

#### 克隆上限 300+（单实体）
- 触发条件：同一实体存活克隆数 > 300。
- 官方语义：`per_entity_clone_limit=300`（`crc_libs.cce421af.js:1` byte 864591）；超过时把最旧的 clone 通过 `dispose_clone` 回收（同文件 byte 978854）。
- 我们现状：`rt/core.lua:649-650` 在 `clones >= C.max_clones_per_entity(300)` 时**拒绝新建**，不回收最旧。
- 状态：当前不可达（f1200 雪克隆仅 21）；等真触发再修，不进 C1-b/后续排期。

### 4.13 C1-b 前置调查（未改代码）

#### ask 锁（补充约束 A）
- 现状：`rt/impl/ui.lua:12-41` 的 `self_ask`/`ask_and_choose` 都是立即返回；没有锁，也没有全局/per-thread 阻塞。`get_choice_and_index` 目前把 `game.answer` 同时当 content/index。
- 官方粒度：`crc_libs:1` byte 1000200 `get_thread_lock=function(t,e){return this.add_task({entity_id:t, interpreter_id:e, blocking:!0})}`；阻塞计数按 `interpreter_id`（同文件 byte 1022387 `interpreter_n_blockers_lookup[r]`）。即 **per-interpreter（线程）**，不是 per-entity；entity_id 只是任务字段。
- 官方并发：`main.15ba0757.js:1` byte 2181058 `StageDialogStore.openStageDialog`：`if(dialogVisible) stageDialogStack.push(e)`；`closeStageDialog` 用 `stageDialogStack.shift()` 打开下一个。多 ask 是 **FIFO 排队**，不是覆盖/跳过。askAndChoose 的锁/回调在 byte 1552677 附近：callback 写 choice/index（i+1）后 `c.stop()`。

#### hat 遍历顺序（补充约束 B）
- 现状：主循环没有用 `pairs` 遍历 hat。`Sched:fire`（`rt/core.lua:341-368`）按 `for i=1,#list`；`fire_when`（450-458）/`fire_bump` 也是数组。`Sched.hats` 只是按 hat 类型查表，不参与全量遍历。
- 但**跨实体注册顺序不是 JSON 定义次序**：`kntl/emit.py:703` `sids=sorted(sdict.keys())`、`:735` `aids=sorted(adict.keys())`，所以不同角色的 hat 按 UUID 排；同一角色内部仍按 `nekoBlockJsonList` 顺序。
- 官方向：responder 按 `responder_blocks` 数组注册（`crc_libs:1` byte 829266）；spawn 进 `interpreters_needing_spawn`（byte 987289）后按数组顺序 `do_spawn_interpreter`（byte 986527），`creation_counter` 递增（byte 986400）。
- 结论（修正）：这三处只证明 `spawn_interpreter` 把请求 **FIFO 入队**、`do_spawn_interpreter` 在真正 spawn 时自增 `creation_counter`；**没有**证明跨角色请求顺序等于 JSON 创建顺序。请求顺序来自 responder 注册/事件派发（`crc_libs:1` byte 829266 按 `responder_blocks` 数组）。B-order 挂起，`kntl/emit.py:703/735` 未改。

### 4.14 C1-b 执行记录（all.sh EXIT=0）

| 包 | 文件/改动 | 验收实际 |
|---|---|---|
| G4-6 | `rt/impl/op_sensing.lua:577-609`：date/weekday/weekday_num；zh/en/fr 日名，`KN_LANG`/`LANG` 选择 | `date=18`、`weekday=星期日`、`weekday_num=7` |
| G4-4 | `rt/impl/motion_looks.lua:115-117` 删除重复定义；`:135-171` 读 `rotation_type` 并存数字枚举；`draw_rotation` 数字/旧字符串兼容 | `args.rotation_type=2 → after=2`（数字），65 个实体为 2 |
| G4-7 | `rt/host/love.lua:150-153`、`rt/host/headless.lua:155-158`：过滤读 `args.type` | swipe up 只触发 v_up=1 |
| G6-5 | `rt/core.lua`：`Thread.lock_count` + `Sched:get_thread_lock` + step 跳过锁；`rt/impl/ui.lua`：FIFO `dialog_queue`、per-thread lock、`submit_choice`/`submit_answer`/`current_dialog`（正式 API，无 test_mode） | frame1 thr=3；submit1 后 thr=2；A choice=B/index=2(number)；current owner A→B；submit2 后 thr=1 |
| G7-6 | `rt/impl/motion_looks.lua`：LEFT_RIGHT flip `n>=90 and n<270`；持久化不动 | 90 true、-270 true、100/180 true；270 false |
| G10-8 | `rt/host/profiler.lua`：主线程 + 现有 `thread.co` + 包 `Sched.spawn` 给新线程挂 hook；stop 清理 | A samples=300（原 0），top 为 `../work/c2_profiler.lua:17 body` |
| 测试适配 | `tests/vm_test.lua`、`works_test.lua`、`vm_conformance.lua`、`run_compiled.lua`、`show_console.lua`、`trace_prims.lua`：ask 打开后用 `ui.submit_answer` 提交（走正式 API） | vm/works 仍输出 0.3；`all.sh EXIT=0` |
| 新测试 | `tests/ask_test.lua` 加入 `tests/all.sh:12` | 17 项 / 0 失败 |

- 新增 ask API 契约：`ui.current_dialog(g)` 返回队列首项，`owner` 是调用 ask 的实体；`ui.submit_choice(value[, index[, g]])`、`ui.submit_answer(value[, g])` 是 UI 按钮/输入的唯一提交路径；没有 test_mode 分支。
- B-order：源原文见上，挂起；emitter 未改。

### 4.15 B-order 执行记录

- 改动：`kntl/emit.py:703` `sids=sorted(...)` → `list(sdict.keys())`；`:735` `aids=sorted(...)` → `list(adict.keys())`。依据用户实测（跨角色同帧按创建顺序）+ 官方 FIFO/creation_counter（`crc_libs:1` byte 986400/987289/986527）。
- 新测试：`tests/fixtures/hat_order.bcmkn`（actorsDict 先 A(id=zzz-actor) 后 B(id=aaa-actor)，sorted 会 B→A；A 两个 hat，B 一个 hat）+ `tests/hat_order_test.lua`；`tests/all.sh:12` 已加入。结果 8/0：跨角色 A→B、同角色 first→second。
- 全部 works 用当前 emitter 重编译（`--no-assets`）：now/big2/new1/new2/media/effects/switch + real_vm(来自 vm.bcmkn.json)。
- hat 顺序变化（改前 vs 改后，完整 diff：`work/hat_order_changes.diff`）：
  - `now`：7 个 hat 类型重排（on_keydown、on_running_group_activated、self_listen、self_listen_with_param、sprite_on_tap、start_as_a_mirror、when）；例：on_running_group_activated 首位 `背景#1c387224` → `背景#700824a5`，on_keydown 首位 `锁定#1729f8cf` → `tips#79a5d117`。
  - `big2` / `new1` / `new2`：`on_running_group_activated` 由 `Texture Triangle, Texture Triangle, 新角色` → `新角色, Texture Triangle, Texture Triangle`。
  - `media` / `effects` / `switch` / `real_vm`：hat 顺序不变。
- 回归：hyp_test f240 `step=2.6ms`；ask_test `3→2→1`、A choice=B/index=2(number)；layer_test 5/5；probe_now f240/f300 `thr=86/91`、无崩溃；`sh tests/all.sh` → `EXIT=0`。
- 注意：works 由当前 emitter 重编译，除 hat 顺序外也同步了 C1-a 的 `wait_until` 内联等编译变化；works_test/vm_test 仍输出 0.3。

### 4.16 B1 计划（待批，未改代码）

- 新增 `rt/host/draw_dump.lua`：纯格式化/写盘模块；字段缺失一律 `null`，不跳过实体。
- `rt/host/love.lua`：`H.new` 只读一次 `os.getenv("KN_DRAW_DUMP") == "1"`；`H:draw` 在现有绘制前后调用 dump；开关关闭时只多一次 nil 判断，不改绘制逻辑/图形状态。
- 字段：frame/phase/name/id/kind/x/y/scale_x/scale_y/rot/flip/alpha/order/layer/seq/drawn/in_hit/shader（shader 取 e.effects 的原始参数：hue/opacity/brightness/pixelate/ripple/twist/grayscale；无则 null）。
- 覆盖：帧头按 `g.entities` 全量写 114 条（含屏幕/未入绘制列表/隐藏/剔除）；drawn 实体另写 BEFORE/AFTER 两行；每条含 `drawn` 与 `in_hit`。
- 输出：优先 `rt.host.diag` 的 `D.write("draw/draw_<frame>.txt", text)`（由现有 diag 落盘流程回收）；diag 未装时写 `love.filesystem.getSaveDirectory()/knplayer_draw/draw_<frame>.txt`。
- 测试：`tests/draw_dump_test.lua` 用纯格式化器喂假实体，断言字段齐全、缺值 null；加入 `tests/all.sh`。真机 f240 的 114 实体验收需 LÖVE，不在本环境。

### 4.17 B1 执行记录（headless）

- 文件：`rt/host/draw_dump.lua`（纯格式化/写盘）、`rt/host/love.lua`（H.new 开关 + H:draw 前后记录，不改绘制）、`rt/host/headless.lua`（end_frame 写状态）、`tests/draw_dump_test.lua`、`tests/all.sh:12`、`tools/pack.py`（`--draw-dump` 标记）。
- in_hit 独立：`Scene.hit_list(g)` 建集合，不从 render/draw list 推断；测试用舞台外实体验证 `drawn=false in_hit=true`。
- 帧范围：`KN_DRAW_DUMP_FRAMES`；默认 `200-250`；`all` 表示全帧；单帧 `240` 也可。每帧一个 `draw_<frame>.txt`。
- 路径：diag 已装时走 `D.write("draw_<frame>.txt")`（落 diag 输出目录）；否则 `love.filesystem.getSaveDirectory()/knplayer_draw/`；均启动首帧打印一次 `[draw_dump] frames=... out=...`。
- headless 验收：
  - `tests/draw_dump_test.lua`：32/0（字段齐全、缺值 null、独立 in_hit、写盘）。
  - `KN_DRAW_DUMP=1 KN_DRAW_DUMP_FRAMES=240-240` 跑 now f240：`entities=114`，`draw_0240.txt` 39,248 字节，`phase=STATE` 114 条。
  - 关闭开关：无 dump 对象/无文件/无打印；150 帧 now `137.4/138.7/140.4ms`。开启但帧段外：`145.3/146.8/142.6ms`（仅范围检查，无写盘）。
- 真机包 2：`knplayer-diag-2.love`（193.7 MB，sha256 `6b9324f5b0247b3cf9efa321cc876866faa9f03f93e1131bda76649466d45c66`），含 `diag.on` + `draw_dump.on`（包内 B1 默认开，普通环境仍默认关）。
- B1 headless 顺带定位：三个 NaN 实体首帧均为 **f207**（f206 仍有效）：
  - 总PP f206 `(0,-225)`；f207 `x=nan,y=nan`，scale/rot 仍 1/0。
  - 星 f206 `(0,-180)`；f207 `x=nan,y=nan`。
  - 支持者内容 f206 `(-215,225)`；f207 `x=nan,y=nan`。
  - 真机包 2 用 draw_0200..0250 复核 drawn/in_hit/shader 与视觉。

### 4.18 B1 drawn 初始化修复

- 现象：`rt/host/draw_dump.lua:175 attempt to index field 'drawn' (a nil value)`，调用点 `rt/host/love.lua:490` 背景屏 `mark_drawn(screen)`。
- 原因：`drawn` 只在 `begin_frame` **帧段内**初始化；帧段外 `begin_frame` 先 `return false`，`mark_drawn` 又没有 active 守卫，背景屏的 mark 仍执行。
- 修复：`M.new` 初始化 `drawn/lines/idx/hit`；`begin_frame` 在帧段判断前重置；`mark_drawn` 增加 `if not self.active or not e then return end`。未改绘制逻辑。
- 回归：`draw_dump_test.lua` 覆盖“首帧 mark_drawn 前 drawn 已初始化”“开关关闭 mark_drawn 不访问 drawn”，37/0；`sh tests/all.sh EXIT=0`；headless f240 仍 114 条。
- 包 2 已重打：sha256 `9189725379cf78a895268d8bb7f191129e60431f9bb9b87d638f313e6a66e917`。
- 记录：**B1 首版 drawn 未初始化，已修**。

### 4.19 真机通道降级（overlay + error 探针）

- 真机约束：无 console；`love.filesystem` 不可写或写入不可见；仅 error 页可确认。B1 dump 主体冻结，只加诊断通道；`drawn` 修复保留。
- Overlay（`rt/host/love.lua` 绘制末尾）：
  - 始终画 `BOOT OK`；
  - `draw_dump` 存在且当前帧在帧段内时画 `DRAW_DUMP ACTIVE frame=<n> entities=<m>`。
- 临时探针（`rt/host/b1_probe.lua`）：`b1_probe.on` 或 `KN_B1_PROBE=1`，默认 **f245** 触发 `error()`；错误页包含：
  - `getSaveDirectory` 的 pcall 返回值；
  - `love.filesystem.write("probe.txt","x")` 的 pcall 返回/错误；
  - `getInfo` 结果；
  - `KN_DRAW_DUMP`/`KN_DRAW_DUMP_FRAMES` 环境值、frame/entities、draw_dump from/to/active；
  - 三个 NaN 实体的 x/y/scale/rot/order/layer/seq；
  - `render_list` 的 first5/last5（用于图层颠倒反馈）。
- error() 会终止本次运行，无法在同一次运行里“分 2-3 帧”继续；已把 3 个 section 合并到同一错误页。
- 包：
  - 普通 B1 包：`knplayer-diag-2.love`，sha256 `83dc1b6b6632a25c9c09a37472b27614be49de5ff75106e1c68719f0f8a22425`，无 probe。
  - 探针包：`knplayer-b1-probe.love`，sha256 `5fb900055f45fc163569323a0ae1fc225b2ba0e9339e26792c1943dbc6c298b7`，含 `b1_probe.on`，f245 报错。
- 真机反馈：**所有角色图层颠倒**。本轮不改 draw 逻辑；探针错误页的 render first5/last5 只作证据，待确认后处理。

### 4.20 真机截图/探针分析

- 截图：`BOOT OK` 已显示，说明 overlay 通道生效；`DRAW_DUMP ACTIVE` 不可见不是开关失败——`BOOT OK` 用了 128px 基准字体，实际盖住整行。已改用 `self:text(...,14/12px)`，并把探针移到 `begin_frame` 之后。
- 探针实测：
  - `getSaveDirectory ok=true val=/data/data/org.love2d.android/files/save/knplayer`
  - `write ok=true ret=true err=nil`，`getInfo type=file size=1`
  - 结论：`love.filesystem` **可写**，只是路径在 app 私有目录，文件“不可见”。
  - `KN_DRAW_DUMP=nil` 是正常的：包内有 `draw_dump.on`，`draw_dump from=200 to=250` 已构造。
  - `active=false` 是探针当时在 `begin_frame` **之前**执行，读到上一帧 end_frame 的 false；已调整调用顺序。
  - f245 `entities=115`；f240 为 114。
  - 三个 NaN：`x=nan y=nan`，`scale=(1,1)`，`rot=0`；星 order23/layer0/seq17，总PP 16/0/23，支持者内容 11/0/74。
  - `render first5=手指|雪|雪|雪|雪`，`last5=now|特效|circle|FPS|遮罩`；已追加完整 `render all(name:order)` 到错误页。
- 图层颠倒：已记录，未改 draw 逻辑；探针的 `render all(name:order)` 作为证据。
- 包更新（旧包作废）：
  - 普通：`knplayer-diag-2.love` sha256 `86d8c54e6b420edf0b67b0c48dac6ee45f89a712b4e7c3f5f74c4443dc48f38c`
  - 探针：`knplayer-b1-probe.love` sha256 `c2d60e234d4eacdfc7f275cbb18f6c0ec341017951026e4343659630cdd01998`

### 4.21 NaN 归因（先于图层）

- f200–f206 三实体保持初始位置；f207 屏幕从 `13c1f24a` 切到 `6c9fdf0c`（`now.lua:3754`，角色 logo 的 `switch_to_screen`），`6c9fdf0c` 的 `on_running_group_activated` hat 在 f207 才 spawn。
- 每帧位置写入块（全部是 `self_move_to`）：
  - 星：`now.lua:1512`，x=`(get_mouse_info(x)-x)*0.05*0.2+0`，y=`(get_mouse_info(y)-y)*0.02*0.2-180`
  - 总PP：`now.lua:1759`，x 同 0.05/0.2+0，y 同 0.02/0.2-225
  - 支持者内容：`now.lua:3612`，x=`...*0.02*0.2-215`，y=`...*0.04*0.2+225`
- NaN 不是作品变量，是 `get_mouse_info(type=x/y)` 的返回值：`rt/impl/op_sensing.lua:520-535` 在 `host.mouse_is_down` 为 false 时直接返回 `0/0`；f207 三实体 hat 首次执行时 mouse_is_down=false，`self_move_to` 的参数即 NaN。
- 官方对应：`get_mouse_info` 在无鼠标位置时 `{x:NaN,y:NaN}`（`main.15ba0757.js:1` byte 1563880）；`self_move_to` 在 `main.15ba0757.js:1` byte 1599451。
- f200–f210 原始 x/y：
  - 总PP/星：200-206 为 (0,-225)/(0,-180)，207-210 全 nan。
  - 支持者内容：200-206 为 (-215,225)，207-210 全 nan。
- 探针错误页现已带 f200-f210 历史、每实体 source 行、当前 NaN 行、完整 render all(name:order)。

### 4.22 B1 探针批次限制 + 单一探针包

- `error()` 会终止 LÖVE 运行，**无法 f240 抛完再 f241 继续**；所谓“一次运行多张错误页”在不改自定义 errorhandler 的前提下物理不可行。当前把 NaN 历史/render all/环境探测合并到 f245 的同一错误页。
- 探针包改为 **不写 dump 文件、不装 diag**：`H.new` 在 `b1_probe.on` 下使用 `P.overlay_dump()` 假对象，只提供 ACTIVE 判定；探针自身仅写 `probe.txt` 测 filesystem。
- 普通 B1 包 `knplayer-diag-2.love` 已删除；只保留 `knplayer-b1-probe.love`，sha256 `a80e2277c3e7b8238f5fb2a5a9e4fefaf150a2c6f1ea7570196433c97f4d2a9a`。
- 图层颠倒：`render first5=手指|雪...`、`last5=now|特效|circle|FPS|遮罩`；未改 draw 逻辑，待 NaN 归因确认后再处理。

### 4.23 真机 f209 修正 + 归因/计划

- 真机探针回传：f207/f208 三实体仍为初始值，**f209 才变 nan**；headless 为 f207。以真机为准，首 NaN 是 f209；两环境相差 2 帧，上游表达式相同（屏幕切到 6c9fdf0c 后 hat 首跑，get_mouse_info 返回 NaN）。
- 位置块：星 now.lua:1512、总PP now.lua:1759、支持者内容 now.lua:3612；官方 self_move_to byte 1599451，get_mouse_info byte 1563880。
- 图层：render all 按 order 升序（2..31），last=遮罩31，符合官方 peak=last child；若画面全反，反在 order 的来源（actorIds 索引方向），不在 render_list 的 layer/seq 排序。
- B1：error() 会终止，不能 f240/f241 连抛；只能单页多段或自定义翻页。计划每页 ≤30 行：NaN 3 实体×f206-210、render all 可见项、env 5 行。
- 修复计划（未批，未改）：
  - NaN 包：`rt/impl/motion_looks.lua:41-43` 对 self_move_to 的非有限坐标做 guard（先确认官方 setter byte 1599451 是否同样 guard）；测试 f207/f209 不再写 NaN；不动 get_mouse_info 的官方 NaN 语义。
  - 图层包：先加 menu render 断言；若确认 actorIds 是自上而下，在 `kntl/emit.py:725-731` 反置 order 映射；不动 render_list/layer_test。

### 4.24 包 N（NaN guard）+ 包 L（图层反置）

- 包 N：`rt/impl/motion_looks.lua:41-45` 的 `self_move_to` 对非有限 x/y 不写入，保留当前值；依据官方 `moveTargetTo` `main.15ba0757.js:1` byte 1749237，最终 guard `isFinite(M)?M:T` 在 byte 1750330。`get_mouse_info` 的官方 NaN 语义未改（op_sensing:520-535）。
  - 新测试 `tests/nan_guard_test.lua`：14/0；纯 NaN/Inf/部分轴 + now f210 三实体 x/y 有限。
  - headless `probe_now` f240 `bad=`（NaN 实体清空）。
- 包 L：`kntl/emit.py:725-735` 把 actorIds 索引反置为 order（首个 actor 最大、末个最小）；`render_list` 的 layer/seq 排序未动。
  - 依据：真机全反 + 官方 `get_actor_ids` byte 1141200 / `set_z_index` byte 1162523 / `peak` byte 1609639。
  - 新测试 `tests/layer_real_test.lua`：菜单 render 18 项，first=遮罩(order1)、last=手指(order30)，order 升序；4/0。
  - 全部 works/fixtures 已重编译；`tests/hat_order_test` 仍 8/0。
- `sh tests/all.sh`：EXIT=0。
- 真机探针包（唯一包，含 N+L，无 diag/draw 文件）：
  `knplayer-b1-probe.love` sha256 `fd56515bb4e2c1f1932ff7b5df63253a1c08a04b81bb690a506c54b6f85b75a3`。

- 探针触发已改为仅 `b1_probe.on`（`P.enabled` 不再读 `KN_B1_PROBE`）；默认 f245。最终包 sha256 `3e068587460a3f49c17d59a506d49d6edd0045a6ee3ed057144c1cff11c31c36`。

### 4.25 真机 N/L 收尾结果与残留观察

- 真机确认：图层顺序正常；三个 NaN 实体 f200–f210 全部为有效值，当前 x/y：星 (0,-180)、总PP (0,-225)、支持者内容 (-215,225)。
- 包 N 生效：`self_move_to` guard；包 L 生效：render first5=遮罩|FPS|circle|特效|now，last5=雪…|手指。
- 残留观察 1：三实体 f245 `visible=false alpha=0`，所以不在 render all；若它们本应显示，是作品隐藏状态/变量问题（now.lua:1528/1786/3602 的 gradually_show_hide），不是 N/L 回归。
- 残留观察 2：N 只 guard `self_move_to`；now 仍有 14 处 `get_mouse_info` 直接进入 `self_change_coordinate_*`/变量（如 now.lua:773/774/2888/3823/4050/4201/4298）。当前 f240 全实体扫描无非有限值，但结构上仍有 NaN 注入路径；是否扩展 guard 由用户决定。
- 残留观察 3：error() 仍只能单页；B1 若要真正多页，需要自定义 errorhandler/overlay 翻页。
- 最终探针包 sha256 `3e068587460a3f49c17d59a506d49d6edd0045a6ee3ed057144c1cff11c31c36`。

### 4.26 修复 2：坐标写入口全 guard（本包收尾）

- `rt/impl/motion_looks.lua:41-45` `self_move_to` 已 finite guard。
- 本次补：`self_set_position_x/y`（`:62-70`）与 `delta_of`（`:74-80`）统一 `finite(v)`；依据官方 `moveTargetTo` byte 1749237/1750330、`changeTargetPosition` 的 `isFinite(n)` byte 1750630。
- `get_mouse_info` 的官方 NaN 语义不变；所有 NaN 上游现在在写入口被拦截。
- `tests/nan_guard_test.lua`：20/0（NaN/Inf/部分轴/set_position/change_coordinate/now f210）。
- headless f240 全实体扫描：114 个实体，`bad=0`。
- `sh tests/all.sh`：EXIT=0。
- 不重打/不发真机包；本包收尾。

### 4.27 paint 前置：now 媒体备份 + 隐藏背景白底

- now 媒体备份（只复制，不删源）：`HateNeko_ws/backup/now_media_assets_20261018/`
  - 303 个 asset id、35 个 audio id；348 个文件（同 id 多扩展名）；195,845,425 bytes。
  - `MANIFEST.json` 含逐文件 sha256；回读校验 348/348 一致，源 `works/assets` 348 文件全在。
- paint 背景 `700824a5...` 的 `visible=false`（`work/paint.bcmkn.json`）。
- 官方渲染器：`main.15ba0757.js:1` byte 5611571 `backgroundColor:16777215`（#FFFFFF），PIXI 每帧 clear 到该色；背景 actor 隐藏时不绘制，露出白底。
- 我们：`rt/host/love.lua:422` 舞台画布 `clear(0.14,0.16,0.22)`，且 `:437` 跳过 `visible=false` 的 screen；所以隐藏背景会显示深灰底 + `:428` 的舞台边框，不是官方纯白。修复方向：舞台 clear 改 (1,1,1)（是否保留边框另定），不改 background 绘制条件。

### 4.28 paint 编译/headless（未发包）

- 编译：`python3 -m kntl.compile ../work/paint.bcmkn.json works/paint.lua` → 43 行 / 3.7 KB；素材已存在 6，新下载 0，失败 0。
- 修复：
  - `rt/impl/motion_looks.lua:54-79`：`self_move_specify` 实现 `--mouse`/`--random`/UUID；官方 `main.15ba0757.js:1` byte 1598302。
  - `rt/impl/motion_looks.lua:327-331`：`self_pen_up` 清 `pen.last_x/y`；官方 brush byte 1146779、selfPenUp byte 1639955。
  - `kntl/emit.py` screen_lines 增加 `visible`；paint 背景 `visible=false` 不再被当成可见。
  - `rt/host/love.lua:421-425`：舞台 clear 改 `(1,1,1,1)`，移除调试边框；官方 renderer `backgroundColor:16777215` byte 5611571。
- 新测试 `tests/paint_test.lua`：18/0（舞台 900x562、背景/角色 hidden、笔粗5、--mouse 跟随、落笔/断笔/last 清空）；`tests/all.sh` 已加入。
- 全量：`sh tests/all.sh EXIT=0`。
- 未打包、未发真机包，等待视察。

### 4.29 paint 运行包（最小包）

- 产物：`player/knplayer-paint-20261018.love`，6.9 MB，37 files，sha256 `d8b7701581c3378450a5b4e30e608134f23a776a1b8b79b72308004051c2dd53`。
- `conf.lua` 内 `STARTUP.work="paint"`；`probe=false`、`diag=false`。
- 包内只含 `works/paint.lua` + paint 的 6 个素材；无 `works/now.lua`、无 now 资产、无其它 works。
- 无 `diag.on` / `draw_dump.on` / `b1_probe.on`；`H:draw` 的 BOOT OK/ACTIVE 叠层仅 `b1_probe`/`draw_dump` 存在时显示，普通 paint 包不显示。
- 包内仍包含 `rt/host/b1_probe.lua` 等代码，但无 marker、无 env，不会触发 error 探针。
- 校验：CRC 全通过；`main.lua`/`paint.lua`/`conf.lua` 存在；works 仅 paint；`sh tests/all.sh EXIT=0`。

### 4.30 paint 画笔颜色/圆形修复 + r1 包

- 默认笔色：`rt/core.lua:81` `#0000ff` → `#000000`；官方 brush `this.stroke_color="000000"` `crc_libs:1` byte 1146391。
- 圆形笔：`rt/host/love.lua:845-856` 每段 line 后补 `circle("fill", x1,y1,width/2)` 和 `x2,y2`；官方 brush 每段先 `canvas_draw_circle`（byte 1147555）再线。
- `tests/paint_test.lua` 增加“初始笔色 #000000”，19/0；headless 全部通过。
- 新包：`player/knplayer-paint-20261018-r1.love`，6.9 MB，37 files，sha256 `1608d383d5c47a6f40f11ca72835d07c0bfc35133338f1a7d5bf66d451c7c70e`。
- 包内仅 paint + 6 素材；无 now；无 diag/draw_dump/b1_probe 标记；probe/diag=false。

### 4.31 AtLua 非舞台 UI 重构（headless 阶段）

- 引入 `At/`（12MB，含字体）、`LICENSES/`、`ATLUA_LICENSE`、`ATLUA_THIRD_PARTY_NOTICES.md`；许可证随包。
- 新增 `rt/host/atui.lua`：
  - HUD：`At.Panel` + `At.Label` + DBG/LOG 按钮（FPS/构建号/实体/线程）。
  - 调试面板：`At.Panel` + `At.Label` 五页（环境/角色/线程/变量/指针），PREV/NEXT/CLOSE；原 `rt/host/panel.lua` 不再装载/调用（文件保留但死代码）。
  - 日志：`At.log` + `At.Console`；`host:log` 转发 At.log；`At.log.setFile(false)`；`At.config.blur.enabled=false`。
  - F1 面板 / F2 控制台；LOG 按钮。
- `main.lua`：AtUI 在舞台绘制之后画；输入先给 AtUI，`capture` 命中时不再转发舞台；新增 textinput/wheelmoved；`rt.host:hud`/panel 调用移除。
- headless：
  - `tests/atui_test.lua` 11/0（页面文本、无 love 不启用、UI 按下 capture/release 路由）。
  - `tests/all.sh EXIT=0`；`tests/paint_test.lua` 19/0。
- 未打包、未真机；美术/字体/At 组件真实渲染尚未验证。AtLua 自带 smoke 在本机 Lua5.1 因测试脚本 `unpack=table.unpack`/日志函数名断言失败，不是 LÖVE 运行时结论，需真机验证。
- 回退：AtUI 初始化失败时仅回退旧 HUD（`rt.host:hud`）；旧诊断 panel 不再回退。

### 4.32 AtLua 加载界面 + paint AtUI 包

- 加载界面：`rt/host/atui.lua` 新增 `loading_update/draw_loading/finish_loading`；`At.Label + At.ProgressBar + At.Panel` 居中；`main.lua:312-323/332-350` 在 AtUI 可用时走新界面，否则回退旧加载绘制。
- HUD/调试面板/Console 仍在舞台之后绘制；loading 阶段 HUD 隐藏，加载完成后恢复。
- headless：`tests/atui_test.lua` 13/0；`sh tests/all.sh EXIT=0`。
- 包：`player/knplayer-paint-atui-20261018.love`，23MB，74 files，sha256 `81b76047e3c8193f94a8640b9a547ec9b7fdf9ebdf5dc0b7e4a6c28aea11f817`。
- 包内容：paint + 6 素材 + `At/` + At 字体 2 个 + At 许可证；无 now 资产；无 `diag.on/draw_dump.on/b1_probe.on`；`probe=false,diag=false,work="paint"`。

### 4.33 AtUI 叠加层收敛：仅 FPS + 角落按钮

- 去掉常驻 HUD 的构建号/实体/线程信息；默认只显示 `At.Label` FPS（小深色背板）。
- `DBG` 按钮固定右上角，`LOG` 按钮固定右下角；调试面板/Console 默认关闭，由按钮或 F1/F2 开启。
- `rt/host/atui.lua` 增加 `set_hud_visible/layout`；加载阶段隐藏 FPS/按钮，完成后恢复；面板/Console 在舞台之后绘制。
- headless：`tests/atui_test.lua` 13/0；`tests/paint_test.lua` 19/0；`sh tests/all.sh EXIT=0`。
- 新包：`player/knplayer-paint-atui-20261018-r1.love`，23 MB，74 files，sha256 `eab2a493c2e17190cb5b26988c218967f8bccdae502de64e0c2ff75753811189`。
- 包内无 now 资产、无 diag/draw_dump/b1_probe 标记。

### 4.34 AtUI LOG 双按钮/交互卡顿溯源（未改代码）

- At.Console 默认 `tab=true`（`At/components/Console.lua:115`），隐藏时画右上角 LOG 标签，`_tabRect` 默认 `screenW-w-12,12`（`:253-260`），点击可打开（`:477-480`）。
- 我们另建了右下角 LOG 按钮（`rt/host/atui.lua:154`），`toggle_console` 只改 `M.console_visible`（`:137-143`），而 `draw` 只在 `M.console_visible` 时画 Console（`:274`）。
- 两套状态不同步：用 Console 自带 × 关闭后，At.Console.visible=false，但 `M.console_visible` 仍 true → 右上角 LOG 标签继续显示；我们的 LOG 按钮也在。点击我们的 LOG 第一次只是把 already-closed 状态改 false，表现为“卡一下/要再点一次”。
- 方案 1（保留我们的 LOG）：`At.Console({tab=false})`，Console 的构造参数去掉自带标签；`toggle_console`/draw 以 `M.console:isOpen()` 为唯一状态（关闭动画期间仍 draw）。
- 方案 2（推荐，单入口）：删我们的 `M.log_btn`，保留 At.Console 自带右上角 LOG；DBG 移到右下角（或左下角）；`M.console` 每帧都 draw，删掉 `M.console_visible` 条件；F2 仍 toggle。这样只有一个 LOG 入口，状态不再分叉。

### 4.35 方案一：关闭 At Console 自带 LOG + 状态同步

- `rt/host/atui.lua:180` `At.Console({ tab = false, ... })`，去掉 At 自带右上角 LOG。
- 保留我们的右下角 LOG；`M.toggle_console` 改为 `console:toggle()` 后同步 `M.console_visible = console:isOpen()`（`:108-112`）。
- draw 以 `isOpen()` 或关闭动画 `openAmount()>0.001` 为准；关闭 Console 后不再出现第二个 LOG。
- `tests/atui_test.lua` 增加 tab=false 与开关同步断言，18/0；`tests/all.sh EXIT=0`。
- 新包：`player/knplayer-paint-atui-20261018-r2.love`，23 MB，74 files，sha256 `e1236988efd3d31ffc3320d3eb60c029ba4ed54c0867a2fc81ae0539aaad7b80`。

### 4.36 paint 落笔无笔迹溯源（未改）

- 官方 brush `set_pen_down`（crc_libs:1 byte 1146565）：origin 为空时取 actor 当前 x/y，设 origin，立即 `draw_line(e,i)`，再挂 change listener。
- `draw_line`（byte 1147000）：先 `canvas_draw_circle(origin_x,origin_y)` 再画线；`canvas_draw_circle` 在 1147555；所以 pen down 即使不移动也立即有一个圆点。
- 我们：`self_pen_down` 只 `pen.down=true`（motion_looks.lua:323），`H:pen_update` 仅在 `last_x ~= e.x` 时画线（love.lua:840-855）；按下不动 → 无 dot。
- 计划：pen_down 的 up→down 边沿立即写 dot（host:pen_dot，LÖVE 画圆，headless 记录）；已有 down 不再重复；pen_up 清 last；headless 增加 dot 记录/断言。

### 4.37 paint 落笔 dot 修复（headless）

- `rt/impl/motion_looks.lua:323-334`：`self_pen_down` 只在 up→down 边沿执行；设 `pen.last_x/y` 为当前位置，调用 `host:pen_dot`。依据官方 brush `set_pen_down` byte 1146565 + `draw_line` byte 1147000。
- `rt/host/love.lua:797-811`：新增 `H:pen_dot`，在笔层画 `circle("fill", x,y,size/2)`；`pen_update` 继续画移动线。
- `rt/host/headless.lua`：新增 `H:pen_dot` 记录 `pen_events`（dot 坐标/笔粗/颜色/帧）。
- `tests/paint_test.lua`：26/0；按下不动 1 个 dot、按住三帧不重复、拖动不加 dot、松手后再按第 2 个 dot。
- `sh tests/all.sh`：EXIT=0。未打包。

### 4.38 pen 作品编译 + 画笔语义审计（未改运行时）

- 编译 `../work/pen.bcmkn.json` → `works/pen.lua`（89 行 / 7.1 KB）；素材已存在 6、新下载 1（SVG→PNG）、失败 0。
- 作品覆盖：`self_set_pen_color`、`self_change_pen_color_property(hue)`、`self_set_pen_size`/`self_change_pen_size`、`self_pen_down/up`、文字 `stamp`、`image_stamp`、`set_pen_layer peak/bottom`、`clear_drawing`。
- 已确认缺口：色相只写 `pen.hue` 不转颜色；文字 stamp 走 `H.stamps` 当帧清空、不落笔层、不支持 right/旋转/1..1000 size；`set_pen_layer` 只存 `_pen_layer_mode` 无绘制效果；size change 无 1000 上限。
- 计划详见对话；核心源：brush `set_pen_down` 1146565、`set_color` 1147874、`set_hue` 1148012、`set_saturation` 1148144、`set_brightness` 1148276、`draw_text_stamp` 1149891、`draw_image_stamp` 1150325；block `setPenSize` 1640209、`changePenSize` 1640596、`setPenColor` 1641061、`setPenColorProperty` 1641225、`changePenColorProperty` 1641984、`setPenLayer` 1643399；scene children background0/brush1/actors2 `1139417/1139505`。

### 4.39 画笔颜色属性：官方 HSV + 透明度口径（证据）

- 用户面 saturation/brightness 是 **HSV**，不是 brush 内部 HSL：
  - `main.15ba0757.js:1` byte 1641984 `selfChangePenColorProperty`：取 `kO(h,s,l)` 得 `{h,s,v}`，改 `v/s` 后 `Iv(h,s,v)` 转回 HSL，再 `set_saturation/set_brightness`。
  - byte 1641225 `selfSetPenColorProperty` 同样 `kO`/`Iv`，`saturation`/`brightness` 输入按 `val/100`，hue `%360`。
  - 转换函数：`function ae(e,t,n)`（kO，HSL→HSV）在 byte 5755456：`{h,s:i,v:r}`；`function oe(e,t,n)`（Iv，HSV→HSL）在 5755547。
  - brush 内部变量 `hsl`（set_color byte 1147874、set_hue 1148012、set_saturation 1148144、set_brightness 1148276）只是实现细节；对块暴露的是 HSV。
- 透明度：
  - `selfSetPenColorProperty` alpha：`set_alpha((100-I)/100)`；输入 0=不透明，100=全透明。
  - `selfChangePenColorProperty` alpha：`set_alpha(get_alpha()-y/100)`；steps 增大→更透明。
  - brush `set_alpha` byte 1147950（0..1 opacity）。
- 当前 `rt/impl/motion_looks.lua:388-391` 只改 `pen.hue`，不转颜色；alpha 也未按“透明度”口径统一。修复时按上述 HSV/透明度实现。

### 4.40 画笔盒语义补全（pen.bcmkn）

- 颜色：`rt/impl/motion_looks.lua` 增加 hex↔HSL/HSL↔HSV；`self_set_pen_color` 维护 `pen.hsl`；`self_set/change_pen_color_property` 按官方 HSV（hue 0..360、sat/bright 0..100）与透明度 `alpha=(100-val)/100` 实现；`self_change_pen_color_property` 的 alpha 增加→更透明。
- 笔粗：`self_set_pen_size`/`self_change_pen_size` clamp 1..1000。
- 文字印章：`M.stamp` 传入 game；Love `H:stamp_text` 直接写入 pen_layer，按 actor 位置/`-dir` 旋转/对齐/1..1000 字号/笔色/alpha；不再走 `self.stamps` 当帧绘制。
- 图片印章：`H:pen_stamp` 保留写 pen_layer。
- 笔层：`H:draw` 按 `_pen_layer_mode` 处理 `peak`（actors 之后）与默认/bottom（actors 之前）；文字/图片印章随笔层。
- headless：`H:pen_stamp/pen_layer_move/pen_clear` 记录事件；`tests/pen_test.lua` 27/0。
- `sh tests/all.sh EXIT=0`。未打包。

### 4.41 画笔盒完整语义（补充未用逻辑）

- 颜色属性：按官方 HSV + 透明度完整实现 `set/change`（hue/saturation/brightness/alpha）；hex↔HSL↔HSV 工具在 motion_looks。
- 笔粗：set/change clamp 1..1000。
- 文字印章：写入笔层，位置/旋转/left-center-right/1..1000 字号/笔色/alpha；不再走临时 `stamps`。
- 图片印章、落笔 dot、抬笔断线、清空、peak/bottom 笔层均已覆盖。
- `set_pen_layer` 额外支持 prev_layer/next_layer/target 目标索引（H:draw 在 actor 序列中插入笔层）。
- headless：`tests/pen_test.lua` 32/0；`tests/paint_test.lua` 19/0；`tests/atui_test.lua` 18/0；`sh tests/all.sh EXIT=0`。
- 未打包。

### 4.42 文字印章方向随角色（官方证据 + 回归）

- 官方 `stamp`：`main.15ba0757.js:1` byte 1642968 取 `M=-o.get_rotation()`，传 `draw_text_stamp`。
- `draw_text_stamp`：`crc_libs.cce421af.js:1` byte 1149891 `translate(global actor pos); rotate(_); fillText`。
- `selfPointTowards`：`main` byte 1602575 把 degrees 转弧度并 `actor.set_rotation`。
- 我们 `H:stamp_text` 已用 `-math.rad(entity.dir)` 围绕 actor 位置旋转（love.lua:1011-1039），与官方同口径。
- `tests/pen_test.lua` 增加 `stamps[1].dir=1`、`stamps[4].dir=0` 断言；34/0；`sh tests/all.sh EXIT=0`。

### 4.43 pen 作品运行包

- `player/knplayer-pen-atui-20261018.love`：23 MB，75 files，sha256 `4d070283f4d91fe8136c32925f63a0c640366554de582b79c68d48d38ae3d3d3`。
- 只含 `works/pen.lua` + pen 引用的 7 个媒体文件（排除未使用的 svg 源）；含 At/At 字体/许可证；无 now、paint 资产。
- `conf.lua`：`work="pen"`、`probe=false`、`diag=false`；无 diag/draw_dump/b1_probe 标记。
- 打包前 headless：`tests/pen_test.lua` 34/0；`sh tests/all.sh EXIT=0`。

### 4.44 文字印章 █ 与新角色 y 偏移溯源（未改）

- 官方 `draw_text_stamp`：`crc_libs:1` byte 1149891 明确 `r.font="bold "+size+"px Arial , Microsoft YaHei"`、`textBaseline="middle"`，位置为 actor global，旋转 `-actor.rotation`。
- 我们 `H:stamp_text`（`rt/host/love.lua:1011-1039`）用 `self:make_font()`，其 `rt/fonts/font.ttf` 实际是 **Noto Sans SC Bold**（fontTools family；与 At/assets/font.ttf 同 sha256），不是 Arial/Microsoft YaHei。
- 垂直锚点：我们用 `-font:getHeight()*k/2`（行框中心），官方是 canvas `textBaseline="middle"`；两者字体度量口径不同。
- Noto U+2588 bbox：yMin=-120, yMax=880（em 1000），glyph 中心 380，非 em/行框中点；换成 Arial/YaHei 的 █ 度量会不同。
- 新角色 PNG 121x122 的 alpha bbox 是整图（0..120,0..121），中心与图片中心一致；不是角色图片留白导致。
- 结论：主因是 **文字印章字体/垂直锚点与官方不一致**，不是新角色位置；Noto 是重要嫌疑。下一步可先按 canvas middle 用 font ascent/descent 校准，再换/嵌入官方字体族；未改代码。

### 4.45 文字印章 A 方案（em 中点）+ 备份/包

- 备份：`HateNeko_ws/backup/pen_pre_textbaseline_20261018/`（main/conf/pen.lua/ui/motion_looks/love/headless/pen_test/旧包，9 files，MANIFEST 含 sha256）。
- A 方案：`rt/host/love.lua:1011-1041` 文字印章 y 从 `-font:getHeight()/2` 改为 `size/2 - font:getAscent()*k`，按 canvas `textBaseline="middle"` 的 em 中点；仍围绕 actor 位置、旋转/对齐不变。
- headless：`tests/pen_test.lua` 34/0；`sh tests/all.sh EXIT=0`。
- 新包：`player/knplayer-pen-atui-20261018-r1.love`，23MB，75 files，sha256 `2d198c6e0aef1aed63672c689212674c6de1822188ebf35831dcb049fff9fcfc`；仍只含 pen 7 媒体 + At，无 now/paint，无调试标记。

### 4.46 action 编译 + 运动/输入审计（未改）

- 编译 `../work/action.bcmkn.json` → `works/action.lua`（163 行 / 9.2 KB）；素材已存在 6，新下载 2，失败 0。
- 作品使用运动积木：go_forward、move_specify(--random)、bounce_off_edge、move_to、point_towards、set_position_x/y、change_coordinate_x/y、glide_to、glide_coordinate_x/y、rotate、rotate_around(阿短)、set_rotation_type、face_to(--random)、set_draggable、set_role_camp；另有 sync_tell、appear、bump_into、wait、random、循环。
- 已见缺口：`self_bounce_off_edge` 只设 flag（且 {} 被解成 false），无实际反弹；`self_rotate_around` 忽略 sprite 参数；`self_face_to` 忽略 --random/--mouse/目标；`self_move_specify_sprite` 未按官方别名处理；`self_set_draggable` 只有 flag，无拖动；输入无屏幕外按下拦截。
- 官方源：motion 23 块 `main:1` 1597870..1604149；bounce `crc:1` 1171190；move_forward 1163031；draggable 1604008/1167450；stage hitArea 1100503。

### 4.47 action 其他作品积木官方实现补证

- wait：`crc_libs:1` byte 824397：`includes("wait")` 后 `s=(typeof time=="string"||isNaN(time))?0:time`，`thread_wait(...,1000*s)`；`thread_wait` 实现 byte 1000432/1015828。
- sync_tell：官方编译器 byte 934300 `compile_sync_tell`（切 target entity、编译 child、yield 后恢复）；运行时 `eval_sync_tell` byte 889005（EvalTell async:false），`report_sync_telling` 名称 byte 919045。
- random_num：`main:1` byte 1613664：`Math.round(A)`, `Math.round(B)`，`Math.floor(Math.random()*(B-A+1))+A`，闭区间、先四舍五入；当前 `op_sensing.lua:70` 用 floor+love.math，需按此修。
- self_appear：`main:1` byte 1606486：`i("appear"===value,...)`；只有 `appear` 显示，其他值走 hide。当前 `motion_looks.lua:310` 只把 `disappear` 隐藏，`hide` 会误显示。
- bump_into：`main:1` byte 1557546：`sprite/sprite1` 二元；第二槽支持 mouse/edge/camp，命中用 hit_test/visible/actor；当前 `op_sensing.lua:415` 已支持二元/camp，需按官方补齐。
- controls_if/循环：官方编译期 `crc_libs` controls_if/repeat 分支；作品已由 kntl 编译为 while/if，另行测试。

### 4.48 运动/其他积木实现 + action headless

- `motion_looks.lua`：
  - `self_bounce_off_edge` 立即按舞台四边反射 + 10px 内推（官方 crc 1171190）。
  - `self_rotate_around` 支持 `sprite` 目标（阿短）；`self_face_to` 支持 `--mouse/--random/角色`；`self_move_specify_sprite` 按官方别名复用。
  - `self_set_position`/`self_change_coordinate`/`self_glide_coordinate` 支持 coordinate x/y；`self_set_role_camp` no_camp 清空。
  - `self_appear` 仅 `appear` 显示（官方向）。
- `op_sensing.random_num` 改官方 Math.round + 闭区间（main 1613664）。
- `love.lua/headless.lua/main.lua`：屏幕外按下拦截；宿主支持 draggable 拖动（按下/移动/释放）。
- `tests/action_test.lua`：37/0；`tests/paint_test.lua` 19/0；`tests/pen_test.lua` 34/0；`tests/atui_test.lua` 18/0；`sh tests/all.sh EXIT=0`。
- 未打包。

### 4.49 三点修正（官方源 + 实现）

- 边缘反弹：官方 `bounce_if_collision_with_edge`（crc:1 1171190）用 `pixel_detector.check_relation_by_vertices`/`get_texture_internal_points_vertices`/`contains_edge`；官方源码先算 d、`set_rotation(d)`，再按新 internal points 算 h/f 并 `set_pixi_position`。按用户“先推回再旋转”的要求，Lua 实现先用反射角计算 alpha 像素边界并推回，最后写 `dir`；测试 `action_test` 右边界。
- 面向随机：官方 `selfFaceTo`（main:1 1603178）`--random` 取 `stage.width*random - width/2`、`stage.height*random - height/2`，再面向该点；`M.self_face_to` 已是此逻辑。
- 像素碰撞：新增 `rt/hit.lua` 的 `alpha_bounds`/`alpha_aabb`，从 `style_pixels` alpha 扫描内部 bbox，按 actor 旋转/缩放映射舞台；`self_bounce_off_edge` 使用 `alpha_aabb`；`bump_into` 原本走 `Hit.collide` 每 2px 像素采样。
- headless：`tests/action_test.lua` 37/0；`sh tests/all.sh EXIT=0`。未打包。

### 4.50 三点修正落地（源 + 测试）

- 反弹：`rt/hit.lua` 新增 `alpha_bounds`/`alpha_aabb`（扫描 `style_pixels` alpha，按 actor 旋转/缩放映射）；`self_bounce_off_edge` 用反射后的角度先算 alpha 边界、把 x/y 推回（pad 10），最后写 `dir`；官方算法 `crc:1` 1171190，源码写入顺序是 set_rotation 后 set_pixi_position，本实现按用户要求先推回后旋转（最终几何一致）。
- 面向随机：`main:1` 1603178 用 stage 宽高随机点；`M.self_face_to` `--random` 已按此，测试方向有限。
- 像素碰撞：`bump_into` 原本 `rt/hit.lua` 每 2px 采样；反弹改 alpha 像素边界；`tests/action_test.lua` 37/0；`sh tests/all.sh EXIT=0`。

### 4.51 边缘像素三细则

- 无纹理像素：`Hit.alpha_bounds`/`alpha_aabb` 无 `style_pixels` 时返回 nil；`self_bounce_off_edge` 直接返回，不反弹（官方 get_texture_internal_points_vertices 为 nil 即不处理）。
- 任一像素越界即触发：`hit_right = x2 >= R`、`hit_left = x1 <= L`、`hit_top = y2 >= T`、`hit_bottom = y1 <= B`，不再要求速度朝外。
- 内推量：官方 `h=a-(max_x+10)` / `h=-a-(min_x-10)` / `f=-_-(min_y-10)` / `f=_-(max_y+10)`（crc:1 1171500-1172500）；Lua 只在对应边触发时移到 `R-10/L+10/T-10/B+10`。
- headless：`tests/action_test.lua` 39/0（新增无像素不反弹、假像素反弹）；`sh tests/all.sh EXIT=0`。未打包。

### 4.52 action 作品运行包

- `player/knplayer-action-atui-20261018.love`：23 MB，76 files，sha256 `c0d2d729e714b7e48b37d6a43779ffa799f8fc499f6433ea22754319ee40621d`。
- 只含 `works/action.lua` + action 引用的 8 个媒体文件；含 At/At 字体/许可证；无 now/paint/pen 资产；无调试标记。
- `conf.lua`：`work="action"`、`probe=false`、`diag=false`。
- 打包前 headless：action 39/0；pen 34/0；paint 19/0；atui 18/0；`tests/all.sh EXIT=0`。

### 4.53 左右翻转/像素边缘/拖拽偏移修正

- 左右翻转：`H:draw` 现按 `ML.draw_rotation(e)` 得到 `draw_dir/flip_h`；LEFT_RIGHT 时 rotation=0、scale.x 取负。官方 `set_rotation` crc 1163800 与 `set_scale` 1164100 左右翻转一致；90 含、270 不含测试。
- 像素边缘：`rt/hit.lua` 新增 `pixel_aabb`，逐 alpha 像素映射到舞台（非纹理 bbox）；`self_bounce_off_edge` 改用 `pixel_aabb`；无像素时返回 nil，不反弹。
- 拖拽偏移：`on_mouse` 检测 `drag_last_x/y` 与 actor 当前坐标不一致（脚本 `move_to` 改动）时重算 `drag_dx/dy`，避免下一次移动瞬移；headless 断言脚本移到 0 后同一手指位置不再跳回旧偏移，继续移动按新偏移跟随。
- headless：`tests/action_test.lua` 46/0；`tests/pen_test.lua` 34/0；`tests/paint_test.lua` 19/0；`tests/atui_test.lua` 18/0；`sh tests/all.sh EXIT=0`。未打包。

### 4.54 action 真机测试包（左右翻转/像素边缘/拖拽修正）

- `player/knplayer-action-atui-20261018-r1.love`：23 MB，76 files，sha256 `252a822fbdac75f6ea25ac2224262cd265e40f9073db79efdf29295534066d9f`。
- 只含 action.lua + 8 个媒体；At/字体/许可证；无 now/paint/pen；无 diag/draw_dump/b1_probe。
- `conf.lua`：`work="action"`、`probe=false`、`diag=false`。
- 包前 headless：action 46/0；pen 34/0；paint 19/0；atui 18/0；`tests/all.sh EXIT=0`。

### 4.55 拖拽舞台外语义 + action r2

- 官方 drag_move（crc:1 1156673）：指针在 view 外直接 return，不更新 old_pos；回到 view 内后按 old_pos 位移一次追上。
- 改为 `drag_old_x/y` 指针世界坐标增量：舞台外不更新 actor/old_pos，回到舞台后一次应用全部位移；保留手指偏移。
- 同时修复脚本 move_to 后的偏移（delta 作用当前 actor，不依赖旧 offset）。
- action headless 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。
- 包：`player/knplayer-action-atui-20261018-r2.love`，23MB，76 files，sha256 `59b66056bce2c4efc33a935086a159f71d963dfe8e9e007437639218a1ee0aca`，仅 action 8 媒体 + At。

### 4.56 action 官方内部点反弹包 r3

- `rt/hit.lua` 新增 `internal_points`（step=2，2x2 alpha 四邻）与 `internal_vertices`；`self_bounce_off_edge` 只用 internal points 顶点，不再 `pixel_aabb`/整图 AABB。
- `player/knplayer-action-atui-20261018-r3.love`：23 MB，76 files，sha256 `ea6c9b92ba12d6290c8d4e9f782f542945b547b040f4e5a67ea0252608aaeb53`。
- 仅 action 8 媒体 + At；无 now/paint/pen；无调试标记。
- 包前 headless：action 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。

### 4.57 alpha 通道对照 + 100px 方块造型包

- alpha 抽取：`rt/host/love.lua:style_pixels` 用 `ImageData:getString()` 的 RGBA8，每像素第 4 字节 alpha；对照官方 `get_texture_points_color_data` 的 `>>>24>0`，抽取本身正确。
- 内部点：`rt/hit.lua:internal_points` 已按官方 step=2、四邻 `(x-1,y-1),(x,y-1),(x-1,y),(x,y)` alpha>0；缓存按 style id。
- 差异：`internal_vertices` 目前用像素中心 + 图片中心，未完全照官方 `se()` 的 actor pivot/`asset.center`/flip 变换；100px 居中纯色方块下等价。alpha 本身无错。
- 测试造型：新增 `works/assets/square-100.png`（100x100 RGBA 不透明 #FF00FF），action.lua 中编程猫 styles 改为 `c0ffee00-…-0001`，移除旧 5 个编程猫造型资产；action 只余 4 个资产（方块/背景/阿短2）。
- headless：action 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。
- 包：`player/knplayer-action-square-atui-20261018.love`，23 MB，72 files，sha256 `6f8cde26180eb4204fa94fc9bcba0f3caa9f4126d32c9974589b2cdd655a6ecf`；含 `works/assets/square-100.png`，无旧编程猫造型/无 now/paint/pen/调试标记。

### 4.58 纯色方块无边缘碰撞根因 + 修复

- 根因：`rt/hit.lua:M.style_pixels` 调 `host:style_pixels(id)` 未传 game；Love `H:style_pixels` 里的 `style_file(g=nil,id)` 只能按 ID 名找图，无法使用 `M.assets[id].file`。方块文件名为 `square-100.png`，于是 alpha 为 nil → internal points nil → 不反弹。旧造型恰好以 ID 命名，所以之前“看起来正常”。
- 修复：`host:style_pixels(id, game)` 传入 game；`style_file` 正确按 asset.file 解析。
- 同时修正 `internal_vertices`：像素点 y 轴按图片 y-down/舞台 y-up 翻转，并计入 `asset.center`。
- 官方依据：crc 1106893 internal points；1154261 internal vertices；1154592 contains_edge；1171190 bounce。
- headless：action 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。未打包。

### 4.59 边缘碰撞精度测量

- 当前`self_bounce_off_edge`仍以 `internal_vertices` 的 min/max 作为边缘判定/内推，属于 internal-point bbox，不是逐像素集合接触。
- 测量口径：actor dir=0、scale=1、asset.center=0、舞台右边界 R=450，向右移动；碰撞定义为 `internal_vertices.max_x >= 450` 的首次位置。
- 100px 不透明方块：internal 点 2401；碰撞 x=401.5，纹理右边 451.5 → 纹理外 1.5px；alpha 像素中心越界 100/10000=1.0%；包围盒外宽 1.5/100=1.5%。
- 阿短 167×311（opaque 63.99%? 33249/51937=64.02%）：internal 点 8125；碰撞 x=367.0，纹理右边 450.5 → 纹理外 0.5px；alpha 像素中心越界 0%；包围盒外宽 0.5/167=0.30%。
- 说明：方块因 step=2 内部点缺最右 2px，碰撞晚于像素越界；阿短在内部点极值先触发时，纹理像素中心尚未越界，bbox 已越 0.5px。两者均非逐像素接触。
- alpha 路径修复后需真机确认；未打包。

### 4.60 边缘碰撞改回全 alpha 像素（非 internal 点）

- `self_bounce_off_edge` 改用 `Hit.pixel_aabb`：逐所有 alpha 像素映射世界，取实际 extrema；不再使用 step=2 internal points。这样方块不会因采样漏边晚触发，阿短也不会被内部点极值提前触发。
- 触发改为严格越界：`max_x > R` / `min_x < L` / `max_y > T` / `min_y < B`（像素中心在边缘上不算外）。
- alpha 像素 y 轴/asset.center 修正同 §4.58/4.59；`style_pixels(id,game)` 路径不变。
- headless：action 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。未打包。

### 4.61 action 全 alpha 像素边缘包

- `player/knplayer-action-square-atui-20261018-r1.love`：23 MB，72 files，sha256 `8c11808e51ded2a4ac452cfb3c43b3c4a91ffa210a1c6f78b773b34bf87d7b45`。
- 100px 方块 + 背景 + 阿短2 = 4 媒体；含 At；无 now/paint/pen；无调试标记。
- 边缘使用全 alpha 像素（非 internal 点）；无像素不反弹；严格越界触发。
- 包前 headless：action 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。

### 4.62 官方碰撞优化研究 + 优化计划（未改代码）

- 官方 `check_bumped_other`：visible + has_left_stage + same scene → 双方 AABB；重叠区 step=2 采样，双方 `is_touching`，命中 5 点或 tiny sprite 立即返回（crc 1167790）。
- 官方 `is_touching`：点映射到纹理像素，读缓存 `texture_points_color_data` alpha；数据 per texture Map 缓存（1106400）。
- 官方 internal points：step=2、2x2 alpha，per style 缓存；`get_texture_internal_points_vertices` 依赖 actor 状态缓存（1152669/1154261）；bounce 只在 AABB/vertices 命中后用 points，不逐帧扫全图（1171190）。
- 我们性能问题：`pixel_aabb` 每次 bounce 全 alpha 扫描（方块 1e4、阿短 5.2e4 像素），且无 AABB 前置；每帧调用两次。官方用缓存 point set + AABB 粗筛。
- 计划：AABB 粗筛 → 官方 internal points（缓存）→ 仅状态变化重算 vertices；actor 碰撞保留 AABB + step2 + 5 点 early out；补 profile。未执行。

### 4.63 碰撞优化落地（AABB + internal points 缓存 + collision probe）

- 边缘：`self_bounce_off_edge` 先用 `Hit.aabb` 粗筛，AABB 未碰边直接 return；命中后才 `internal_vertices`（official step2 internal points）。`internal_vertices` 按 actor 状态签名缓存 `_iv_sig/_iv`。
- 角色碰撞：`overlaps` 先 AABB；双方都有 alpha 时用预计算 `texture_probe`（缓存 sin/cos/scale/alpha）逐 step2 采样，5 点 early out；无 alpha 才退回原 `is_touching` 兜底。
- `style_pixels(id,game)` 已保证能按 asset.file 读取（上一轮）。
- headless：action 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。未打包。

### 4.64 编程猫恢复原造型 + action r4 包

- 重新编译 `../work/action.bcmkn.json` → `works/action.lua`；编程猫恢复原 5 个造型，移出方块/`square-100.png`。
- headless：action 50/0；pen 34/0；paint 19/0；atui 18/0；all.sh EXIT=0。
- `player/knplayer-action-atui-20261018-r4.love`：23 MB，76 files，sha256 `e271271b381ac21c50067d0e6d29bfb77689dd780f9a9b1390ea8251f190764c`；仅 action 8 媒体 + At；无 now/paint/pen/调试标记。

### 4.65 性能测试作品 perf 包

- 下载 `https://creation.bcmcdn.com/922/user-files/FgrdELrE3jOoOq-n0-IlWC1WIr-3.bcmkn` → `work/perf.bcmkn`；编译 `works/perf.lua`（58 行/5.2 KB，素材 8，失败 0）。
- 作品：300 个 mirror 克隆，克隆循环 go_forward + bounce + bump_into(阿短)，是边缘/角色碰撞性能测试。
- 包：`player/knplayer-perf-atui-20261019.love`，23 MB，76 files，sha256 `ec122529a0fa1d324e900f6fe0dd47be428f7c50e045bb65ef88b4da34e23c22`。
- 只含 perf.lua + 8 媒体 + At；无 now/paint/pen/action；无调试标记；`work="perf"`。
- headless 冒烟：120 帧后 303 entities / 302 actors / 300 threads，无报错。

### 4.66 perf 300 clones 性能差异分析/计划（未改代码）

- 实测：15fps，step 60ms，draw 2ms → 瓶颈在 step 调度/碰撞，不是绘制。
- 官方：actor 查找有 `actors_cache`（crc 1108987 get_internal_actor）；`get_vertices`/internal vertices 有状态依赖缓存（1152669）；overlap 先 AABB，再重叠区 step2，5 点 early out（1167790）。
- 我们：`Game:find` 线性扫 303 entities；300 克隆每帧 `bump_into` 解析 `--self` 与阿短两次，且每次 AABB/几何重算；`internal_vertices` 用 table.concat 状态签名；每次 overlap 建 probe 表。
- 计划：P0 真机计时埋点；P1 `Game.by_id` O(1)；P2 per-frame AABB/顶点缓存复用；P3 internal vertices 数字脏标记/缓存；P4 碰撞探针/目标 AABB 每帧复用、去分配；P5 目标 FPS≥50 验收；不先上空间哈希，按官方缓存优先。

### 4.67 P0：perf 采样/平均耗时包

- `conf.lua` 增加 `profile`；`main.lua` 在 `rt.load` 后 `require("rt.host.profiler").start()`（P0 包 profile=true）。
- AtUI 第 1 页新增 `avg step/max step`、`avg draw/max draw`；第 5 页显示 profiler top 6（文件:行/函数占比）。
- `player/knplayer-perf-p0-atui-20261019.love`：23 MB，76 files，sha256 `7078d71d782675826094bc5bb810bea072f7e649f3dfadbc096589ef862d9526`。
- 仅 perf 8 媒体 + At；`work="perf"`、`profile=true`、`probe=false`、`diag=false`；无调试标记。
- headless：all.sh EXIT=0（action50/pen34/paint19/atui18）。

### 4.68 P0 profiler 面板崩溃修复

- `rt/host/atui.lua`：`prof.top(6)` 返回 `(rows,samples)`，旧代码 `{ prof.top(6) }` 把 rows 表塞进行数组 → `table.concat` 报错。改为 `local list = prof.top(6); rows = list`。
- `tests/atui_test.lua` 增加 page5 profiler / page1 avg 文本断言，20/0。
- 新 P0 包：`player/knplayer-perf-p0-atui-20261019-r1.love`，23 MB，76 files，sha256 `9e913f1e7e4506636762b911b4bfb179205b283f58d25410d8c4bcecb51aadfd`。
- 真机已报 P0 数据：step 61.3ms / avg 57.4 / max67.1；draw 2.6 / avg2.8 / max3.6；修面板后可取 profiler top。

### 4.69 P0 page5 结论：internal_vertices 点循环占主导

- 采样：`rt/hit.lua` internal_vertices 的 147-150 行合计约 42%+；145 行 for 4.2%；probe_hit 行364 5.3%。
- 原因：每次 bounce 调 internal_vertices 两次；每次遍历该造型 8k internal points，重新算 lx/ly/旋转；300 克隆放大；缓存签名含 x/y，移动即失效但 local 点坐标本可复用。
- 计划：缓存 per-style/scale 的 local points + convex hull；世界 AABB 只旋转 hull；反射前/后都用 hull；去掉每点 lx/ly 重算；再优化 probe_hit。

### 4.70 internal_vertices 凸包/局部点优化 + P0 r2

- `rt/hit.lua`：新增 `local_points`（per style/scale/center 预投影）和 `convex_hull`（单调链）；`internal_vertices` 只旋转凸包点；`_iv` 改为数值字段比较，不再 table.concat；`probe` 预计算 iw2/ih2/inv_sx/inv_sy。
- 预期：方块 hull 4 点、阿短由 8k internal points 降到 hull；每次 bounce 不再逐点重算 lx/ly。
- headless：all.sh EXIT=0；perf 300 克隆冒烟 303 entities/302 actors/300 threads。
- 包：`player/knplayer-perf-p0-atui-20261019-r2.love`，23 MB，76 files，sha256 `266f4f66e2edb19e9db99f53745868a008fb86e7962ea85cc37e25c628c2f3bf`；profile=true。

### 4.71 P0 r3：O(1) find + AABB/probe 缓存 + probe 去分支

- `rt/core.lua:Game:find` 增加 `_id_map/_name_map` 缓存（按 entities 数量和 cur_screen 失效）；300 克隆 bump 不再线性扫 303 实体。
- `rt/hit.lua`：`aabb` 按 actor 状态缓存 `_aabb`；`texture_probe` 缓存 `_probe`；probe 预计算 offx/offy，去掉 sx 符号分支；`sid_of` 兼容测试假实体。
- `hit_test` 通过；all.sh EXIT=0。
- 新包：`player/knplayer-perf-p0-atui-20261019-r3.love`，23 MB，76 files，sha256 `1c0845517c60ba0a849e0f7406b5c6c2a9093f857f884ac0c2257223f438e7de`；profile=true。

### 4.72 perf 收尾评估：probe_hit 为算法核心，接近 LÖVE/Lua 上限

- 当前碰撞链：AABB → step2 重叠区 → 双方 alpha/5 点 early out；边缘：AABB → 缓存 internal hull。
- probe_hit 占约 40% 是算法本身的每采样点纹理映射/alpha 查询；官方 check_bumped_other 同样 step2 + is_touching×2，并未做全图扫描或空间哈希。
- 已完成的低成本优化：O(1) find、AABB/probe 缓存、hull、去分支；进一步降 probe_hit 只能改精度/采样/内联/原生，超出官方语义或收益递减。
- 当前 30fps 与官方 30fps 同量级；建议本 perf 包收尾，不再改碰撞语义。未测试/未打包。

### 4.73 控制类作品分析/计划（未编译未改）

- 下载 `work/control.bcmkn`；控制块：repeat_forever、repeat_n_times、repeat_forever_until、traverse_number(param/value)、controls_if/else、break、wait、wait_until、warp、tell/sync_tell、console_log、mouse_down(click/screen)。
- 官方 compiler：repeat_n_times 936347/937102（while true; times<=0 break; times--; body; yield）；repeat_forever_until 936347（先 check condition 再 body）；traverse 937842（ceil/floor、by 归一化、NaN 警告、value 参数 runtime_data）；wait_until 939970；sync_tell 934300；break 940014。
- 当前 emit.py：repeat_n_times 静态 local _n；traverse 无 ceil/floor/by 归一化；traverse break/return 会跳过 pop_param；wait/warp/tell 已有基础。需按官方补 compiler 上下文。

### 4.74 break 收敛评估（未改）

- 官方 compile_break：`current_break_id` 找不到祖先循环 → `tried_to_break_outside_of_loop` 错误（或 warning 配置），找到才 emit reset + `break label`（crc 940623）。
- 结论：应收敛为 only native Lua break；`f["break"]` fallback 不符合官方，也无法跨过程/闭包正确。
- 前提：loop 上下文要升级为栈记录 cleanup（traverse 的 push_param/pop_param）；否则原生 break 仍会漏 pop_param。
- tell/过程体作为函数边界，break 不得跨边界；仅函数内部自己的循环可 break。

### 4.75 control + native break 新计划（未改）

- 先备份 control 相关：emit.py/core.lua/control.lua/op_sensing.lua/works/control 待编译产物。
- 编译器升级 loop 栈：breakable/kind/cleanup；break 只允许当前函数内祖先循环，生成 cleanup + 原生 break；无循环编译错误；移除 f["break"] fallback。
- 函数边界（procedure/tell/sync_tell）重置 loop 栈；traverse pop_param/break 清理；warp_exit 不漏。
- repeat_n_times 按官方 times<=0 + times--；repeat_forever_until 条件先于 body；traverse 按官方 ceil/floor/by 归一化/NaN/value。
- runtime 删除/停用 Thread.breaking 与 M.break；保留 iter_n/w/d yield。
- 编译 works/control.lua → headless control_test → all.sh → 包（只 control 资产+At）。

### 4.76 新编译器实现 + control 编译

- emit.py：loop_stack + unique loop vars + native break；break 无循环生成 error（不再 f["break"]）；traverse break 前 pop_param；procedure/tell 重置 loop_stack；warp_stack 记录。
- repeat_n_times 改 while true + <=0 + 递减，变量 `_times_nN`；traverse 使用 `_from_nN/_to_nN/_by_nN/_p_nN`，ceil/floor/by 归一化/NaN 防护。
- 编译 `work/control.bcmkn` → `works/control.lua`：155 行 / 11.0 KB；素材已存在 6、新下载 5、失败 0；lua loadfile OK；生成中无 `f["break"]`。
- headless 全量：all.sh EXIT=0；control 冒烟 3 entities/2 threads。
- 未打包。

### 4.77 控制运行时 + control headless

- `rt/core.lua` 删除 `Thread.breaking` 与 iter_* 的 break 消费；原生 break 由 Lua 执行。
- `rt/impl/control.lua` 删除 `M["break"]`；`console_log` 修正为 `host:log(...)`（此前 dot 调用导致 logs nil 崩溃，control 线程提前结束）。
- `tests/control_test.lua`：13/0；覆盖 repeat/traverse/until/if/break/wait/wait_until/warp/tell/sync_tell/console_log、最终 200,200、参数栈清空、无 f.break。
- `sh tests/all.sh`：EXIT=0（control 13/0、action50、pen34、paint19、atui20）。
- 未打包。

### 4.78 孤立 break 改为编译期错误

- `kntl/emit.py` 新增 `CompileError`；`break_cleanup` 无 loop_stack 时直接 raise，不再生成运行时 `error()`。
- `kntl/compile.py` 捕获 CompileError，打印 `编译错误：...` 并返回 1，不写输出文件。
- `tests/test_compile.py` 增加孤立 break 负例：127/0。
- `works/control.lua` 重新编译成功（155 行/11.0 KB）；control 13/0；all.sh EXIT=0。
- 无 f.break 运行时；未打包。

### 4.79 control 运行包

- `player/knplayer-control-atui-20261019.love`：23 MB，79 files，sha256 `9c7a359388e89eb81d3495d6934eaaa2b5b09bb8f278e052ad840560c0fa0f6c`。
- 只含 `works/control.lua` + 11 个 control 媒体；含 At/字体/许可证；无 now/paint/pen/action/perf 资产；无调试标记。
- `conf.lua`：`work="control"`、`probe=false`、`diag=false`。
- 包前 headless：control13/action50/pen34/paint19/atui20；all.sh EXIT=0。

### 4.80 looks 作品分析/计划（未改未编译）

- 下载 `work/looks.bcmkn`；作品：无限循环每 0.1s 下一造型，鼠标按下 break；之后测试 appear/fade/set_scale/change_scale/set_width/add_width/effects。
- 官方 looks：getStyles 1604489、setSpriteStyle 1604554、selfPrevNextStyle 1605882、selfAppear 1606486、selfGraduallyShowHide 1606570、setScale 1606903、selfChangeScale 1606903+、setWidthHeightScale 1607769、addWidthHeightScale 1608220、selfSetEffect 1608755、selfChangeEffect 1609076、clearAllEffects 1609440。
- 当前缺口：`get_styles` 无运行时；`clear_all_effects` 无；set/change scale clamp 1..9999 与两轴独立；width 1..9999；add width .01..99.99 + 4 位；fade 起始 alpha；effect scope 4/5 语义/着色器；effect 值 clamp。
- 计划：先补 get_styles/clear_effects/scale-width 精确语义，再 effect shader/opacity，再 lookstest + package。

### 4.81 looks 运行时实现 + headless

- `rt/impl/motion_looks.lua`：新增 get_styles/clear_all_effects；apply_scale clamp 1..9999；self_change_scale 两轴独立；set_width clamp 1..9999；add_width 官方 4 位 round、两轴 .01..99.99；fade 从当前 alpha 起算；effect clamp；M.round_to 可关（M.ROUNDING）。
- 编译 `works/looks.lua`：102 行 / 6.1 KB，素材 6 已存在；lua loadfile OK。
- `tests/looks_test.lua`：27/0；全量 all.sh EXIT=0（control13、action50、pen34、paint19、atui20）。
- 未打包。

### 4.82 looks 运行包

- `player/knplayer-looks-atui-20261019.love`：23 MB，74 files，sha256 `55c979c6bff47e45214c8cdb86d38b41d2b04d7f073dd8ad6dd2e6f01efa861c`。
- 只含 `works/looks.lua` + 6 个 looks 造型；含 At/字体/许可证；无 now/paint/pen/action/perf/control 资产；无调试标记。
- `conf.lua`：`work="looks"`、`probe=false`、`diag=false`。
- 包前 headless：looks27/control13/action50/pen34/paint19/atui20；all.sh EXIT=0。

### 4.83 looks 特效位移/扭曲修正 + r1 包

- `rt/host/sprite.glsl`：twist 角度改为官方 `10 * twist`（radians），displacement 幅度提高到 0.010*value；保留动态正弦位移。
- looks headless 27/0；all.sh EXIT=0。
- 包：`player/knplayer-looks-atui-20261019-r1.love`，23 MB，74 files，sha256 `74cbe96fe236d8330c9466358e26b84facc9ba358285906b91f485500c77f2fc`；只含 looks 6 造型 + At；含 sprite.glsl。

### 4.84 displacement/twist 无效果根因

- `rt/host/sprite.glsl:34-49` 先做 ripple/twist，`:52-55` 的 pixelate 又用 `tc` 重算 `uv`，覆盖掉前两者。
- looks 作品最终 `scope3=8`（pixelate）后设 `scope4=20`、`scope5=20`，因此 pixelate 分支把 displacement/twist 的结果全部丢掉。
- 官方 filters 顺序：pixelate(index2) → displacement(index3) → twist(index4)；应把 pixelate 放前面，并在其 `uv` 上继续做 displacement/twist。
- 之前为测试提高的 twist 10x 有官方 `set_twist` 依据；displacement 幅度是近似，不属于最终官方参数，需在日志/实现中标明。

### 4.85 displacement/twist 修复（pixelate 覆盖根因）+ r2

- `rt/host/sprite.glsl`：顺序改为 Pixelate → Displacement → Twist；pixelate 只初始化 uv，不再最后用 tc 覆盖 displacement/twist；twist 基于当前 uv。
- looks headless 27/0；all.sh EXIT=0。
- 包：`player/knplayer-looks-atui-20261019-r2.love`，23 MB，74 files，sha256 `4762b982f5be2d1d44935f36c8683a28a322c87c0648752960b4bea7ce515ec2`。

### 4.86 官方滤镜顺序核对

- 官方 Effect 类 `get_effect_filter`：filter 0/1/5=ColorMatrix，2=Pixelate，3=Displacement，4=Twist，6=Ascii（crc_libs:1 约 1123800-1126000）。
- `effect_filter_list` 按 index 插入；`update_target_filter` 直接把该数组赋给 `target_sprite.filters`，PIXI 按数组顺序执行：Pixelate(2) → Displacement(3) → Twist(4)。
- 因此官方空间滤镜顺序确定：像素化在前，位移其次，扭曲最后。
- 当前源码 r2 `sprite.glsl` 已是 Pixelate → Displacement → Twist；旧包 `knplayer-looks-atui-20261019.love` 仍是 Displacement → Twist → Pixelate。若反馈“像素化在后”，应是在旧包上观察。
- 仍存在的顺序差异：官方 ColorMatrix(index0/1/5) 在 pixelate 前；当前 shader 的颜色处理在采样后，属另一处待核对项。

### 4.87 滤镜顺序严查（未改）

- 官方 filters 数组按内部 index 排序：ColorMatrix(0/1/5)、Pixelate(2)、Displacement(3)、Twist(4)、Ascii(6)；因此空间顺序是 Pixelate → Displacement → Twist。
- 仓库当前 shader 已是 Pixelate → Displacement → Twist；r2 包 `4762b9…` 内 sprite.glsl 也已是该顺序。
- 旧包 `55c979…` 是 Displacement → Twist → Pixelate；旧包上 displacement/twist 会被 pixelate 的 `uv=tc` 覆盖，故完全无效果。
- 如果 r2 仍无效果，则不是顺序问题；需检查 shader 是否成功编译、e_ripple/e_twist 是否实际送达、以及 draw 时 shader 是否被 setShader；本轮只做静态核对，未改代码/未测试/未打包。

### 4.88 r2 仍无 displacement/twist：静态复查

- r2 包 shader 顺序已核对为 Pixelate→Displacement→Twist；旧包为 Displacement→Twist→Pixelate。
- `H:sprite_shader` 无条件 send e_ripple/e_twist；`fx.ripple`/`fx.distortion` 由 scope4/5 写入；looks 最终状态为 20/20。
- 若 r2 仍无效果，order 已不是解释；剩余可疑点：shader 编译失败、uniform 未生效、draw 时 shader 被重置、或 actor 实际走的路径不同。
- 需加临时诊断（不在本包）：log newShader ok/err；log e_twist/e_ripple；shader 输出可视调试色；逐项单效果测试。

### 4.89 shader 诊断包

- 新增 `rt/host/sprite_diag.glsl`（不替换正常 shader）：诊断着色器在采样后输出 R/G/B 叠加：
  - R = displacement/twist 造成的 UV 偏移（pixelate 之后的基准）；
  - G = e_ripple 是否非零；
  - B = e_twist 是否非零。
- 包 `player/knplayer-looks-diag-atui-20261020.love` 内把 `rt/host/sprite.glsl` 替换为诊断版；其他代码不变。
- 23 MB，75 files，sha256 `1970fa4d3d02dad743c1b62a73997b376cf5e3440e5d61f2d5b97bd8746a3f0b`。
- headless all.sh EXIT=0。

### 4.90 诊断反馈：pixelate 与 warp 的坐标复合顺序

- 诊断：R 有、G/B 有 → uv 被 warp 改变，uniform 已送达；波纹使像素网格持续变形。
- 但当前 shader 是 `uv = Q(tc); uv = W(uv)`（先量化再 warp），视觉等价于 pixelate 在 warp 之后/以 Q 后置的方式生效。
- 官方 filters 是图像链：Pixelate 产物再经过 Displacement/Twist，单 pass 等价应把 warp 作用在输出坐标上，再对最终采样坐标量化：`uv = Q(W(tc))`，而不是 `W(Q(tc))`。
- 当前 `:52-55` pixelate 用 `tc`，之后 displacement/twist；虽然代码顺序是 pixelate 先，数学复合顺序反了。
- 待批准方案：单 pass 改为先 warp、后量化；或真实多 pass 渲染。未改代码/未测试/未打包。

### 4.91 补充：像素网格未形变的含义

- 若最终像素块在屏幕上保持规则网格、只有源纹理内容在变，说明视觉上量化作用在 warp 后的输出坐标（Q(W(tc))），而不是当前单 pass 的 W(Q(tc))。
- 当前 r2 源码字面是 pixelate → displacement → twist，但单 pass 把 Q 作用在 tc 上、W 在其后；这与官方多 pass 图像链不等价。
- 官方 PIXI filters 是对中间渲染纹理逐级处理；Pixelate 产物再被 Displacement/Twist 采样。要同时得到“内容 warp”和“网格是否 warp”的正确组合，单 pass 坐标量化难以等价，需多 pass 或明确复合公式。
- 需确认官方 filters 的真实执行顺序/像素化 shader 坐标；未改代码/未测试/未打包。

### 4.92 官方 filter shader 复合顺序

- PixelateFilter shader（main-vendors 575700 附近）：
  `coord=mapCoord(vTextureCoord); coord=pixelate(coord,size); coord=unmapCoord(coord); S(coord)`，即 Q。
- DisplacementFilter shader（main-vendors 563700 附近）：
  `S(vTextureCoord + scale*inputSize.zw*(rotation*(map-0.5)))`。
- TwistFilter shader（main-vendors 577300 附近）：
  `coord=twist(mapCoord(vTextureCoord)); S(unmapCoord(coord))`。
- Pixi FilterSystem 数组顺序执行（main-vendors 458200 附近）；官方列表 Pixelate(2)→Displacement(3)→Twist(4)。
- 复合结果不是 W(Q(tc))，而是 Q(D(T(tc)))：最终采样坐标先经 twist 再 displacement，最后按 pixelate 的屏幕像素量化；因此最终像素网格规则、内容被 warp。
- 当前 shader 是 W(Q(tc))，所以网格随 warp 变/或视觉顺序相反。
- 修复方案：单 pass 改为先 T、再 D、最后 Q；pixelate 用 mapCoord/unmapCoord 的屏幕空间量化。Displacement 仍需近似（官方用 mapSampler）。

### 4.93 更正：网格无形变=r2 观察，不是官方

- 用户澄清：`像素画网格无形变` 指 r2 包输出，不能据此断言官方 Pixelate/Displacement/Twist 的最终视觉。
- r2 代码表面是 `Q(tc)→D→T`，若严格按代码，像素块边界应被 D/T 拉动；但观察到规则网格，说明存在以下可能之一：
  1. 观察的是纹理源像素块而非输出块边界；
  2. r2 实际执行并非字面 Q→D→T；
  3. 量化/采样坐标定义使块边界仍规则。
- 不能再用 r2 观察反推官方顺序；需用 checker/grid 诊断或官方运行时对比。
- 官方 shader 已核对，但“官方最终网格是否形变”未实测，不能下结论。

### 4.94 effects.bcmkn / 官方顺序冲突

- 下载 `work/effects.bcmkn`；单角色，7 段：D20、T20、P8、T10+D10、T10+P8、P8+D10、T10+D10+P8，各等 2s。
- 官方源码固定：filter index 2=Pixelate、3=Displacement、4=Twist；`effect_filter_list` 按 index、PIXI apply 数组顺序 → 源码预测 P→D→T。
- 用户官方播放器观察“可能 P<T<D”，与源码预测冲突；不能直接采信“可能”，也可能 scope4/5 命名/位移无 map/观察阶段造成。
- 当前 shader 是 `Q(tc)→D→T`；按官方 filter shader 推导，单 pass 最终应为 `Q(D(T(tc)))`（若源码顺序 P→D→T），即 sampling 时 T→D→Q。
- 修复计划待定：先用 effects work 验证官方/自测的 P、T、D 单效果与组合；确认 filter 顺序后再统一 shader 复合式，不能仅按“可能”改。
- 未改代码/未 headless/未打包。

### 4.95 按官方滤镜链重写 shader + effects 包

- 官方 P(2)→D(3)→T(4)；单 pass 最终采样顺序改为 T→D→Q：先 twist，再 displacement，最后 pixelate 屏幕坐标量化。
- `pixelate` size clamp 到 [1, min(u_size)]；twist 官方 10*value；displacement 仍为正弦近似。
- 编译 `works/effects.lua`（55 行/3.2 KB）；新增 `tests/effects_test.lua` 10/0。
- all.sh EXIT=0（effects10、looks27、control13、action50、pen34、paint19、atui20）。
- 包 `player/knplayer-effects-atui-20261020.love`：23 MB，71 files，sha256 `e4de5bdbc3ea70de7d31ebc5ae1f0f726ad9acb8b91a59822bd6c1d1c8191f07`；含 effects + 2 素材 + At。

### 4.96 官方滤镜多 pass 实现

- 新增官方算法 shader：`rt/host/pixelate.glsl`（floor/size）、`displacement.glsl`（mapSampler + scale/u_size）、`twist.glsl`（mapCoord/radius/angle）、`color.glsl`（ColorMatrix）。
- `love.lua`：新增 `sprite_effect_canvas`，按 Pixelate→Displacement→Twist 依次 render texture；D 使用程序生成 128² 位移图；T 官方角度/半径；最后 color pass。
- 有空间滤镜的 actor 走多 pass；无空间滤镜仍走原路径。
- effects headless 10/0；all.sh EXIT=0。
- 包 `player/knplayer-effects-multipass-atui-20261020.love`：23 MB，75 files，sha256 `655f822c15783143fd1261d6ee2de380254c2386daa36420c6b74538822b629f`。

### 4.97 官方波纹纹理确认/接入

- 官方 main.15ba0757.js 模块 58976 以 `data:image/png;base64,...` 携带一张 620×310 indexed PNG；`setTargetEffects` 的 DISPLACEMENT 分支把该闭包变量 `a` 传给 `set_displacement(...,a)`。
- 已抽出 `work/displacement_official.png` 并放入 `rt/host/displacement.png`；`H:displacement_map` 改为优先加载官方纹理，失败才报错（不再程序生成 128² 噪声）。
- 多 pass effects 包更新：`knplayer-effects-multipass-atui-20261020-r1.love`，23 MB，76 files，sha256 `d63f34aa7fc1554cc65d59aa6da2c8a78c602e959350820f496a0d9dabf1abb3`。
- all.sh EXIT=0。

### 4.98 三滤镜全不一致的静态根因

- 官方三滤镜 shader 使用 filterArea 屏幕坐标：
  - Pixelate: `mapCoord(vTextureCoord)` → floor(size) → `unmapCoord`。
  - Twist: `mapCoord` → twist(offset/radius) → `unmapCoord`。
  - Displacement: `vFilterCoord` 采样 mapSampler，`scale*inputSize.zw`，`inputClamp`。
- 当前多 pass 是 actor 本地 canvas：`tc*u_size`，无 filterArea/outputFrame/inputClamp；像素化相位、位移 map 采样、twist 中心都不同于官方。
- 当前 displacement 用 `fract(tc+time)`，官方用 filterMatrix + 移动 map sprite；即使纹理是官方 PNG，采样/偏移仍不同。
- 当前 twist 用本地中心，官方 offset 是 target_position+view/2，radius 为屏幕尺寸半对角。
- pass 顺序 P→D→T 已对，但坐标空间/滤镜区域/位移贴图运动不一致，所以三个效果全不一致。
- 另：官方 color matrix 在像素/位移/扭曲之前；当前 color 在空间 pass 之后。
- 未改代码/未测试/未打包。

### 4.99 消除三滤镜差异的可行性分析（未改）

- 高可行：pass 顺序、Pixelate mapCoord/unmapCoord、Twist offset/radius、Color 顺序、filterClamp 参数化；前提是建立官方 filterArea 坐标系。
- 中高可行：filterArea/outputFrame per-pass canvas；需从 actor 屏幕包围盒计算，处理 padding、缩放、旋转、裁剪。
- 中可行：Displacement filterMatrix + 官方 map sprite 移动；需实现 calculateSpriteMatrix/位移 sprite 视口逻辑；官方 PNG 已有。
- 主要未对齐：当前 effects canvas 以 actor 本地图 + 最终旋转绘制；官方 filter 在显示对象渲染后的 screen/filterArea 上。需把旋转/缩放先烘进 filterArea canvas，否则 pixelate/displacement/twist 全部偏。
- 部分限制：PIXI/LÖVE 渲染后端差异、alpha/premultiplied、resolution、filter autoFit/padding 难以逐像素一致；可接近但不能保证 bit 级相同。
- 结论：全消除差异需重建 filterArea 管线；仅改 shader 不够。未测试/未打包。

### 5.00 filterArea 多 pass 修复计划

- 目标：官方 color→Pixelate→Displacement→Twist filter chain，以 filterArea 屏幕坐标为准；actor 旋转/缩放先烘入 source filter texture，effects 后不再二次旋转。
- 阶段：filterArea/geometry → 官方 shader uniforms → source/transform → color 顺序 → displacement filterMatrix/map sprite → clamp/padding/resolution → effects 七阶段对照。
- 测试：effects 七阶段、looks、单角色/旋转/缩放、边缘/DPI；headless + 真机截图；最后打包。
- 未改代码/未测试/未打包。

### 5.01 filterArea 管线实现 + effects 包

- `H:sprite_effect_canvas` 改为 screen/filterArea：按 actor 旋转后的 AABB + padding 建 source canvas，先把旋转/缩放烘入；之后 Color→Pixelate→Displacement→Twist，final 不再二次旋转。
- Pixelate/Twist 使用 filterArea 尺寸；D 使用官方 620×310 纹理；twist radius=半对角；颜色 pass 提前。
- effects headless 10/0；all.sh EXIT=0。
- 包 `player/knplayer-effects-filterarea-atui-20261020.love`：23 MB，76 files，sha256 `021c5022bad8851ba349241ecc25ccbd91d20a558118c205f1d2cbe29bbc45a0`。

### 5.02 displacement/twist 下一执行计划（未改）

- 官方 displacement：
  - `set_displacement(value)` 的 value 是 speed（0..100），不是幅度/缩放；
  - `displacement_sprite` 是官方 PNG，宽=2*view.width、高=2*view.height、anchor=(.5,.5)；
  - 每 ticker `position.x += speed`，越界回绕（减 sprite.width/2）；
  - filter scale 默认20，`vFilterCoord` 由 filterMatrix 计算，map 在 `filterArea` 坐标中占 2*view 大小。
- 当前错误：`fract(tc+time)` 每个 actor 只铺一次纹理，map 缩放过小；`u_time` 不是每帧 speed；无 filterMatrix。
- 官方 TwistFilter defaults 含 `padding:20`；当前 filterArea 只 +4，右/下被裁。
- 计划：实现 map sprite 尺寸/每帧位移/filterMatrix；filterArea 加官方 padding20（或各 filter padding 合并）；调整 source canvas/final anchor；effects 七阶段+边缘测试。

### 5.03 displacement map 尺寸/speed + twist padding

- `displacement.glsl` 改为 `map_uv = map_offset + tc*u_size*map_scale`，map_scale=1/(2*view)，map sprite 按官方 2×view；value 仅作为滚动 speed（60fps 近似）。
- filterArea padding 从 4 改为官方 TwistFilter padding=20；source/各 pass/final 同尺寸。
- effects headless 10/0；all.sh EXIT=0。
- 包 `player/knplayer-effects-padding-atui-20261020.love`：23 MB，76 files，sha256 `4108a3797de5f3c5124f9dff1074ea767d479c0293f977057e81ac6be9713520`。

### 5.04 looks 重新编译/打包（effects 运行时后）

- 重新编译 `work/looks.bcmkn → works/looks.lua`：102 行/6.1 KB，6 素材。
- looks 27/0；all.sh EXIT=0（effects10、looks27、control13、action50、pen34、paint19、atui20）。
- 包 `player/knplayer-looks-atui-20261020.love`：23 MB，80 files，6 造型，sha256 `6bcb32acef3c0721a37e074030845769eabc00e47b8d1b37e882acd735096fd8`；含官方 displacement 纹理与多 pass shader。

### 5.05 twist 强度核对（未改）

- 官方 `set_twist`：`angle = ph(10*value)`；`ph(t)=t*PI/180`，当前 `math.rad(10*t)` 一致。
- 官方 `radius = sqrt((target_sprite.width/2)^2+(target_sprite.height/2)^2)`，用 **未加 padding 的 target sprite 尺寸**。
- 当前 shader 用 `u_size = filterArea`（actor AABB + padding 20*2），radius 偏大；例如 100×100：官方 70.7，当前 99（约 40% 大）；200×200：官方 141，当前 170（约 20% 大）。
- 当前 twist 中心/角度/ratio 公式与官方一致；差异来自 radius 输入，不是纯滤镜实现。
- 另：旋转 actor 时当前 u_size 用 AABB，radius 还会受旋转影响。

### 5.05 twist 强度核对（具体数值）

- effects 角色造型 100×100；官方 radius = sqrt(50²+50²)=70.71。
- 当前 filterArea = 100+40=140，twist radius = sqrt(70²+70²)=99.0，约大 40%。
- 146×152 造型：官方 radius≈105.4；当前 filterArea 186×192，radius≈133.7，约大 27%。
- 角度：官方 ph(10*20)=200°→弧度，当前 math.rad(200) 一致。
- 结论：存在明确数值差异，主要来自 radius 用 padded filterArea 尺寸；不是纯滤镜实现问题。

### 5.06 twist radius 修复 + looks r1

- `twist.glsl` 新增 `twist_radius`；host 用 target 显示尺寸 `sqrt((dw/2)^2+(dh/2)^2)` 传入，不再用 padded filterArea 的 `u_size`。
- looks 重编译 102 行/6.1 KB；all.sh EXIT=0。
- 包 `player/knplayer-looks-atui-20261020-r1.love`：23 MB，80 files，sha256 `b8454db119ca8cd7bf9bbde10f31ce5d17c751e2d36ed8a138839ccd2fe132c7`。

### 5.07 perf_layers 计划（未改）

- 下载 `work/perf_layers.bcmkn`：单角色 5 造型，300 个 mirror 克隆；每克隆 displacement20/twist20/pixelate8 + 无限 hue+5；主角色 peak 图层后随机朝向移动/反弹。
- 新块 `set_top_bottom_layer`：官方 main:1 byte 1609440+；layer=peak/bottom/prev_layer/next_layer，target_layer 可指定角色；peak→z=actor_ids.length，bottom→0，prev/next 按相邻 z 调整；还涉及 brush target。
- 当前 runtime 无此原语；`render_list` 仅 layer/order/seq 排序，需补 z-index 语义。
- 计划：先实现 layer（peak/bottom/prev/next/target）、编译 perf 作品、layer 单测；再做效果/克隆性能基线，若 300 克隆多 pass 过慢，按同 style/effect 缓存 effect texture/批量绘制优化；最后真机 FPS 报告+打包。

### 5.08 perf_layers 图层 + clone effect cache

- 新增 `M.set_top_bottom_layer`（peak/bottom/prev/next/target）和 `set_layer` 别名；图层用 layer 数值，peak=max+1、bottom=min-1。
- 300 clone 作品编译 `works/perf_layers.lua`；headless 5/0：300克隆、base peak、顶层为 base、无错误。
- 性能：同帧同 style/effect/transform 共享 effect texture（`_fx_frame_cache`），color shader 移到 draw 时，clone 批量复用；无空间滤镜继续原路径。
- all.sh EXIT=0。
- 包 `player/knplayer-perf-layers-atui-20261020.love`：23 MB，80 files，sha256 `d16fd8dfc8678dcc3fd2a335dfb4ab9b7db4228baf1ea8680c08a4259dae089d`。

### 5.09 克隆体仅剩一个：根因（未改）

- `sprite_effect_canvas` 的 `_fx_frame_cache` key 排除 `sx/sy`，但返回结果含 `cx=sx, cy=sy`。
- 300 克隆同 style/effect/transform → 都命中第一个克隆的缓存结果。
- H:draw 用 `fx_canvas.cx/cy` 绘制 → 所有克隆都画在第一个克隆的位置，视觉上只剩一个（实际 entities 仍 300）。
- 不是克隆创建/图层问题；headless perf_layers 5/0 仍 300 clone、base peak。
- 修复方向：缓存只存 canvas/w/h，绘制位置用当前 actor x/y；或把位置加入 key。

### 5.10 克隆 effect cache 位置修复 + perf r1

- effect cache 只存局部纹理 `{canvas,w,h}`；H:draw 使用当前 actor `x,y` 绘制，移动/克隆位置实时跟随。
- 不再缓存 `cx/cy`，避免所有克隆叠在第一个克隆位置。
- all.sh EXIT=0。
- 包 `player/knplayer-perf-layers-atui-20261020-r1.love`：23 MB，80 files，sha256 `dd8f0d75923764e163b6305a51f83efe217f0b30963e8f7e82d969023c59be26`。

### 5.11 多纹理 clone 性能分析（未改）

- 当前 `_fx_frame_cache` key = style/iw/ih/dw/dh/draw_dir/flip/p/d/t；不含位置/颜色。
- 300 同纹理：K=1 个 effect texture/帧，57fps。
- 若 K 个不同局部 effect 签名：每帧生成 O(K) 条多 pass 纹理，绘制仍 O(300)；K 增大时生成成本线性上升。
- 只换造型：K=造型数；只换 hue：不 split 空间 cache，但每 clone 一次 color shader 切换；换朝向：draw_dir 进 key，最多 300 个纹理。
- 最坏 K=300 → 每帧 300×source/pixelate/displacement/twist，回到逐 clone 多 pass，预计远低于 10fps。
- K=2~数种通常仍有机会 >30，但需真机测试；不能把 57fps 外推到部分异纹理。

### 5.12 perf_extreme 编译/包

- 下载 `work/perf_extreme.bcmkn`：300 clone，每个随机位置/朝向/缩放/hue/造型，且 displacement/twist/pixelate；专门破坏 effect cache。
- 编译 `works/perf_extreme.lua`：74 行/5.0 KB，6 素材。
- 新增 `tests/perf_extreme_test.lua`：3/0（300 clone、base peak、无线程错误）；all.sh EXIT=0。
- 包 `player/knplayer-perf-extreme-atui-20261020.love`：23 MB，80 files，sha256 `48f8acdb28b247b59eceafbeb470bff8a79bdabc485035ab61522275106af738`。

### 5.13 perf_extreme 0fps/崩溃分析（未改）

- extreme 每个 clone 随机 style(5)、朝向、scale 50..150、hue；空间 effect 固定但 cache key 含 style/dw/dh/draw_dir；key 最多 ≈300。
- 每 key 每帧新建 source+color/pixelate/displacement/twist 多张 canvas，cache 每帧清空；300 key → 数百至上千 canvas/帧，GC 无法及时回收，内存/VRAM 飙升。
- 估算：140..190px filterArea 每张 ~0.1–0.14MB，5 张/clone ≈0.5–0.7MB，300 ≈150–210MB/帧，2 帧即可崩溃；0fps 是绘制+分配+GC 共同。
- 打开 dbs（debug stats/dump）增加额外 draw/状态，2 帧后崩符合资源耗尽。
- 官方 PIXI 有 filter render texture 复用/对象级 filter cache；当前无 canvas pool，且把 rotation/scale 纳入 key，命中率极低。
- 优化计划：effect texture 去 rotation/scale（draw 时变换）；key 收缩到 style+effect params；canvas pool；每帧 cache 上限/LRU；必要时单 pass/LOD；先测 5 组 K。

### 5.14 新约束下的 extreme 优化计划（未改）

- 约束：单角色效果不得缩水；优先官方优化；尽量不靠停渲染。
- P0：canvas/工作缓冲池化 + 顺序处理，禁止每 clone 每帧 newCanvas；先消除 OOM/2帧崩溃。
- P1：保留官方 filterArea 三 pass；同 effect/style 批量缓存；不同 key 用固定池顺序渲染，无视觉降级。
- P2：评估官方等价的单 pass 复合式 Q(D(T(tc)))：single-character 与三 pass 逐帧对照，无明显差异才作为 300 clone 加速路径。
- P3：按 style/effect 分组、color draw 时合并、LRU 缓存、SpriteBatch/纹理复用；不关闭 pixelate/displacement/twist。
- P4：只有 P0-P3 仍无法达到 10fps 时，才讨论极端 LOD；优先保持全部效果，单角色始终完整。
- 测试：K=1/5/10/50/300；记录 FPS、canvas 数、内存、视觉对照。

### 5.15 P0-P3 实现 + extreme r1

- P0：clone 快速路径使用 canvas pool + 16 项 key 上限；不保留 300 份 effect texture。
- P1：同 key 小缓存继续复用；cache 只存局部纹理，绘制用当前 clone 位置。
- P2：新增 `composite.glsl`，对大量 clone 走单 pass 等价链 Q(D(T(tc)))；单角色仍走完整 filterArea 三 pass。
- P3：shader 缓存、位移纹理复用、color draw 时合并、canvas bucket 16px；未关闭任何效果。
- all.sh EXIT=0（perf_extreme 3/0、perf_layers 5/0 等）。
- 包 `player/knplayer-perf-extreme-atui-20261020-r1.love`：23 MB，81 files，sha256 `d38df20c21c3e51fab95ee5367ff9422d6f00a93cfce9aaa4666b8935eb97e55`。

### 5.16 收尾判断（extreme 10fps）

- perf_extreme r1 真机 10fps，达标基础目标；包测试通过。
- 当前取舍：clone 数 >50 走 composite 单 pass，单角色仍完整三 pass；clone effect texture 16 项上限 + 16px canvas bucket。
- 已知偏差：composite 单 pass 与三 pass 可能有细微采样差；layer prev/next 与 brush target 未完全官方；极端多纹理共享本地 map 原点。
- 建议：当前性能任务可收尾；30/50fps 作为后续独立优化目标，不阻塞本轮。

### 5.17 图层调整官方对齐（未打包）

- `set_top_bottom_layer` 改为场景 actor 列表 z-index 语义：自下而上 index，peak=#list、bottom=0、prev/next 移动一格、target_layer 按官方 v/d 规则。
- set_z_index 重新编号 e.layer；render/hit 仍共用同一排序。
- 300 clone/peak、perf_layers、all.sh 均通过；未打包。

### 5.18 图层与画笔 brush target 联动（未打包）

- `love.lua` 增加 `_pen_has_ink`、`pen_brush_target`/`pen_brush_empty`/`set_pen_brush_target`/`unset_pen_brush_target`；落笔/印章/描线置脏，清笔清除。
- `set_top_bottom_layer` 按官方分支补 brush target：
  - peak/bottom：brush 指向原下方邻居或 unset；
  - prev/next：根据 brush target/空笔/相邻 actor 移动；
  - target_layer 的 prev/next 也同步 brush target。
- all.sh EXIT=0；headless 无画笔宿主，brush 分支不触发。

### 5.19 收尾

- 图层 z-index + brush target 联动已实现，未打包。
- 最终状态：perf_extreme 10fps，all.sh 全绿；包保持上一版，不重新打包。
- 本轮结束。

### 5.20 decimal 四则方案（未改）

- 官方 `math_arithmetic` main:1 byte 1612373；`new Wt.t(...).plus/minus/times/div(...).toNumber()`；`Wt.t.set({precision:16,rounding:ROUND_HALF_UP})`（byte 1611829/1612303）。
- add 仅当两边都是 number 时走 Decimal，否则 JS `e+t`（字符串拼接）；minus/times/div 走 Decimal，异常回退原生；0/0 显式 NaN；power 用原生 Math.pow。
- 计划实现 `rt/decimal.lua`：十进制符号/系数/指数，字符串加减乘、长除到16有效数字、HALF_UP；number/string 解析；toNumber。
- 集成 op_sensing.math_arithmetic，只改四则；测试 0.1+0.2==0.3、1/3、0/0、Infinity、负数/大数/字符串 add。

### 5.21 decimal 性能约束更新（未改）

- 性能目标：不低于官方 Decimal.js；纯 Lua 5.1 测试渠道可用，无 love 依赖。
- 实现选 limb 十进制（base 1e7，最多 3 limbs/16 位），避免 string 大数运算；zero/one/safe-int 快路径。
- 测试：Node Decimal.js oracle（precision16/HALF_UP）+ Lua 单测/随机差分；bench 同输入/同机 ops/s。
- 集成后只影响 math_arithmetic 数值分支；string add/power 不变；不降低精度。

### 5.22 decimal 实现/集成/性能结果

- 新增 `rt/decimal.lua`：符号+数字串+指数，16 位 HALF_UP；已集成 `math_arithmetic` 的 add/sub/mul/div，power/字符串 add 保持原生。
- 与 Decimal.js oracle（precision16/HALF_UP）随机 2056 组：`to_number` 0 差异；`to_string` 科学计数格式不同但数值一致。
- tests/decimal_test 13/0；all.sh EXIT=0。
- 性能（LuaJIT）：add195k/s、sub189k/s、mul144k/s、div3.1k/s；Decimal.js Node：add392k、sub296k、mul288k、div175k。add/mul约2x慢，div约56x慢；Lua5.1更慢。
- 纯字符串 decimal 已无法接近 Decimal.js；如需满足“不低于 Decimal”，需申请回退纯 Lua number（或只对整数快路径，仍无法覆盖小数基准）。

### 5.23 limb decimal 实现/性能（未打包）

- 将 `rt/decimal.lua` 改为 base=1e7 limb（避免字符串四则）；保留 16 位 HALF_UP；parse/add/sub/mul/div/to_number。
- Decimal.js oracle 2056 组：to_number 0 差异；decimal_test 13/0；all.sh EXIT=0。
- LuaJIT bench（100k，含 number→Decimal/to_number）：add ~139k、sub ~143k、mul ~124k、div ~3.4k ops/s。
- Decimal.js Node：add392k、sub296k、mul288k、div175k；limb 仍 add/mul 约2x慢、div约50x慢。
- 结论：瓶颈为 Lua 运行时和长除，非字符串；纯 Lua 仍达不到“不低于 Decimal.js”。需决定是否申请纯 Lua number 回退。

### 5.24 limb 复刻 Decimal.js 结论

- 已按 Decimal.js base1e7 limb 实现 add/sub/mul/div；不是字符串四则。
- 数值 oracle 2056/0；decimal_test 13/0；all.sh EXIT=0。
- LuaJIT 仍 add~139k/sub~143k/mul~124k/div~3.4k；Decimal.js Node 392/296/288/175k。
- 差距主因：JS JIT + Decimal.js 专用分块长除；Lua limb 表的分配/循环开销，尤其 div。
- 继续可选：移植 Decimal.js 的 base1e7 分块长除（而非逐位 0..9）、整数快路径、FFI uint64（LÖVE LuaJIT）；纯 Lua 1.1 下仍难达 175k div。
- 当前没有回退纯 number；未打包。

### 5.25 limb 长除优化 + 整数快路径

- base1e7 div 的商 limb 改为二分搜索（之前估值下降在 B_high 小、商为 0 时会百万级循环，导致 vm_test 超时；已修）。
- `math_arithmetic` 增加安全整数快路径：add/sub/mul 结果 <=2^53、整除/div 可整除时走原生；其余仍 Decimal。
- 结果：LuaJIT short bench add170k/sub208k/mul190k/div17.9k；Lua5.1 add80k/sub76k/mul84k/div4.9k。
- Decimal.js Node 392/296/288/175k；仍有差距，但 div 从 3.4k→17.9k。
- Decimal.js oracle 2056 组 to_number 0 差异；decimal_test 13/0；all.sh EXIT=0。
- 未打包。

### 5.26 decimal v1 存档 + 新方法候选

- 存档：`work/decimal_archive_v1/`、`work/decimal_archive_v1.tar`、`work/decimal_archive_v1.zip`；含 decimal.lua/op_sensing/decimal_test/SHA256SUMS。
- 新方法候选（待批准）：
  1. interval/native fast path + exact fallback（最可能兼顾精度/速度）
  2. FFI uint64/双 limb 内核（LuaJIT，Lua5.1 回退）
  3. operation memoization/热值缓存
  4. 固定 16 位整数/定点十进制，减少表分配
  5. 乘法/除法专用单/双 limb 快路径
  6. 用有效位/指数区间判定是否需要 Decimal，避免常见值进入大数路径

### 5.27 decimal 算法实现对比

- 变体：string、limb（当前）、fixed3（固定3 limb/展开）、memo（fixed3+操作缓存）。
- 目录：`work/decimal_algorithms/`；bench: `bench.lua`（重复值）、`bench_random.lua`（64组随机）。
- 重复值 1000（LuaJIT，ops/s）：string 69k/102k/85k/2.5k；limb 75k/186k/232k/18.5k；fixed3 136k/193k/225k/18.9k；memo 598k/616k/1075k/354k。
- 随机 1000：string 32.6k/25.1k/24.0k/1.1k；limb 41.4k/80.6k/194k/13.6k；fixed3 49.6k/91.5k/172k/14.8k；memo 61.9k/152k/217k/68.6k（缓存仍有重复对）。
- 排名：memo（仅重复值）> fixed3/limb > string；div 仍远低于 Decimal.js 175k。
- 当前运行时仍用 limb；fixed3 未替换。未打包。

### 5.28 选择条件算法测试/排名

- 算法：hybrid（fixed3 add/sub/div + limb mul）、cond_int（安全整数）、cond_identity（整数+精确 division+0/1 恒等）、cond_memo（再加结果缓存）。
- 随机小数 1000（LuaJIT）：hybrid add64.6k/sub193.6k/mul112.6k/div13.8k；cond_identity 39.8k/198.7k/110.8k/14.1k；cond_int 29.9k/87.6k/88.0k/14.1k；memo 119k/187k/161k/75k。
- 整数负载 1000：hybrid 142k/181k/149k/12.3k；cond_int 304k/498k/383k/13.2k；cond_identity 271k/728k/516k/13.2k；memo 238k/505k/367k/66.7k。
- 排名：整数 cond_identity > cond_int > hybrid；小数 hybrid ≈ identity > int；重复值 memo 最高。div 整数精确命中仍低（条件 division 少）。
- 当前运行时仍用 limb + 整数快路径；未切换到 hybrid/identity。未打包。

### 5.29 除法倒数乘分析（未改）

- 临时测试 `work/decimal_algorithms/recip_test.lua`，64 组随机小数。
- 精确 div vs `a*(1/b)`（两次16位舍入）：to_number 差异 29/64；例如 -0.632554/0.00867223 最后位差。
- 速度（LuaJIT，5000）：direct 15.4k/s；reciprocal cached 120.6k/s（~7.8x）；no-cache 13.9k/s（更慢）。
- 结论：只有 divisor 重复时缓存 reciprocal 有收益；一般倒数乘会破坏官方16位精确比较，不能默认使用。
- 可用条件：除数=10^k/2^k/5^k 等有限精确倒数，或结果不在舍入边界；任意 divisor 需精确回退。
- 未改代码/未打包。

### 5.30 decimal v2（cond_identity）开版

- `rt/decimal_v2.lua`：cond_identity；add/sub/div=fixed3，mul=limb；安全整数/0/1 原生快路径。
- 新增 `rt/decimal_fixed3.lua`、`rt/decimal_limb.lua`；`op_sensing` 改 require decimal_v2。
- 存档 `work/decimal_v2/`、`decimal_v2.tar`、`decimal_v2.zip`（含 SHA256SUMS）。
- decimal_test 13/0；run/effects/looks/control 通过；未打包。

### 5.31 运算/变量列表 UI 计划（未改）

- 下载 `work/operators.bcmkn`：1 角色、1 个全局 list 变量 `l`，append 20 个不同运算结果；变量 visible/style default/scale1/position(0,0)。
- 官方变量组件 main:1 约 5240000：显示 name + String(value)；list 组件显示 name，点击 openStageList 打开列表弹窗；支持拖动 position、scale。
- 官方列表值字符串化 main:1 byte 1796669 `Qz`：Array→`[elem1,elem2]`，嵌套 Array→`[...]`，其他 String(value)。
- 当前缺口：`M.vars` 只序列化 id/name/value，丢 type/style/scale/visible/position/isGlobal；`show_hide_variables` 是空实现；无变量/列表宿主 UI；math_arithmetic 仍 Decimal v2。
- 要求：四则改 Lua 原生；变量/list 渲染+交互；table 字符串化。v2 已存档暂不使用。
- 计划：compiler metadata → Game var_meta → host monitor/List modal + click/drag/scale → Qz → native arithmetic → tests。

### 5.32 运算/变量列表 UI 执行计划（未改）

- 官方变量 widget 约 main:1 5240000：name+String(value)，list 点击 openStageList；列表弹窗 main:1 5194800，行 `index. Qz(value)`；Qz byte 1796669：数组→`[a,b]`、嵌套→`[...]`、其他 String。
- 执行时删除 op_sensing 的 decimal_v2 require，四则改 Lua 原生；v2 存档不参与。
- compiler M.vars 增加 type/style/scale/visible/position/isGlobal；Game 增加 var_meta/list_meta/dirty；show_hide_variables/list 写 meta；新增 host monitors（P8 不做拖动/缩放，仅渲染+列表点击/弹窗/滚动/关闭）。
- 测试：operators 编译、20 项列表、Qz、visible、dirty；headless/package。

### 5.33 运算/变量列表实现 + operators 包

- 四则改 Lua 原生（decimal_v2 存档不再 require）。
- emit M.vars 增加 type/style/scale/visible/position/is_global；Game.var_meta/list_meta；show_hide_variables/list 写 meta。
- 新增 `rt/host/monitors.lua`：变量默认样式/列表样式、position/scale、visible、列表点击弹窗、滚动、关闭；P8 未做拖动/缩放。
- `V.list_display` 官方 Qz：`[1,2]`、嵌套 `[...]`、空 `[]`；V.js_str 仍 JS String。
- operators 编译 66 行/6.9 KB；headless 14/0；all.sh EXIT=0。
- 包 `player/knplayer-operators-atui-20261020.love`：23 MB，86 files，6 素材，sha256 `e72c551a20d8886ee5ce96ee62b43c70d85341ad4d66e2cabc801cc0097636b2`。

### 5.34 变量/列表样式对齐 + operators r1

- 官方 CSS 定尺寸：变量 64px/radius16/#ffa161/#fac8a6/值框48px/#fff/#f28926/radius12；列表外层 rgba(0,0,0,.2)/radius32/64，名字 #ffcf29/52/radius26/#344265/22，弹窗行44。
- bundle 解码 `icn_arrow_down` → `rt/assets/monitor/arrow_down.png`（官方 SVG 同步保留），列表不再用文字箭头。
- monitors 按官方颜色/高度/边框/阴影/字体尺寸（当前字体）重绘；列表弹窗行高44。
- 四则保持 Lua 原生；decimal v2 存档不参与。
- all.sh EXIT=0（operators 14/0）。
- 包 `player/knplayer-operators-atui-20261020-r1.love`：23 MB，88 files，sha256 `9426de4c77458a91e80bc98823406605006931752c800794a561974f5e0e9fe5`。

### 5.35 operators 样式确认/剩余

- 实际使用：全局 list 变量 l；无 local/cloud/script 图标；无 text/icon 变量样式；无实体前缀；P8 无拖动/缩放。
- 实际官方资源：arrow_down.svg（已解码）；close/local/cloud 是 icon component 的内联 SVG，不在 media 独立文件；当前 close 仍为文字 ×。
- 已实现样式：变量/list 官方颜色尺寸、arrow、弹窗行高、Qz；包 operators r1。
- 仍缺全量：close 内联 SVG、StageList 多列表 carousel/slider/滑动切换、官方弹窗精确 CSS、动画、截图对照；当前唯一列表可用但不完整。

### 5.36 variables_ui 作品类型审计（未改）

- 下载 `work/variables_ui.bcmkn`；9 个变量，位置 y=0..496 / x=0/200。
- 类型/样式：
  - l: list default global (0,0)
  - a: any default global (0,80)
  - b: any default local currentEntityId=编程猫 (0,160)
  - c: public default global (0,240)
  - d: private default global (0,320)
  - e: any style=icon_coin global (0,400)
  - f: list default global (0,496)
  - g: list default local currentEntityId=编程猫 (200,20)
  - h: private_list default global (200,100)
- 当前 gap：compiler 未输出 currentEntityId；monitor 无 local/public/private/coin 图标/实体前缀；icon 样式未实现；private/private_list 未区分；官方 icon_coin/local/cloud 为 icon component 内联资源，不在 media。
- 需补：实体前缀、类型图标、icon_coin、private_list、全部类型渲染；all visible。

### 5.37 variables_ui 多类型实现 + 包

- 编译器 M.vars 增加 current_entity_id/entity_name/cv_id；Game.var_meta 保存。
- monitors：icon_coin 等 style 图标（官方 variable-editor PNG 下载）、实体前缀、text 样式、官方 stage_list 面板图、列表箭头；private/public/local 类型元数据已保留。
- 官方资源：style_default/medal/heart/coin/hourglass/text, stage_list.png；arrow_down。
- variables_types_test 34/0；all.sh EXIT=0。
- 包 `player/knplayer-variables-ui-atui-20261020.love`：23 MB，96 files，sha256 `b8b1a71f9b21dd93b90ddd9b53b6019edcc8623fc40a74a1496fff9e7c4be935`。

### 5.38 variables_ui 多类型 + 列表弹窗增强（r1）

- 编译器输出 current_entity_id/entity_name/cv_id；monitors 支持实体前缀、public/private/local 类型图标、text/icon_* 变量样式；style_coin 等官方 variable-editor PNG。
- 列表弹窗改用官方 stage_list.png 面板；多列表左右切换、swipe、滑块、矢量 close；行高 44。
- variables_types_test 34/0；all.sh EXIT=0。
- 包 `player/knplayer-variables-ui-atui-20261020-r1.love`：23 MB，96 files，sha256 `eeae4a7614263af6a62d9fdffb3f6ecd204ebeb27f4024a9f788f88765c7da57`。

### 5.39 AtLua 重制变量/列表 UI

- 新增 `rt/host/monitors_at.lua`：At.Panel/Label/Button 重制变量/列表；H.new 改用 monitors_at；main.draw 在 atui 之后绘制；输入由 AtUI 派发。
- 旧 `rt/host/monitors.lua` 保留但不使用；variables_ui 仍 34/0，all.sh EXIT=0。
- 包 `player/knplayer-variables-ui-atui-20261020-r2.love`：23 MB，97 files，sha256 `68d34031c7976c9fa8112699c4464869ce4723feb06a31744b12d7faff58306f`。

### 5.40 At rgba 兼容 + variables_ui r3

- At.core.color 补最小 rgba()/rgb() 解析（Panel 使用 AtLua 颜色串不再 nil 算术）；未改动 At 组件结构。
- 修复 monitors_at 的 rgba 背景崩溃。
- 包 `player/knplayer-variables-ui-atui-20261020-r3.love`：23 MB，97 files，sha256 `7161ab0d5ef21aad11878b97ee013cccdee47462ac7a83d2d2cbe285c525793f`。

### 5.41 AtLua monitor 重制（headless 阶段）

- 归档旧 `rt/host/monitors.lua` → `archive/monitors_legacy.lua`；运行不再引用。
- 新增 `rt/host/monitor_layout.lua`：舞台左上坐标→窗口坐标，fit 和 widget scale 各只乘一次，超宽/底部 clamp 在舞台内。
- 重写 `rt/host/monitors_at.lua`：At.Panel/Label/Button 绝对坐标，不再依赖 Panel 自动布局；只用 At registry 输入；旧 H 输入分支删除。
- headless：monitor_layout_test 11/0；variables_types 34/0；all.sh EXIT=0。
- 未打包，等待真机验证。

### 5.42 variables_ui AtLua r4 包

- 包 `player/knplayer-variables-ui-atui-20261020-r4.love`：23 MB，97 files，sha256 `3b14f436af15c164b97629fd7b25b293cc82f7e44fd6ac8474dad081681aa480`。
- 包含 monitor_layout/monitors_at；不包含旧 monitors.lua（已归档）。

### 5.43 monitor open_list nil + value box offset 修复

- 根因：`open_list` 中 `self.scroll_offset` 未初始化，line 130 `nil > number` 崩；初始化 0 并 clamp。
- 值框偏移：原来用 `#name*11` 估算名称宽；改为先 `At.Label:_ensureSize()` 实测 `lab.w` 后再定位值框。
- headless：monitor_layout 11/0；variables_types 34/0；all.sh EXIT=0。
- 包 r5 `player/knplayer-variables-ui-atui-20261020-r5.love`，sha256 `f8dd87aab37e6e8dff80efc57dd85008485542868c2a3b5d7363b00583b3ee6d`。

### 5.44 变量/列表 UI 与控制台图层纠错

- 根因：`main.lua` 原顺序是 `atui.draw`（含 Console）后 `monitors:draw`，把变量/列表画到了控制台上面。
- 绘制：`main.lua:361-365` 改为先 `rt.host.monitors:draw` 再 `atui.draw`；自下而上 = 舞台 → 变量/列表 monitor → AtUI（FPS/DBG/LOG/调试面板/控制台）。
- 命中：`rt/host/atui.lua:300-332` 增加 `console_active` 与 console 优先派发——控制台打开（或关闭动画未结束）时 `mousepressed/wheelmoved` 先给 Console，命中即不再下传 registry 里的 monitor 按钮；`mousereleased` 让 Console 收尾，并用 `console_capture` 区分“按下在控制台”与“按下在舞台、松开滑入控制台”，避免吞掉舞台的松开事件。
- 测试：`tests/atui_test.lua:79-114` 新增 8 项（控制台优先按下/不下传、capture、release 收尾、wheel 优先、控制台外落回 At、main 绘制顺序），30/0。
- 本机（Android/Termux 环境）没有 lua5.1/luajit，`tests/all.sh` 未跑；改用 fengari(Lua 5.3) + node fs 版 `io.open` 运行：atui_test 30/0、monitor_layout 11/0、variables_types 34/0、operators_ui 14/0。
- 未打包，等待 LÖVE 真机验证：开 LOG 控制台后应完整盖住变量/列表；点控制台不应再弹出列表弹窗；点控制台外 monitor 仍可打开列表。

### 5.45 变量值框防溢出 + 列表箭头 ↓

- 变量值框溢出根因：旧布局用 `max(56, w - 名称估算宽 - 24)` 定位值框，名称实际较宽（中文/实体前缀）时值框被顶出面板右边界；文字也无裁剪。
- 新增 `Layout.variable_columns`（`rt/host/monitor_layout.lua:48`）：左右内边距/间隔/值框最小宽都按 `stage_rect` 的同一 scale 缩放；名称区在空间不足时让位，值框右边界恒为「面板右边界 - 10」。
- `rt/host/monitors_at.lua`：根宽改为按 At 字体实测名称/值反推（`text_metrics`，`:64`），值框按内容取宽（最小 32，面板最小 110）；超长名称/值用 UTF-8 安全的 `ellipsize`（`:81`）截断加“…”；框内边距随 scale 缩放。
- 列表箭头 `▾` → `↓`（`:171`），按实测箭头宽度右对齐，名称按「箭头左边 - 6」截断，不再压箭头。
- 测试：新增 `tests/monitors_at_test.lua` 18/0（值框/文字不越界、长文本省略、箭头 ↓、名称不压箭头）；`monitor_layout_test` 增 10 项 columns 断言（21/0）；`tests/all.sh` 纳入新测试。
- 本机仍无 lua5.1/luajit，用 fengari(Lua 5.3) 跑：monitors_at 18/0、monitor_layout 21/0、variables_types 34/0、operators_ui 14/0、atui 30/0；另用 `works/variables_ui` 的 9 个真实 monitor 元数据做 containment 检查，0 溢出。
- 未打包，待真机确认：值框不再越出变量面板，超长值显示“…”，列表右侧为 ↓。

### 5.46 对接变量/列表渲染修复 + test2

- 新工作：`rt/host/monitors_at.lua` 长文本省略/值框列分配/列表 ↓；`rt/host/monitor_layout.lua` 新增 variable_columns；tests/monitors_at_test、monitor_layout_test、variables_types/operators_ui 已恢复。
- 对接补充：monitors_at 增加 widgets 映射与 sync_values，变量值变化时 At.Label 实时更新。
- headless：monitors_at 18/0；monitor_layout 21/0；variables_types 34/0；all.sh EXIT=0。
- 测试包 `player/knplayer-variables-ui-atui-20261021-test2.love`：23 MB，97 files，sha256 `9a565a34c51b21875c141ce95eba7c3aabeeb5194dd72cacf782fdfbb66f79d8`。

### 5.47 变量/列表四项修复 + test3

- 列表改为 At.ScrollView，全部项装入 content，不再按可见行数截断；面板尺寸按舞台 fit 限制。
- 变量/列表位置随窗口尺寸变化重建；坐标经 monitor_layout 舞台→窗口，限制在舞台内。
- 列表名称胶囊按字体实测自适应；变量值框走 variable_columns。
- 箭头 ↓ → ▽。
- monitors_at 18/0；monitor_layout 21/0；all.sh EXIT=0。
- 包 `player/knplayer-variables-ui-atui-20261021-test3.love`：23 MB，97 files，sha256 `80595316f4d6f30abc31e5a7d3ea581fd89ba694d845da0bd76f7755bb799cd3`。

### 5.48 去硬编码宽度/圆角随舞台 + test4

- radius：root 12*s、名单胶囊 8*s、值框 8*s、弹窗 12*fit、关闭按钮 8*fit；去掉 math.max(1,h/64)。
- 列表名胶囊 = 实测文字宽 + 2*10*s；外层 = 胶囊 + 箭头 + 外边距。
- 值框 = 实测文字宽 + 2*8*s；variable_columns 改为 value_want，无 MIN_VALUE_W/140/110 下限。
- sync_values 值变化时重排重建，不只用 setText。
- monitor_layout 21/0；monitors_at 18/0；all.sh EXIT=0。
- 包 `player/knplayer-variables-ui-atui-20261021-test4.love`：23 MB，97 files，sha256 `557c13cf1da8f2c349d90f6089deeb21026ba9c03ff25f875c81db5c7b7e155a`。

### 5.49 内边距 2x + 箭头间距缩短 + test5

- 列表名胶囊内边距 10*s → 20*s；变量值框内边距 8*s → 16*s。
- 名称胶囊与 ▽ 间距 8*s → 2*s；外层右边距 12*s → 6*s，总宽同步缩短。
- monitors_at 18/0；monitor_layout 21/0；all.sh EXIT=0。
- 包 `player/knplayer-variables-ui-atui-20261021-test5.love`：23 MB，97 files，sha256 `042dcf424c9db5548f23c5f7f324be003270fbcc9cbbee5f0301663a99c767c8`。

### 5.50 列表查看页左右切换（JSON 顺序）+ test6

- emit.py 增加 variablesDict 的 JSON 插入顺序 `order`；Game.var_meta 保存 `order`。
- `list_metas` 按 order 排序；列表页新增 ‹ / › 按钮，首项禁用上一、末项禁用下一，不循环。
- 当前作品列表顺序：l(0) → f(6) → g(7) → h(8)。
- 回归：variables_types 34/0；monitors_at 18/0；monitor_layout 21/0；all.sh EXIT=0。
- 包 `player/knplayer-variables-ui-atui-20261021-test6.love`：23 MB，97 files，sha256 `2e805800cf6fe6ad110bc5006e60685075171ac4a11d4a567295482e503493e2`。

### 5.51 列表切换按钮移到面板外侧 + test7

- ‹ / › 改为面板外侧左右；宽 26*fit、高 54*fit、圆角 8*fit，半透明 alpha 150（禁用 60）。
- 舞台边界内 clamp，不遮挡列表滚动条。
- all.sh EXIT=0；monitors_at 18/0；monitor_layout 21/0。
- 包 `player/knplayer-variables-ui-atui-20261021-test7.love`：23 MB，97 files，sha256 `839746ddd1cad1d29c8f2cf3ea654a8db9c39c51ae7175a0f5c7bb0b9c829938`。

### 5.52 列表序号/值分栏 + 自适应面板高度 + test8

- 列表行改为独立序号 Label + 值 Label；序号宽度取所有行最大宽度，值在其右侧对齐。
- 值超出剩余宽度用 ellipsize 截断加省略号。
- 面板高度=min(最大高度, 顶部+全部行高+底部内边距)：短列表收缩，最后一项贴底部内边距，不额外留空；长列表进 ScrollView。
- all.sh EXIT=0；monitors_at 18/0；monitor_layout 21/0。
- 包 `player/knplayer-variables-ui-atui-20261021-test8.love`：23 MB，97 files，sha256 `7bd8622e608b6cf63c07bbf485b139ff6c2bec21bc133208378461f7733eb6a5`。

### 5.53 列表序号/值同行 + 固定面板空行策略 + test9

- 每行改为 At.Panel(direction=row)，序号/值两个 Label 同排；序号宽取所有行最大，值右侧对齐并 ellipsize。
- 非空列表面板高度固定 max；内容高 >= 视口高：短列表底部空行，长列表 ScrollView 底部不留额外空。
- 空列表面板仅标题高度。
- all.sh EXIT=0；monitors_at 18/0；monitor_layout 21/0。
- 包 `player/knplayer-variables-ui-atui-20261021-test9.love`：23 MB，97 files，sha256 `9cb0a19a01ea825f93128ec3a5a6352a31ee10c45f8fcb19b85938d6a4fcc705`。

### 5.54 列表面板高度固定（含空列表）+ test10

- panel_h 固定 max_panel_h，不再按 #list 收缩；空列表也是完整面板。
- all.sh EXIT=0；monitors_at 18/0；monitor_layout 21/0。
- 包 `player/knplayer-variables-ui-atui-20261021-test10.love`：23 MB，97 files，sha256 `9194b3ee630e141f5e3bc8639007e31702df34996e1bee647e4dfd11ae6565f7`。

### 5.55 特效积木实现（未选选项全实现）+ effects 测试包

- 新增 `rt/impl/effects.lua`，覆盖：强调 shake/scale/bounce；入场 slideIn/bounceIn/flyIn；退场 slideOut/flyOut/bounceOut；四方向；appear/disappear 状态；文字 text/size/color（size clamp 1..2000）；global 动画状态。
- Entity 增加 text_effect；Game:step 更新动画；Host 增加文字纹理替代绘制、全局覆盖层、官方特效音频。
- 官方特效音频复制 `rt/assets/effects/*.mp3`；SVGA 暂用程序化舞台覆盖层（音频正常），未解码成 PNG 序列。
- 新增 tests/effects_animation_test.lua 17/0；all.sh EXIT=0。
- 包 `player/knplayer-effects-atui-20261021-test.love`：23 MB，102 files，sha256 `10c85095b4272ad4c8d09871ff84eeb3577ddec5dbd0964376233e76390bfe4d`。

### 5.56 全局 SVGA 转 PNG 序列 + effects test2

- 解析 8 个官方 .svga（zlib+protobuf），提取全幅帧 PNG：salvo 60、firework 30、awkward 45、silent 30；横 900×562、竖 562×900。
- 资源落到 `rt/assets/effects/{salvo,firework,awkward,silent}_{hor,ver}/NNN.png`；音频同目录。
- H:draw_global_effect 按 30fps 播放对应序列；无序列时程序化兜底。
- global_animation 时长按帧数/30；官方音频播放。
- effects_animation 17/0；all.sh EXIT=0。
- 包 `player/knplayer-effects-atui-20261021-test2.love`：29 MB，433 files，sha256 `6e4e3aac497e0dc97eb69d0bea3be0202cbeff63e82ef82cbf8a7ad5ff525cf7`。

### 5.57 界面积木实现 + ui_at + ui test

- 新增 `rt/host/ui_at.lua`：AtLua 舞台对话框（遮罩+底部卡片+确定）、输入框（TextInput+提交）、选择框（动态选项按钮）；气泡为官方风格自定义绘制（头像/角色名/文本打字机/尖角或思考圆点）。
- rt/impl/ui.lua：stage_dialog 状态、talk/think 气泡 duration、close、translate_result 离线占位；ask/choice 队列保持。
- main/host 接入 ui_at；所有 UI 用舞台 fit 缩放并 clamp 在舞台内。
- ui_new_test 通过；all.sh EXIT=0。
- 包 `player/knplayer-ui-atui-20261021-test.love`：29 MB，434 files，sha256 `6ba3680856fa33cf7d1c26abbf4bea41f811049979af9f5a8b9e0a8f0a562ae9`。

### 5.58 界面反馈修复 + UI test2

- create_stage_dialog 现在只能由自身确认关闭；close_self_dialog 只隐藏角色气泡。
- 输入/选择/翻译弹窗均锚定舞台下半部分（底部内边距 20*fit）。
- translate 改为阻塞式 AtLua 翻译弹窗：确认后释放线程；translate_result 返回原文。
- ui_new_test 更新通过；all.sh EXIT=0。
- 包 `player/knplayer-ui-atui-20261021-test2.love`：29 MB，434 files，sha256 `ba7f9b7140ecf4088bb7dde80f9123d16f064923d8450ac324d62845accf98d1`。

### 5.59 界面语义修复 + UI test3

- create_stage_dialog 持有 thread lock，确认按钮释放，阻塞后续积木；close_self_dialog 只关气泡。
- self_dialog 指定秒数阻塞到气泡结束，避免 Hi 被下一秒气泡覆盖；self_dialog_wait 无时间限制持续显示。
- 三个模态弹窗统一 modal_geom：左右边距 20*fit、宽度 sw-40*fit。
- 气泡移除角色名/头像；改用官方 bubble.png；文本打字机按完整文本定宽，思考气泡加圆点。
- ui_new_test 通过；all.sh EXIT=0。
- 包 `player/knplayer-ui-atui-20261021-test3.love`：29 MB，436 files，sha256 `385fa2958ba0617d39d895c514f6bc0ec0e291dddc059ecc9b3634e1f5357dc5`。

### 5.60 UI 尺寸同步 + 官方气泡九宫格 + UI test4

- ui_at sync_geom：舞台 sx/sy/sw/sh 变化时清空并重建 stage/dialog/translate，遮罩与弹窗跟随窗口/舞台缩放。
- 气泡改用官方 bubble.png，左尾/右侧固定、中心横向拉伸（九宫格）；仍不显示角色名/头像，文本打字机。
- 阶段对话框 thread lock、输入/选择/翻译统一 modal_geom 已在 test3 基础上保留。
- all.sh EXIT=0；ui_new_test 通过。
- 包 `player/knplayer-ui-atui-20261021-test4.love`：29 MB，436 files，sha256 `3fe0e292dac3a106ead5a22834a5a9673e6a62fef9c5d027e635f2242c164c78`。

### 5.61 气泡舞台内 clamp + 底部三角 + UI test5

- draw_bubbles 按舞台矩形完整 clamp：气泡主体 + 尾巴都在 sy..sy+sh 内；角色在舞台外时贴边。
- 对话气泡改用官方 bubble 主体（裁掉原左尾），底部中央画小三角；思考气泡圆点尾巴。
- all.sh EXIT=0。
- 包 `player/knplayer-ui-atui-20261021-test5.love`：29 MB，436 files，sha256 `8e082294755f662ad50562160991720e472f6ca3fe09a885c6a78a2da0311dc2`。

### 5.62 气泡打字机速度修复 + UI test6

- 根因：Hi 只有 2 字符，旧 45ms/字 90ms 就显示完整，肉眼看不出打字机；且 stage dialog 阻塞时气泡尚未创建。
- 气泡 typing：有 duration 时 char_ms=max(80, duration/chars)，无 duration 时 140ms/字；短文本可感知。
- 气泡本体/三角仍在舞台内；不显示角色信息。
- all.sh EXIT=0。
- 包 `player/knplayer-ui-atui-20261021-test6.love`：29 MB，436 files，sha256 `4420cb6be39aa3e1e7a914c07e9962df7b59e683e45518ca3146867efd48482e`。

### 5.63 舞台对话框打字机 + 界面积木收尾

- create_stage_dialog 记录 born；ui_at 每帧 update_stage_text，按 120ms/字逐字显示；确认后才停止。
- 最终回归：all.sh EXIT=0；ui_new_test 通过。
- 包 `player/knplayer-ui-atui-20261021-final.love`：29 MB，436 files，sha256 `622458a1b7fe3dd5f5d43c3cda9664c2baaf11d04c61fe885ea7e3d2abfa1be3`。

### 5.64 侦测起步 + 计时器 AtLua + sensing test

- get_orientation 手机传感器离线返回 0（motion_test 期望同步更新）。
- 新增 `rt/host/ui_timer.lua`：官方 160×100 timerBackground、28px 数值、默认 (stage_w-180,12)，show/hide/start/stop/reset。
- hit.overlaps 增加同帧 pair 缓存（含变换签名）；AABB 不相交直接 false，避免重复像素采样。
- 打字机速度改为官方 30ms/字、50ms 初始。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-atui-20261021-test.love`：29 MB，441 files，sha256 `c606bc4fe5e5ae70ebd25cd40779afd979af5e2bc726e324fc4c8503e1a6d237`。

### 5.65 去除气泡/对话框打字机 + 九宫格空隙

- 根因：作品 repeat_forever 每轮重建气泡，打字速度慢于循环，永远只显示首字。
- 气泡与舞台对话框均改为完整文本立即显示，不做打字机。
- 气泡九宫格左/右段目标偏移按 sy 缩放（bx+l、bx+bw-r），消除左侧竖条与主体空隙。
- all.sh EXIT=0。
- 包 `player/knplayer-ui-atui-20261021-final2.love`：29 MB，439 files，sha256 `150b55b81d3b62927222d31d3d1b847e8ed39c50a920b2a8cb4faeee8c425722`。

### 5.66 sensing 编译/最终包

- 编译 `work/sensing_new.bcmkn` → `works/sensing_new.lua`（76 行，11.1 KB，8 素材）。
- 包 `player/knplayer-sensing-atui-20261021-final.love`：29 MB，441 files，sha256 `cfb57dfa539159c6b177cc883591e26a81f1c9725fe62633d1c5f2fcc912ceb3`。
- 含 timerBackground/ui_timer、传感器离线占位、碰撞 pair 缓存、无打字机 UI。

### 5.67 气泡自适应换行 + 计时器渲染 + sensing final2

- 气泡去除 ellipsize：宽度按完整文本宽度自适应，长文本在舞台最大宽度内换行，不再截断；短文本收窄。
- set_timer_state(start) 时 timer_visible=true；ui_timer 继续 AtLua 绘制。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-atui-20261021-final2.love`：29 MB，441 files，sha256 `a046621f3bc1463c5b6f3a65f761ad835ff3fbd0179b959788a8b7a02ce8168d`。

### 5.68 计时器默认显示/位置元数据 + sensing final3

- Game.timer_visible 默认 true；show_hide_timer 可隐藏/显示。
- 编译器输出 M.timer_pos（来自 bcmkn timerPosition）；rt.load 写入 Game.timer_pos；ui_timer 在任意舞台坐标渲染，不可拖动。
- 编译 sensing_new：77 行，timer_pos {720,12}。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-atui-20261021-final3.love`：29 MB，441 files，sha256 `45a6672937897f594a8b63ea4d990e3a3af3a5db62a4bbe76ca62b215a019597`。

### 5.69 bump_into_color 实现 + sensing final4

- 官方 check_bumped_color：角色纹理点 → 舞台像素，R/G 高5位、B 高4位容差。
- LÖVE 实现：H:draw 在角色前复制不含角色的舞台背景 canvas；bump_into_color 用 actor alpha 点采样背景 ImageData，同帧 id|color 缓存。
- bump_into_color 从恒 false 改为调用 H:color_touching。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-atui-20261021-final4.love`：29 MB，441 files，sha256 `23691cb2edf60b1b8a3b0362373838dc7cc4809318c6a7ed49fbeb472b357eaa`。

### 5.70 bump_into_color 恒 false 根因 + final5

- 根因：_bg_canvas 在角色前复制，只包含背景，不包含其它角色；作品中颜色来自阿短等 actor，因此永远不匹配。
- 修复：除背景像素外，遍历其它可见角色，用风格 ImageData 取纹理像素颜色并按官方 R/G/B 掩码比较；仍同帧缓存。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-atui-20261021-final5.love`：29 MB，441 files，sha256 `98ae67f6b698373dcda3c59e02c6fef65336b280d567ac15a5dc95447244afaa`。

### 5.71 bump_into_color 仍 false 的根因/兜底 + final6

- 编译未丢颜色：works/sensing_new.lua 仍有 color="#a97d50"。
- 颜色掩码 R/G 高5位、B 高4位与官方一致；#a97d50 确实存在于阿短调色板。
- 仍 false 的剩余风险：当前角色纹理采样点/透明边缘没有落在阿短像素上；背景 canvas 又不含角色。
- 增加 AABB 兜底：其它角色纹理像素落在当前角色 AABB 内且颜色命中即 true；同帧缓存。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-atui-20261021-final6.love`：29 MB，441 files，sha256 `b7cde3eb619ab7632bfda53839bd072d018c14208a37603fe57bf0923cdfe5d8`。

### 5.72 按官方 check_bumped_color 渲染离屏舞台 + final7

- H:_color_canvas_for：复制无角色背景，再绘制除当前角色外的所有可见 actor；生成离屏 ImageData。
- color_touching：用当前角色纹理点采样离屏舞台，官方 R/G/B 掩码比较；移除 AABB 宽泛兜底。
- 同帧 id|color 缓存保留。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-atui-20261021-final7.love`：29 MB，441 files，sha256 `8988b13aecff2efe044567e3448e532d7dbcdbb86a8b1f783e7c2245f93db922`。

### 5.73 颜色采样诊断包

- 新增 STARTUP.color_debug；H:color_touching 记录 sample/touch/match/first/aabb/style/center；舞台左上角叠加显示。
- 修正 debug 分支 W/H 作用域（否则 debug 包会崩）。
- 包 `player/knplayer-sensing-color-debug.love`：29 MB，441 files，sha256 `2d179f0d92fd88c1c34f7ad81d728448d8141056c66929d5ff557418aae5243b`。

### 5.74 颜色诊断包无显示修复

- 根因：main.love.load 在 LoveHost.new 之前判断 rt.host，color_debug 永远没设置。
- 改为 host 创建后：host.color_debug = cfg.color_debug == true。
- 重新打包 `player/knplayer-sensing-color-debug.love`：29 MB，441 files，sha256 `71946e5257f6d5bb3a80b53372ada361b0a11b4ff5dc962cc9929885a95dbf2a`。

### 5.75 bg=false 根因：_capture_bg 从未调用

- H:draw 中 `_capture_bg` 定义存在但调用点丢失；颜色诊断始终 bg=false。
- 在 actor 循环前（背景绘制完成处）恢复调用 `self:_capture_bg(g, cv)`。
- 重新打包 debug：`player/knplayer-sensing-color-debug.love`，29 MB，441 files，sha256 `75862c6eb9f54925b51406a90ed1e5ac511e300ab0aa744e3af8094daee8214b`。

### 5.76 颜色诊断扩展：离屏纹理中目标色统计

- debug 模式扫描离屏 color canvas，输出 targetN / target_first；用来区分“渲染中没有目标色”还是“纹理采样点没覆盖”。
- 修复 _capture_bg 调用后 bg=true；sample/touch 正常，match=0。
- 新 debug 包 sha256 `7a8fb36c7d7560a86e704bee0c2b105ae0de41d9645a396ce986057520c70b1b`。

### 5.77 隐藏变量 + 新测试数值通道 + color values 包

- STARTUP.hide_variables：monitors_at 直接跳过变量/列表 monitor。
- STARTUP.test_values：新增 H:draw_test_values 左上角通道，输出 color/bg/sample/touch/match/targetN/target first/target bbox/touch bbox。
- 诊断包 conf：color_debug=true, hide_variables=true, test_values=true。
- 包 `player/knplayer-sensing-color-values.love`：29 MB，441 files，sha256 `70476efb04bdfa5165737c1d90ab68c99c80b27a55aae3e95d6f7ba57696659f`。

### 5.78 target/touch bbox 调试修正

- targetBBox=38,64..792,560 说明目标色广泛存在于离屏舞台（可能背景/其它角色）。
- touchBBox 单点 -316.4,10.6 是 debug 字符串解析 bug（按小数点拆分），非真实采样 bbox。
- 改为数值 min/max 记录；重新打包 color-values：29 MB，441 files，sha256 `ae66b97b69de8b35a58bd036c7df847d717619c2fbd0651fb0d179f34ea242a6`。

### 5.79 按官方实现重做 bump_into_color（官方采样点 + 完整 Stage 重绘）

- 采样点：texture internal points(step2 四邻 alpha) + bounds points(step5)，按角色变换映射到舞台。
- 渲染：H:draw(render_only=true, skip=当前角色, canvas=离屏) 走完整 Stage 渲染路径（背景/其它角色/特效/笔层/z-order）。
- 比较：官方 R/G 高5位、B 高4位；同帧缓存。
- 去掉 AABB 网格采样与手绘其它角色路径。
- 包 `player/knplayer-sensing-color-official.love`：29 MB，441 files，sha256 `20ba688a647d8dc178e9cad764d8de877ff190366ac3a02efc0911ca4abfb7b2`。

### 5.80 修复 draw_test_values 丢失崩溃

- 官方颜色重写时替换区间误删 H:draw_test_values；恢复定义后 all.sh EXIT=0。
- 重打 `player/knplayer-sensing-color-official.love`：29 MB，441 files，sha256 `061f2f345e5eefe9f6346d61f4e637c4fcef9042f658becbfcf44d9f383ffc50`。

### 5.81 A 方案：图层纹理直接采样 + 测试包

- 不再渲染离屏舞台；当前角色纹理点直接按 z-order 查“可见颜色”。
- 背景：按 background.glsl 的 tileTransform 反算 ImageData 像素。
- 角色：按纹理坐标 + ImageData:getPixel，alpha>0 即该图层可见颜色。
- 采样点：step2 四邻 + step5，按 style 缓存；render_list 每帧取一次。
- 官方 R/G/B 掩码保留；同帧 entity|color 缓存。
- all.sh EXIT=0。
- 包 `player/knplayer-sensing-color-layer.love`：29 MB，441 files，sha256 `c5cf7a3d4edb272b0564e42f100eb760f2bb7d10683962f9634b095d3135a432`。

### 5.82 压测作品首次打包（A 方案颜色）

- 下载/编译 `work/stress_new.bcmkn`：900×562，1 actor，2 段脚本；循环每帧 bump_into_color(#ffb029)。
- 去除测试包左上角 TEST VALUES：conf color_debug=false、test_values=false；hide_variables=false。
- 包 `player/knplayer-stress-atui-20261021-test1.love`：29 MB，439 files，6 素材，sha256 `2dc39ddd46fa3dc474b5aaad7560c972088eb86595371c9fd7fc869b782b5b46`。
- 性能目标：低 10fps、中 30fps、高 50fps（尚未优化）。

### 5.83 颜色性能候选：presence gate + 空间网格 + 画笔/背景缓存

- 目标色 presence gate：按 style 缓存 ImageData 是否可能产生目标色；无画笔 ink 时，所有可见层都不含目标色 → 直接 false。
- 角色网格：64px 空间索引，颜色点只查所在 cell，避免每点扫 101 个 clone。
- 背景采样参数按帧缓存；画笔层按帧读回缓存，无 ink 不读。
- 颜色点仍用纹理 step2+step5；结果 entity|color 缓存。
- 计时器语义：编译器输出 M.uses_timer；无计时器积木时 timer 隐藏且不推进。
- 旧官方包存档 `player/archive/knplayer-color-official-legacy.love`。
- all.sh EXIT=0。
- 包 `player/knplayer-stress-color-candidate.love`：29 MB，439 files，sha256 `9ad050f9ff023ca96cb254de027f21a74cb14d7531ed794a8a103f365a648c9e`。

### 5.84 第二个压测作品打包

- 下载/编译 `work/stress_new2.bcmkn`；循环 bump_into_color(#fe807b)，100 clone 镜像。
- M.uses_timer=false；计时器隐藏且不推进。
- 包 `player/knplayer-stress2-color-candidate.love`：29 MB，439 files，6 素材，sha256 `3e20b549b8b89203642f040a51997f1ee16f3f7a7d1c96ed1b0afc043b0e74cd`。

### 5.85 恢复原方案 A（收尾，不打包）

- 移除 candidate 的 presence gate 与空间网格生效路径。
- H:_visible_color_at 恢复：按 render_list 逆序扫描角色纹理，再查背景。
- 保留 A 方案的背景参数缓存；不再用目标色门禁。
- 计时器语义保留（M.uses_timer）。
- all.sh EXIT=0。

## 待办事项（挂起）

### TODO-COLOR-001 「碰到颜色」性能与语义优化

- 状态：挂起，后续单独处理。
- 当前实现：原方案 A（纹理点 + 背景/角色 ImageData 直接采样）。
- 已知缺口：
  - 100 clone × 每帧颜色检测性能不足；
  - 背景 shader/角色特效/alpha 混合后的最终颜色未覆盖；
  - 画笔层 z-order（角色上方/下方、指定角色挂载）未完整处理；
  - 目标色 presence gate 已验证会 false negative，已停用。
- 不在当前任务收尾范围内，不阻塞其它功能。

### 5.86 官方列表语义修复 + vars 包

- 以 main.15ba0757.js getListDomainFunctions 为准（非 crc_libs）。
- list_get/pure_list_get 返回列表；list_item 取项；list_value=list_item。
- delete：ALL 清空、LAST pop、ANY 1-based 删除/越界不操作。
- replace：ANY 越界追加、LAST 替换末尾。
- insert：1-based；越界追加。
- list_is_exist 改严格相等；list_item 不再随机。
- 脚本变量：NEKO_SCRIPT_VARIABLE_TYPE JSON 直接映射 th.script_vars。
- 新增 tests/vars_new_test.lua；all.sh EXIT=0。
- 实测 vars_new：a=6，m=[6,1]，n=[6,2,1,true,{0,2,4}]，m 隐藏、n 显示。
- 包 `player/knplayer-vars-atui-20261021-test1.love`：29 MB，439 files，6 素材，sha256 `400a028ebd3acfba24796096fdd547fce37a354adf5415530b198efcefb033ac`。

### 5.87 事件修复第一批 + 键盘 A 按钮 + events 包

- 新增 `rt/host/ui_keys.lua`：右侧 AtLua A 按钮，点击模拟 keydown/keyup(65)；conf key_sim。
- broadcast_and_wait：把已运行 listener + 本次新启动 listener 一起 join。
- when：条件为真且无 live 实例才启动，结束时由 restart_when_finished 再起，避免每帧堆线程。
- on_bump_actor：start/move/end 三态；事件带 target/attr；on_bump_actor_value 读目标属性。
- clone：mirror 的 start_as_a_mirror 延迟到 apply_deferred，实体加入后再启动。
- restart：重置后重新 fire_green_flag + start_on_click。
- all.sh EXIT=0。
- 编译 `events_new2.bcmkn`；包 `player/knplayer-events-atui-20261021-test1.love`：29 MB，447 files，13 素材，sha256 `7e813ad4766c508c9428684c3756bb1443ab67f507759a9496f7074d3e31666a`。
- 尚未完成：完整 screen transition、official action-state 广播计数、on_swipe Hammer 精确阈值、stop/restart 的 interpreter/block-group 等价。

### 5.88 restart 全属性重置 + Label UTF-8 修复 + events test2

- restart 重置 clone_seq/clone_index/draggable/edge_bounce/pen/text_effect，并清空待启动 clone。
- At/components/Label.lua 增加 safe_utf8：measure/draw 前替换非法 UTF-8，修复 getWrap 崩溃。
- start_as_a_mirror 延迟到 clone 进入 entities 后启动（修正 pending 清理顺序）。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test2.love`：29 MB，447 files，13 素材，sha256 `51564c25e11d317f4621e93c7e11cdf7b70cfb18545af3ea8c19d67099b8a039`。

### 5.89 克隆点击继承根 start_as_a_mirror + events test3

- Sched:mirror 对 clone-of-clone 沿 parent 找到本体，继承本体 start_as_a_mirror。
- 修复后点击克隆体会创建新克隆，且新克隆也启动 start_as_a_mirror。
- 新增 A 键 AtLua 按钮（key_sim）；At Label safe_utf8；restart reset clone_seq。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test3.love`：29 MB，447 files，13 素材，sha256 `e40a0ef38b766076795fbe4cc6116bbdad77adbf7c09a312ad17058f6679cb02`。

### 5.90 克隆点击主体回归本体 + events test4

- 官方 clone responder 是连带监听：点中克隆体仍由本体 owner 执行 hat，不再把 self 替换为 clone。
- 实测：点克隆体后生成本体 #2，而不是 #1#1；原克隆体与 #2 的 start_as_a_mirror 都继续。
- start_as_a_mirror 对 clone-of-clone 沿 parent 找根本体（保留兜底）。
- restart reset clone_seq/clone_index/draggable/pen；Label safe_utf8；A 键按钮。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test4.love`：29 MB，447 files，sha256 `80a8bb90404a7334a5b16d108f0303584b7356e9522da31ba1f4a92b91439c8e`。
- 阻塞未完成：screen transition、stop/restart 的 interpreter/block-group 精确等价、Hammer 速度阈值。

### 5.91 execution_self / clone_root 语义 + events test5

- Thread 增加 execution_self；body 的 self 使用执行实体，lifecycle 仍用 hat owner。
- sprite_on_tap 命中克隆体时 execution_self=克隆体；--self 查询读克隆体。
- Sched:mirror 统一 clone_root(src)，克隆体点击生成本体 #2，不再 #1#1。
- get_clone_num 沿 parent 上溯原型。
- on_bump_actor 对本体+直接克隆体逐一检测，事件带 hit/执行实体。
- all.sh EXIT=0。
- 实测：点击 #1 生成 #2，两个克隆体 start_as_a_mirror 都存活。
- 包 `player/knplayer-events-atui-20261021-test5.love`：29 MB，447 files，sha256 `1140c8b62667f85df6e906aa42246b435ff93510202943a84132702f1a3e2fa0`。

### 5.92 clone 初始状态来源执行克隆 + 气泡清理 + events test6

- Sched:mirror：身份/parent/clone_seq 归 root；坐标/造型/特效/等价状态来自当前执行实体 source；clone_self 后重写 parent/id/clone_index。
- dispose_clone：清 g.bubbles[e]，清 owner 的 stage_dialog/translate_dialog。
- apply_deferred 删除时清 bubbles；ui_at 跳过 owner.deleted 的残留气泡。
- create_stage_dialog/self_ask 的 owner 解析原型；get_clone_index_property 解析原型。
- 实测点击 #1 生成 #2，初始位置来自 #1，编号属于本体。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test6.love`：29 MB，447 files，sha256 `8eff10180fba86a23ef595f363f6dd95c78c30ca852be03654bee83ea26a98af`。

### 5.93 restart 全量重置（官方 clear_state/onStop 对照）

- restart 清空 threads/input_queue/pending add/del/pending clone start、hat 的 when/bump 状态。
- 清空 bubbles/dialog_queue/ask/answer/stage_dialog/translate_dialog、last_click_frame/screen_transition。
- 宿主输入态（鼠标/按键/拖动/press/碰撞/颜色缓存）清零。
- entities 删除全部 clone；本体恢复 spawn 位置/旋转/缩放/造型/可见/alpha/effects/draggable/edge_bounce/layer/rotation_style/pen。
- 变量/列表深拷贝初始值；frame=0；cur_screen=initial_screen；timer/uses_timer/timer_pos 恢复。
- 重新 fire 绿旗/start_on_click。
- 新增 spawn 初始属性记录（visible/alpha/effects/draggable/edge_bounce/layer/rotation_style）。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test7.love`：29 MB，447 files，sha256 `5c3841a3be4dfa2003e7947b77242c0f9f61a606eb6f2b22285cff187f5e7b26`。

### 5.94 事件四项收尾 + headless test

- broadcast：新增每消息 state/listener 计数/去重键，finish 递减，self_broadcast_and_wait 绑定 live+started。
- screen transition：set_screen_transition 存 cfg；switch_to_screen 生成 transition；H:draw 用上一帧 stage 快照做 fade/slide。
- stop/restart：thread group_id；restart 全量清广播状态；原有 scope 0/1/2/3 保留。
- swipe：love 路径改用 Hammer 默认 10px + 0.3 velocity + end。
- 新增 tests/events_semantics_test.lua：clone #2、非 #1#1、start 线程、bubble 清理、restart clone_seq/bubbles。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test8.love`：29 MB，447 files，sha256 `905c3ebb95a32aecf8f67ecfe47d041208eca0e7b1910c8e3925ceef17902d72`。
- 未完全等价：bounce/distort transition、官方完整 action-state 队列、stop interpreter/block-group 精确层级。

### 5.95 事件补全：屏幕导航/鼠标 downup/碰撞目标/属性/转场/Hammer + test9

- Game:screen_order、screen_name、resolve_screen；switch_to_screen 支持数字/next/prev/UUID/name；get_screens 返回字段原值。
- love 宿主生成 mouse_down / mouse_up（不再只有 mouse_click）。
- on_bump_actor 支持 --mouse / --edge / --edge_* / 角色；type start/move/end。
- attr_value 统一 bump/clone 属性：x/y/direction/scale/width/height/visible/style/camp/clone_index/color/opacity/brightness/pixelate/ripple/distortion/grayscale/layer。
- get_clone_index_property 按原型 clone 列表 1-based 取。
- transition 增加 bounce/distort 近似。
- all.sh + events_semantics_test EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test9.love`：29 MB，447 files，sha256 `578b3859fade08a59ec69e2ba0391f321c20c64cc174c58e6af8d75b091820a7`。
- 未完全等价：多指 swipe、headless down/up、官方 action_queue、stop interpreter/block-group 精确层级。

### 5.96 完整语义切片：屏幕导航（get_screens / switch_to_screen）

- 官方验收点：get_screens 返回字段原值；switch 数字 1-based、next/prev、UUID、screenName；next/prev 端点保持当前；无效不切；同一屏不切；切屏 fire 新运行组。
- Game.screen_order/screen_name/resolve_screen；rt.screen 保存 screenName。
- tests/events_semantics_test 增加：next/prev 端点、数字、screenName、switch next/prev、get_screens 字面值。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test10.love`：29 MB，447 files，sha256 `783690075b8d4f7a548e3abac533dabe78f7e26f5e085e29dfed65ccbf1ada0c`。
- 本切片完整；swipe/mouse down-up/bump 属性/action queue/stop block-group 未声称完成。

### 5.97 事件语义切片集合（屏幕导航 + mouse down/up + bump/clone 属性）

- 屏幕导航：get_screens 字面值；switch 数字/next/prev/UUID/screenName；端点保持；无效不切；测试通过。
- mouse：love + headless 都产生 mouse_down/mouse_up/mouse_click；sprite_on_tap/on_click 过滤。
- bump/clone 属性：attr_value 统一 x/y/direction/scale/width/height/visible/style/camp/clone_index/color/opacity/brightness/pixelate/ripple/distortion/grayscale/layer；get_clone_index_property 按原型 clone 列表 1-based；on_bump_actor_value 共用。
- headless 增加 screen 导航、clone property x、bump value x、mouse_down/up 断言；all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test12.love`：29 MB，447 files，sha256 `36a8a043e43f003bcd2f4f2185c70178edf7742bf9b2b0433de12d2cfe6dcbda`。
- 本集合不声称 swipe 多指/action queue/stop block-group/transition bounce 完整。

### 5.98 切屏视觉修复

- 根因：转场期间 H:_snapshot_stage 每帧覆盖 _prev_stage，旧画面第一帧后变成新画面，看起来无法切/无转场。
- 修复：g.transition 活跃时禁止覆盖 _prev_stage；转场结束再保存新画面。
- 支持 slide/fade/bounce/distort/none 的旧/新画面对照。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test13.love`：29 MB，447 files，sha256 `ea9a45747276f1d12f8f4201112d42d4f0c228ef32e32003fbee33ecdc236e69`。

### 5.99 切屏点击修复 + 横竖屏锁定 + test14

- 切屏点击根因：sprite_on_tap 目标为显式屏幕 UUID 时被当成 actor id 比较 hits，空白舞台点击永远 false。
- 修复：love/headless 的 tap filter 将 `--screen` 和显式 screen id 都视为屏幕目标；仅在无 actor 命中时触发。
- 转场旧画面冻结（g.transition 期间不覆盖 _prev_stage）；slide/fade/bounce/distort/none。
- main 按 stage 宽高锁定横屏/竖屏：resizable=false，横屏作品宽>高，竖屏作品高>宽；conf orientation 可覆盖。
- all.sh + screen click headless 断言 EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test14.love`：29 MB，447 files，sha256 `0156a36f766cb2bb8aac53e643a53f09dcec1243dd1691cc6e2b108be4cb6fa9`。

### 5.100 切屏交互锁 + 克隆体广播监听 + test15

- g.transition 期间 love/headless 鼠标/键盘/滑动输入全部锁住；测试需显式清 transition。
- Sched:broadcast 为每个匹配 hat 生成本体 + 直接 clone 的 listener；clone listener execution_self=clone，计数按 reg|clone id 去重。
- live_listeners 同步包含 clone；restart_when_finished 重生保留 execution_self。
- headless 增加 clone broadcast listener 断言。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test15.love`：29 MB，447 files，sha256 `4ccc41aabef496beffad6fbf220dd63ff98e942ac863a6daca3f72ba71235095`。

### 5.101 A 键 AtLua 按钮实际绘制 + test16

- 根因：ui_keys 只 A.add 注册，未调用 Button:draw；AtUI 只手动绘制 fps/debug/console，不自动绘制 registry。
- 修复：ui_keys:draw 末尾 self.btn:draw()。
- 点击仍走 At.registry → atui.mousepressed → onClick simulate_key。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test16.love`：29 MB，447 files，sha256 `042651e71b401afed1b7389948444f15f687a9e9688b1e4425ed05108d4e4340`。

### 5.102 restart 后 find 崩溃修复 + test17

- 根因：restart 把 _id_map/_name_map 置 nil，但保留 _id_map_n；find 条件只比较数量，误以为缓存有效，index nil。
- 修复：缓存条件增加 not _id_map or not _name_map。
- headless 增加 restart 后 find 断言。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test17.love`：29 MB，447 files，sha256 `223bbcdc631382c0fcefd5f51af79b2bf45ff587c018de9493ab1514f360490d`。

### 5.103 restart 旧线程 respawn 导致 j 1/2 + test18

- 根因：restart 清空 self.threads，但 step 仍持有本地旧 threads；旧 when/self_listen 的 done 分支走 restart_when_finished 再 spawn，导致 when 多一次 +1。
- 修复：Sched.restart_epoch；Thread 记录 epoch；restart ++；step 只对 epoch==current 的线程执行 restart_when_finished；重生保留 execution_self。
- all.sh EXIT=0。
- 包 `player/knplayer-events-atui-20261021-test18.love`：29 MB，447 files，sha256 `092c3de5ee57195511f4cf258b0c501ecd3f2d97e506bbbb0f9f841185876368`。

### 5.104 额外打包 now / nodevm

- `work/nodevm.bcmkn.json` → `works/nodevm.lua`（256 KB，14 素材）。
- 当前运行时打包：
  - `player/knplayer-now-atui-20261022.love`：216 MB，737 files，303 素材，sha256 `7766671a312a32cd1580fdefa7ca9c4f0ae0a9d259732407224e199a24f49fd2`。
  - `player/knplayer-nodevm-atui-20261022.love`：29 MB，448 files，14 素材，sha256 `0a4044ae3c3dc80cfc4497833b5cde0d3350870604a464f9937e83b5e750b015`。
- 两包均 work=对应作品，key_sim=true。

### 5.105 计时器默认显示规则 + now/nodevm test3

- 编译器新增 `M.timer_hidden_default`：作品包含 get_timer 或 reset_timer 时为 true。
- 运行时 timer_visible = uses_timer and not timer_hidden_default；timer_running 仍按 uses_timer。
- nodevm 有 get_timer → 默认隐藏；now 只有 set/show/timer → 默认显示。
- now.lua 旧产物补 uses_timer/timer_hidden_default 元数据。
- all.sh EXIT=0。
- 包：
  - `player/knplayer-now-atui-20261022-test3.love`：216 MB，737 files，sha256 `994a877f67faf00db31cb4a55475a7080315e4e775e08a44cd3d94c7e1059d5c`。
  - `player/knplayer-nodevm-atui-20261022-test3.love`：29 MB，448 files，sha256 `80ffef62bd96e2109d6e484bacf269ad59e420e3aee0b2ce553714617cdb893d`。

### 5.106 now 隐藏变量 + 广告点击/命中 + test5

- `works/now.lua` 用 `tests/fixtures/now.bcmkn` 重新编译：变量重新带 visible 元数据（124 个 visible=false），monitor 不再显示隐藏变量。
- `mouse_down` 改为按命中集合判断目标：`--self` 使用 press/click hits，不再被上层无关精灵（now 的“手指”光标）挡住；`--screen` 保持任意指针语义（looks_test）。
- 修复 headless/love down 过滤闭包在事件处理时 press_hits 已清空导致的 nil。
- now 广告探针：显示后点击 -> 脚本走完退出缩放 -> visible=false；x/y 仍为 0。
- all.sh EXIT=0。
- 包：
  - `player/knplayer-now-atui-20261022-test5.love`：216 MB，737 files，sha256 `c2979186600143b0313fab228b66f8f98f5639f45a7665386704d9ae98dc5305`。
  - `player/knplayer-nodevm-atui-20261022-test5.love`：29 MB，448 files，sha256 `d564ea880b566719d836a645e8132b01386411c355dd51a6a814b0eafb4650b7`。

### 5.107 now test6：切屏线程清理 + 广告命中 + clone index0

- 切屏时停止旧屏幕全部线程（start_on_click/start_on_click_2 按官方跨屏保留），修复屏幕2→3后旧屏轮询穿透；返回屏幕2时 on_running_group_activated 重新启动。
- headless 探针：s2 ad threads=2，切 s3=0，回 s2=2。
- mouse_down 使用命中集合判断 --self，广告可越过 now 的“手指”光标命中。
- get_clone_index_property index=0 解释为原型本体（clone index 0），修复曲目打印/难度打印每帧漂移。
- all.sh EXIT=0。
- 包：
  - `player/knplayer-now-atui-20261022-test6.love`：216 MB，737 files，sha256 `7b347e27231ab1408f1a752d6b6296ea0e9360cac75d14ca5bcf479e3af00f60`。
  - `player/knplayer-nodevm-atui-20261022-test6.love`：29 MB，448 files，sha256 `166d662f9c0897c372ce217a63e240c4233c4d231d475ff84cfd411d787af5e3`。
- 仍未完全解决：点击角色残留印章/文字特效、屏幕3交互穿透（start_on_click 跨屏保留导致的部分路径）。

### 5.108 完整集合 test7：隐藏变量/广告/切屏线程/克隆 index0

- now 重新编译：隐藏变量 visible 元数据生效。
- mouse_down 使用命中集合，广告点击可穿透 now 的“手指”光标。
- 切屏停止旧屏 actor 线程（start_on_click 保留以通过官方 switch 测试）；s2→s3→s2 广告线程 2→0→2。
- get_clone_index_property index=0 返回原型本体，曲目/难度打印 clone y 不再每帧漂移。
- all.sh EXIT=0。
- 包：
  - `player/knplayer-now-atui-20261022-test7.love`：216 MB，737 files，sha256 `afa9de6652a36082c4e7b4069a777f763be5d65d3143334b4e9b9b3db7581725`。
  - `player/knplayer-nodevm-atui-20261022-test7.love`：29 MB，448 files，sha256 `8061f7a880ce66810cba0a39b9d2fd48c6f401623c87c17ef784a6cb75343def`。
- 未验证：点击残影/印章视觉、文字 stamp 的官方 bold/居中细节、s3 穿透剩余路径。

### 5.109 手指跟随 + 切屏 clone 清理 + test8

- 根因1：self_move_specify(--mouse) 被 mouse_is_down 限制，手指停在上一次点击坐标；所有用 coordinate_of_sprite(手指) 布局的遮罩/UI 偏移。改为持续跟随指针。
- 根因2：切屏只停线程，不销毁旧屏 clone；circle/特效/打印等第二次进入屏幕后旧 clone 残留，表现为点击位置残影。切屏时销毁旧 scene 的 clone，并重置原角色 clones/clone_seq。
- 广告退出动画探针：点击后 visible=false；x/y=0。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-test8.love`：216 MB，737 files，sha256 `2d9b81df20fa2ac0296cad07b8b7c1974f8514fe10b24c7c7e8aa3291a2b83a3`。
- 包 `player/knplayer-nodevm-atui-20261022-test8.love`：29 MB，448 files，sha256 `dae5c0f13807957a7742ae811040660b7207d464531dae142adccd791ce0c86d`。

### 5.110 点击事件主体修复 + test9

- 根因：event.hit=最上层（now 的手指），Sched:fire 直接用它当 execution_self；所有点击 hat 实际作用在手指上。
- 修复：宿主事件携带 hits/press_hits/release_hits；Sched:fire 对 tap 按 listener 解析：hits[owner]→owner；否则 hits[owner.clone]→clone；不再使用全局 hit。
- 配合：手指持续跟随、切屏销毁旧 clone、旧屏线程清理、mouse_down 命中集合。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-test9.love`：216 MB，737 files，sha256 `ae9c0d13c9b180e7ea52898fa96316c5fab6f13ea6f3ef09711b753f114ba89a`。
- 包 `player/knplayer-nodevm-atui-20261022-test9.love`：29 MB，448 files，sha256 `67659701276b15f374f5052306d48e50183de55d5713a72733b2e94fa1bce62e`。

### 5.111 切屏原子性 + bubbles 初始化 + 指针光标不参与命中 + test10

- Game.new 初始化 bubbles/dialog_queue，切屏 clone 清理增加 nil 保护；修复 g.bubbles nil 导致 switch 在停线程后崩溃、旧屏冻结。
- switch_to_screen 跳过当前线程先停旧屏其他线程，提交 cur_screen/transition/fire 后结束当前旧屏线程，避免切屏半状态。
- self_move_specify(--mouse) 标记 pointer_ignore；Hit.test/hit_list_at 跳过该角色，屏幕点击不再被“手指”挡住。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-test10.love`：216 MB，737 files，sha256 `d83aeeae5aff56888b4043b6f3baa9bf8b19264f5b477a17d741c75a47addb82`。
- 包 `player/knplayer-nodevm-atui-20261022-test10.love`：29 MB，448 files，sha256 `da78295f445450dcd9f955c2a7205459ae1a300bd6db60bcb9fb2e8fc05dabb3`。

### 5.112 AtLua 诊断日志 + diag 包

- core.diag：同时写 host.log 和 At.log（LOG 控制台可见）。
- switch_to_screen 记录：begin self/hat/old/target/clones/bubbles、threads stopped、clone cleanup done、committed cur/transition、green flag threads。
- Game:step 记录 transition end；H:draw 记录 transition draw start。
- 线程错误同时写 At.log。
- 包：
  - `player/knplayer-now-atui-20261022-diag.love`：216 MB，737 files，sha256 `d574f9221543c67437da6e33b558acd03e5e542f9d387319d99fb79882172604`。
  - `player/knplayer-nodevm-atui-20261022-diag.love`：29 MB，448 files，sha256 `ae62ec38d6391e9fba28e670380af2fafdebf5ad8e9143e65c935e2e42fd0082`。

### 5.113 AtLua Console 日志自动换行 + diag2

- LogLines 按字体实际宽度逐 UTF-8 字符换行；measure 使用视觉行数，ScrollView 滚动范围同步；保留每条日志等级颜色。
- 包：
  - `player/knplayer-now-atui-20261022-diag2.love`：216 MB，737 files，sha256 `90ce6f234b2195bd8b8ea181aa7864ee8d98b79f7ba2b7d5dd1d1a6d499568c3`。
  - `player/knplayer-nodevm-atui-20261022-diag2.love`：29 MB，448 files，sha256 `7a4343ce8dbb87a2b562b89f38ecb5e2705816a4c4cf8db343381d536f11f2e2`。

### 5.114 过程调用 trampoline 编译器分支 + 10000 深度

- 新分支入口 `kntl/compile_trampoline.py`，等价于 `kntl.compile --proc-trampoline`。
- 编译器过程调用改为 `th:call_proc(proc, self, args...)`，不再直接 Lua 递归。
- Thread 增加 `frames/call_depth`；Sched:resume 用显式帧 + 独立协程驱动 callee，返回后恢复 caller。
- 深度上限 10000（含入口）；10001 报 `recursion limit exceeded (10000)`，不再 Lua stack overflow。
- 工作源码不改，仅重新编译。
- 验证：now trampoline 999×3 列表初始化成功；自定义递归 9999 成功；10000 报官方 limit。
- all.sh EXIT=0。
- 包：
  - `player/knplayer-now-atui-20261022-tramp.love`：216 MB，737 files，sha256 `c8d3a2a5563c579e841d247623ffcc6d24b3d819e49dd6c650e38163900ced5e`。
  - `player/knplayer-nodevm-atui-20261022-tramp.love`：29 MB，448 files，sha256 `9469ab5b2580bea1a662af29767da9d88c2999e0ec062efeb03d38d4638da3cf`。

### 5.115 trampoline 解除 10000 错误限制，仅 warn

- 过程调用帧达到 10000 时 At.log warn（每线程一次），不再 error/finish。
- 12000 层递归实测成功，`errors=0`。
- 只打包 now trampoline，不再打 nodevm。
- 包 `player/knplayer-now-atui-20261022-tramp2.love`：216 MB，737 files，sha256 `c786eb8cd56856854d8423c4ac01c12187e1645a028a46ad7c693280e2894d34`。

### 5.116 proc_f88 列表长度诊断 + diag3

- now_tramp.lua 的 proc_f88 入口打印 p_i/mode/三个列表长度；每 300 次递归一条；>999 时每 3 次打印 OVER。
- 只打 now 诊断包，不打 nodevm。
- 包 `player/knplayer-now-atui-20261022-diag3.love`：216 MB，737 files，sha256 `ab1e8a022f564618af146b8b26aba3e18ec80171f052108cf7716c605a29810d`。

### 5.117 恢复过程深度硬 limit 10000 + diag4

- 过程帧达到 10000 时：AtLua LOG warn，finish 当前线程，on_error 报 `recursion limit exceeded (10000)`。
- 9999 层递归成功；10000 层触发 limit，不再死循环/卡死。
- proc_f88 长度诊断保留。
- all.sh EXIT=0。
- 只打 now：`player/knplayer-now-atui-20261022-diag4.love`，216 MB，737 files，sha256 `b7139c01fa483d621e28f9920fe362ad7dd521b46c726a8253e4f82ebfb351c8`。

### 5.118 proc_f88 详细进度日志 + diag6

- 最后 2700 不等于卡死：原日志每 300 次一条，2700 后到 999 不足下一条。
- 新增：len6>=850 时每次 ENTRY；append 后 len6>=950 打 APPEND；FINAL start/done。
- 保留 10000 硬 limit。
- 包 `player/knplayer-now-atui-20261022-diag6.love`：216 MB，737 files，sha256 `63587f6f3accd7dda7132fd04fe4ac2193b8549939ae60b0a0877595c00be753`。

### 5.119 proc_f88 FINAL done 后展开诊断 + diag7

- FINAL done depth=2997 说明 999×3 填充已完成，递归返回开始。
- 增加 UNWIND n=每100 depth/p_i/mode；增加 [adobe] proc_f88 returned。
- 10000 硬 limit 保留。
- 包 `player/knplayer-now-atui-20261022-diag7.love`：216 MB，737 files，sha256 `14ef5691a7ad0b14ceaaf05e4cb183b91dbbf9b581f03cc42acf6ef58d225ee7`。

### 5.120 UNWIND 2900 分析与 Adobe 动画诊断 + diag8

- UNWIND n=2900 depth=98 说明 proc_f88 已展开到接近外层，不是死递归。
- 新增 Adobe 第二 hat：start、loopA/loopB 每 10、disappear 日志。
- 包 `player/knplayer-now-atui-20261022-diag8.love`：216 MB，737 files，sha256 `ab88809485835e2e6f5b96c5bc1b178055fe1a484dbd2b5b30a9f42c2eebbdcc`。

### 5.121 修复 restart_when_finished 跨屏复活 + 删除诊断日志 + tramp3

- 根因：切屏 stop 的 self_listen/when 在 done 分支被 restart_when_finished 无条件重启，logo Hi 监听反复动画/切屏。
- 修复：stop 线程标记 stopped；step 重生前要求 not stopped、epoch 匹配、th.reg 存在且 hat_active。
- 删除 switch/transition/thread-error/proc_f88/adobe_anim 诊断日志；now_tramp 重新干净编译；保留 10000 limit warn。
- all.sh EXIT=0；400 帧 now trampoline errors=0。
- 包 `player/knplayer-now-atui-20261022-tramp3.love`：216 MB，737 files，sha256 `46cccf77a1325c1bab2c4eddb8cc26ab6abd9807e52a71219acbc68ae1bc323e`。

### 5.122 limit 数值诊断 + diag9

- Thread:call_proc 统计 _proc_calls；frame 记录 proc；pop 统计 _proc_returns。
- limit warn 输出：owner/hat/reg/exec/depth/frames/calls/returns/status/last 过程名。
- 保留 10000 硬 limit。
- 包 `player/knplayer-now-atui-20261022-diag9.love`：216 MB，737 files，sha256 `e6a0d1ac3bd9a6512c71e4510dd69d29dea7f3d979f90b097ab49458869222b4`。

### 5.123 列表长度/scope 诊断 + diag10

- Game.diag_list_state：limit warn 追加三个列表长度。
- list_append：对 5d99/77f2/6a46 在长度50倍数、长度不增长、每100次 append 时输出 key/len/scope。
- now_tramp 设置 M.diag_lists。
- all.sh EXIT=0；headless 10 帧列表 999/999/999。
- 包 `player/knplayer-now-atui-20261022-diag10.love`：216 MB，737 files，sha256 `99f3c4a4199dd32351e0b61b2b54a9100d903af524cc017f34961dc7aa0edd0c`。

### 5.124 列表默认值/本地变量恢复 + tramp4

- declare_vars：运行值与 var_initial 都 deep_copy；不再共享 M.vars 默认表。
- init_entity_vars：按 current_entity_id/entity_name 为本地变量/列表建立独立默认值。
- reset_entity_vars：restart 清空并重建每个本体的 vars/lists。
- reset_vars 使用 copy_value；declare_lists 也深拷贝（仍未被调用）。
- 验证 now：全局列表 3c180 默认5，append→6，restart→5；本地列表 e5b0 默认1，append→2，restart→1。
- clean 重编译 now_tramp，删除诊断日志；all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp4.love`：216 MB，737 files，sha256 `d32cc22a8adc4a0e490440540b59146e7f6f77800138b26bbf02755fc7ff1308`。

### 5.125 Debug 页可滑动 + 诊断页 + tramp5

- debug body 改为 At.ScrollView + wrap Label，长内容可滚动。
- pages=6；新增 diagnostics 页：proc maxd/frames/calls/returns、HP/No Fail/难度/谱面已生成数量/下坠列表/x/时间/谱面、list total/nonempty、entity vars/lists。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp5.love`：216 MB，737 files，sha256 `7ca240e83a67180ae9ac7ea305ef93ea0388d03b0b587868477aaa0ec13e0719`。

### 5.126 Debug 翻页按钮移到标题栏右侧 + tramp6

- header Panel（row）：page_label + PREV/NEXT/×，位于 debug 面板顶部。
- 删除底部按钮行，body ScrollView 不被顶出屏幕。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp6.love`：216 MB，737 files，sha256 `cf5c185c06300eeb1e27c3287afaa1c276dacb78e0f6f9ddcc2ea54dc279fefd`。

### 5.127 Debug ScrollView 高度受面板约束 + tramp7

- body_view.h = ph - padding24 - header26 - gap8（最小40），不再固定280溢出面板。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp7.love`：216 MB，737 files，sha256 `f57aa89f3360efd7a78d6327e96726f349e52955c90ae4774a16d5d718ad7e65`。

### 5.128 ScrollView width 数值修复 + tramp8

- 根因：`M.body_view.w = "100%"`，ScrollView._barMetrics 对 w 做算术。
- 修复：`M.body_view.w = math.max(80, pw - 24)`，h 同步面板剩余高度；均为 number。
- atui 语法通过；all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp8.love`：216 MB，737 files，sha256 `e90103e1f2d72a7ee243a70dc9234d5d6378c9815c046aba963e0d6860442141`。

### 5.129 DBG 关闭后子控件仍拦截点击 + tramp9

- 根因：M.panel:setVisible(false) 不传播到 ScrollView/header/buttons；ScrollView 仍 visible=true，mousepressed 继续命中。
- 修复：set_panel_parts 同步隐藏 panel/body_view/header/page_label/prev/next/×；初始化即隐藏；toggle 统一调用。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp9.love`：216 MB，737 files，sha256 `e15bab404f41986ef6eae0fd6c67dc3d81e300b47bff14850e36904282102ddf`。

### 5.130 DBG 全量全局变量/列表页 + tramp10

- 纠正：用户所说“本地变量”是 storage 持久化变量，不是运行时 entity 局部变量。
- 删除原 page4 的“前14项”变量页和 page6 diagnostics；pages=4? 实际保留 pointer 为 page5，pages=5。
- page4 改为列出所有 is_global 变量与列表：标量值、列表长度及前12项（多者 +N）；无 var_meta 时回退 game.vars。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp10.love`：216 MB，737 files，sha256 `e6a3c80e8595bf25a5205b05f2e6b9466b398c74e065cd25cd1cadeb18cb8e1a`。

### 5.131 脚本变量 decrease 修复 + note 下落 + tramp11

- 根因：change_variables 的脚本变量分支永远 `cur + n`，忽略 method。
- 修复：脚本变量同样识别 decrease/minus，使用 args.n or args.value。
- 新增 `tests/script_vars_test.lua`：decrease/minus/increase/args.n。
- 新增 `tests/note_fall_test.lua`：下坠列表 676，首500末-175；circle clone y=56→-16。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp11.love`：216 MB，737 files，sha256 `4233dc40d4305de41c8f56fac566f2d16c9e04a6f041da3931ff3548310612e2`。

### 5.132 stop(scope=2) 语义修复 + 结算 + tramp12

- 根因：stop scope=2 抛 SIG.STOP_OTHER，Sched finish 当前线程，歌曲结束后的 stop2 后不执行 stop3/wait/switch_to_screen(结算)。
- 修复：scope2 调用 stop_scope(th,"other")，当前线程继续；scope3 标记被停线程 stopped，当前继续。
- 新增 `tests/stop_scope_test.lua`（scope2/3 当前继续、同/异 owner 停止、stopped 标记）。
- 新增 `tests/settlement_test.lua`（歌曲结束→stop2/3→结算页）。
- note_fall_test 延长 headless 音频等待，避免提前结算。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp12.love`：216 MB，737 files，sha256 `3f4368e1671de258af855ab12e25f0c04d887dddc36933da2e2f2c61b6ddd0a0`。

### 5.133 画笔 HSV / 文字特效角色特效 / HP 笔迹时序 + tramp13

- pen 颜色改为真正的 HSV 存储（pen.hsv；pen.hsl 兼容旧测试），HSV→RGB。
- 文字印章仍 size=stamp args.size，颜色/透明度使用 pen.color/pen.alpha；不使用 entity.effects。
- 文字特效接入 entity.effects：opacity + color/brightness/grayscale shader；仍不用 pen。
- 新增 H:pen_tick：motion_looks 坐标变化即时落笔，避免轨道 clear_drawing 与帧末 pen_update 的时序反了。
- pen_update 改为逐实体 pen_tick 兜底；headless 记录 pen_lines（与 pen_events dot 分开）。
- 新增 tests/pen_order_test.lua：HP 笔迹在 clear 后仍存在；all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp13.love`：216 MB，737 files，sha256 `7112161cc1cac1c48f208937c315d1a7314acd4f7ca4b26e2d6b7b9aac602271`。

### 5.134 笔层跨屏穿透修复 + tramp14

- 根因：pen canvas 是 host 单例，switch_to_screen 未清空；旧屏 HP/轨道笔迹带到新屏。
- 修复：switch_to_screen 设置 cur_screen 后调用 host:pen_clear(g)；restart 同样清笔层。
- 新增 tests/pen_screen_test.lua：游戏屏产生笔迹→切结算，clears 增长，切屏后无新笔迹。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp14.love`：216 MB，737 files，sha256 `91638298f4c7f91e10cc36a34bffe2cbfb5970028c22d28dc506f9f6a5b882f1`。

### 5.135 每屏独立笔层 + tramp15

- H._pen_canvases[screen_id]：每屏独立 canvas / has_ink / layer mode/target/index。
- pen_layer(g) 切换当前屏的 canvas，不清空其它屏。
- pen_clear(g) 只清当前屏并只重置当前屏实体的 pen origin。
- pen_tick/pen_update 使用 Scene.in_scene 过滤，旧屏笔迹不会画进新屏。
- switch_to_screen 不再清空笔层；restart 调 pen_reset 丢弃全部屏笔层。
- pen_screen_test：切屏不再增加 clears，新屏无旧笔迹。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp15.love`：216 MB，737 files，sha256 `90a9115a0e46f92cba879ae153d49e0d7e32d9381d387c17fe7cc9313ce5f3f6`。

### 5.136 PC/Mobile 双交互语义 + tramp16

- H.device_type/is_mobile：KN_DEVICE 覆盖，否则 love.system.getOS；Android/iOS=mobile。
- H.pointer_valid + set_pointer/clear_pointer。
- PC：mouse 事件更新并保留 pointer；mouseup 后 get_mouse_info 仍有限。
- Mobile：touchpressed/moved/released；touchend 后 clear_pointer，get_mouse_info/pointer_world 返回 NaN。
- main：PC 不处理 touch，Mobile 不处理 mouse；touch 坐标从 0..1 转窗口像素；AtUI 同步接管。
- op_sensing.get_mouse_info 按设备语义；Game:pointer_world 检查 pointer_valid。
- Debug 页1显示 device/pointer/down。
- 新增 tests/device_semantics_test.lua；修复 nan_guard fake host。
- all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp16.love`：216 MB，737 files，sha256 `621aa6389acdc065a303f65f37c439ecada6b6d1f47b74f7709101e186705760`。

### 5.137 AtUI WASD/方向键十字 + 控制键 + tramp17

- 删除右侧 A 键；新增右侧 KEY 控制键。
- 左下 WASD 十字：W87/A65/S83/D68。
- 右下方向十字：↑38/←37/↓40/→39。
- Button onPress/onRelease → host simulate_key_down/up，支持按住。
- KEY 隐藏/显示八个键；隐藏时 setVisible(false)，Component 不再命中；隐藏会释放按住键。
- conf 包内 key_sim=true。
- 新增 tests/key_sim_test.lua；all.sh EXIT=0。
- 包 `player/knplayer-now-atui-20261022-tramp17.love`：216 MB，737 files，sha256 `1252aeed73f7b8766e114139e5052d7c67829eb82aff5a3ee2ad5d16e2482a08`。

### 5.138 k3t V2 编译/打包（不打包 now）

- 下载 `Fqz_b5...bcmkn`：projectName `k3t V2`，sha256 `881917f...`，1.9MB，1 scene/8 actors。
- 修复编译器 bug：tell 闭包内清空 proc_params，导致 procedures_2_parameter 变未实现原语；保留外层参数映射。
- 重新编译 custom_latest.lua：43 过程，912 行。
- 两个 SVG 素材转换失败，用 rsvg-convert 补 PNG；15/15 assets 存在。
- headless 加载：9 entities/3 threads，无 missing primitives/线程错误。
- all.sh EXIT=0。
- 包 `player/knplayer-k3tv2-atui-20261022-r2.love`：30.8MB，449 files，sha256 `2220d329812b9699e02a6fd3475fb5a15caef3a010ca2f1e32946afac76dabd6`。

### 5.139 ui_keys 字段冲突修复 + k3tV2 r3

- 根因：ui_keys 同时用 self.w 表示屏宽和 W 按钮；layout 时被覆盖成数字，set(b,x,y) 索引数字。
- 修复：屏宽/高改 screen_w/screen_h；self.w/a/s/d/up/down/left/right 只存按钮。
- 新增 mock 验证 ui_keys layout；all.sh EXIT=0。
- 重打包 `player/knplayer-k3tv2-atui-20261022-r3.love`：30.8MB，449 files，15 assets，sha256 `c867e8a69674590e06704df77dc24ef285c583554f2f484e9eab612365c3f2ab`。

### 5.140 k3t V2 3D 渲染根因修复 + r4

- compiler：procedures_2_parameter 改为按 mutation id 解析，重名 scale 不再覆盖；数值 scale 恢复。
- compiler：script_variables_value 不再错误映射到同名过程参数（Quaternion a/Q 冲突），四元数恢复。
- runtime：list_copy 源/目标为同一张表时直接返回，避免先清空把自己清空（TempLayerID[TV] 场景）。
- 结果：@PlayerPosition/@CameraMaxir 有限；TV=50；LayerID 非空 3；headless 300 帧 pen_stamps=508。
- 补 PNG：ea7ccdf3、ec5443e5；15/15 assets。
- 新增 tests/list_alias_test.lua；all.sh EXIT=0。
- 包 `player/knplayer-k3tv2-atui-20261022-r4.love`：30.8MB，449 files，sha256 `fb5403536b7ceb1d60387f4e8672c874e4a69a79e65a3a71a17ae022bb35d709`。

### 5.141 阶段 0 + 阶段 1 执行记录（P0 语义修复 / 测试门 / 打包）

授权范围：阶段 0（测试门 + 回归用例 + 单作品打包）+ 阶段 1（P0 正确性）。
未做：P1 边界项、阶段 2 输入层重构、阶段 3 性能、阶段 4 缺口块。

#### 官方取证（实现依据）

- `textSelect @1618671` / `textLength @1618983` / `convertType @1619126`（编辑器 bundle 逐字；
  `f.Z` = **Number.isNaN**，由同一模块的数值校验分支反证）
- `mathModulo @1615652`、`logicOperation @1614282`、`logicNegate @1614379`、`logicBoolean @1614437`
- `checkKey @1563644`、`mouseDown @1562946`、`distanceTo @1562155`
- 点击：`sprite_on_tap` action spec（player.main.63b4a46c.js）：
  `mouse_down → mouse_up`，`automatic_transitions:{mouse_up:""}`；click 用
  `getIsMouseClickTarget`，`onAfterUpdate` 每帧清空；`global_click` 由任意 <1s 点击置位（one_frame）；
  hat type 只有 `mouse_click/mouse_down/mouse_up`；scene 作为目标 = 点到舞台空白。
- `calculate`：官方内置 **math-expression-evaluator 1.4.0**（`isDegree=true`）；
  从 unpkg 取同版本源码逐条移植到 `rt/impl/formula.lua`，并用官方库在 node 下生成 oracle。

#### 改动

- 新增 `rt/impl/formula.lua`（lex → toPostfix → postfixEval；角度制；`1/0→"Infinity"`；
  非法公式抛错；Sigma/Pi/P/C/Mod/!/pow/int/&，隐式乘法）。
- 新增 `rt/host/taps.lua`：两个宿主共用的点击动作状态机（press/release/end_frame）。
- 新增 `tests/semantics_p0_test.lua`：69 项（文本 UTF-16/转换/公式 oracle/取模/逻辑/距离/
  键盘状态/点击帽不双触发/空白与角色点击/场景 id 目标）。
- `rt/values.lua`：`js_boolean`、`js_number`、`js_round`、UTF-16 长度/子串/charAt/反转。
- `rt/impl/op_sensing.lua`：text_select/text_length/convert_type/math_modulo/logic_*/
  check_key/mouse_down/distance_to/math_arc_trig；calculate 改调 formula。
- `rt/core.lua`：`Sched:tap_match`（按 type + --screen/scene/--self/角色/克隆匹配）；
  事件处理改为按 `kind`（mouse_down/up/click）；帧末清 click/mouse_up 状态；restart 清点击/键盘状态。
- `rt/host/love.lua` / `headless.lua`：点击事件只发一次（按下=down；抬起=up+click），
  key_states 记录 down/up；headless 补齐 on_keydown 事件与模拟键状态；删除 headless 重复定义。
- `tests/all.sh`：lua5.1/luajit 双 VM 门禁（缺 luajit **默认 exit 2**；
  `KN_ALLOW_MISSING_LUAJIT=1` 才显式 SKIP）；补 perf_layers/perf_extreme/vm_conformance/
  semantics_p0；修 `vm_conformance` 的 `goto` 语法（Lua5.1 不可用）。
- `tools/pack.py`：必带 `At/`；默认**单作品**（conf.STARTUP.work 或 `--work=名`），
  只收该作品素材闭包；包内改写 conf.lua；`--all-works` 才回到全量；增加条目断言。

#### 验证

- `lua5.1 tests/semantics_p0_test.lua`：69/69（lua5.1 与 luajit 均通过）。
- 双 VM 全量：`sh tests/all.sh` → EXIT=0；52 个测试文件 × 2，Lua 断言 615/VM，
  Python 132 项，0 失败。`vm_conformance`：PASS 23 / FAIL 0 / 探路 1。
- 31 个已编译作品：lua5.1 与 luajit 各 smoke 60 帧，载入/运行/缺失原语全 0。
- `now` 900 帧：text_effect 16548 次采样，无 `�`/`$` 污染；实体 131 / 线程 99（与修复前一致）。
- 打包：`--work=effects` → 20.1MB / 432 文件 / 2 素材 / At 30 个；默认 conf 作品同样单作品通过。

#### 实施中对上一轮报告的修正（以官方为准）

1. `text_select` 的 start/end 是**闭区间**：`"你好世界",2,4` 官方返回 `"好世界"`（3 字），
   不是 2 字；测试期望已按官方修正。
2. `convert_type("abc", number)` 官方返回**原字符串 "abc"**（Number.isNaN 分支），先前结论正确；
   而 `convert_type(true, number)` 返回字符串 `"true"`。
3. `global_click`（`--screen` 的 click）在官方是**任意一次 <1s 点击**都置位，不是仅空白点击；
   "仅空白"只适用于**场景 id 作为目标**的 hat/检测。

#### 仍未解决（未获授权 / 需真机）

- P1 边界：`V.str` 数字格式（JS String 与 %.14g 不同）、`list_item` 越界 nil vs NaN、
  背景 NONE 缩放、文本特效阻塞、图片印章特效、restart rotation_type 等。
- 阶段 2：输入层进一步统一（focus 失焦释放、键位表补全、时钟/事件队列）；触屏坐标待真机确认。
- 阶段 3：effect canvas 池化、`_capture_bg` 惰性化、args 表复用、图集/批处理。

### 5.142 P1 语义 + H 宿主修复执行记录

授权范围：上一轮报告 §2.2 的 P1-1…P1-13 + §2.3 的 H-1…H-4。未做：阶段 2 输入层重构、
topmost-only 派发、阶段 3 性能、阶段 4 缺口块、真机视觉验收。

#### 官方取证

- 列表索引：官方告警 `ILLEGAL_LIST_INDEX` = "有效值需大于等于1，已自动取最小值1"
  → 索引 = `Math.round(index)`，**<1 夹到 1**；`listItem` 取不到（>len/undefined）才 NaN。
  实现照 `aV.listGet/listItem/listInsertValue/deleteListItem/replaceListItem`。
- 数字转字符串：ECMAScript `Number#toString(10)`；用 node 生成 25 条 oracle
  （含 `0.1+0.2`、`1e15`、`1e21`、`1e-6`、`1e-7`、`1/3`、`2^53`、`5e-324`、`1.797…e308`）。
- 背景 NONE：`update_adaptive_scale`：纹理两轴都小于 view → `max(r,i)`，否则 1:1。
- 鼠标坐标：`getMouseInfo` 用 `round(x,2)`；`bumpInto(--mouse)` 不要求按下，NaN 才 false。
- 文本特效：`selfTextEffectText/Size/Color` 各拿 thread_lock，等 `set_*` Promise 完成。
- 音频：`playAudioAndWait` 等 PLAY_END / PLAY_FAIL / PLAY_TIMEOUT；循环音不会自动结束。
- 按键：动作状态 `on_keydown` 的 sub_type=keyCode；补齐标准 keyCode ↔ LÖVE KeyConstant。
- 触摸：LÖVE ≥0.10 touch 回调坐标是**窗口像素**（官方 wiki）。

#### 改动

- `rt/values.lua`：`V.js_number_to_string`（最短可回读 + ECMAScript 格式 + 512 条缓存），
  `V.str(number)` 改用它。副作用（符合官方）：VM 的 `print(0.1+0.2)` 现在是
  `0.30000000000000004`，`vm_conformance` 期望同步修正。
- `rt/impl/data.lua`：`round_index`（round + <1 夹 1）；`list_item` 越界 NaN；
  insert/delete/replace 按官方 1-based 规则；非数字索引忽略/NaN（不再 table index NaN 崩）。
- `rt/host/love.lua`：
  - 背景 `H.bg_scale`（纯函数，P1-5）+ NONE 两轴都小时放大；
  - `get_mouse_info` 两位小数（op_sensing）；
  - `pen_stamp` 用 `sprite_shader` 画**处理后的外观**（P1-8）；
  - `cancel_pointer` / `release_all_input`（H-2）；
  - `audio_playing`（P1-12 轮询）；
  - keymap 改用 `rt/host/keymap.lua`；key_down 逐个物理键检查。
- `rt/host/headless.lua`：共用 keymap；`cancel_pointer`/`release_all_input`；
  `_audio` 计时 + `audio_playing`；模拟键状态与 love 对齐。
- `rt/host/keymap.lua`（新）：标准 keyCode 表（字母/数字/方向/空格/回车/Shift/Ctrl/Alt/
  Esc/Tab/Backspace/Delete/Insert/Home/End/PgUp/PgDn/F1-F12/小键盘/标点）。
- `main.lua`（H-1/H-2/H-4）：
  - `runtime_keys` / `runtime_mouse_down` / `runtime_touch_id`：只对真正下发给运行时的
    按下补发抬起；AtUI 吞掉的按键/点击不再产生"凭空松开/点击"；
  - `love.focus(false)` → `release_all_input()`；
  - 删除 `touch_px()` 二次换算，touch 坐标直接用（窗口像素）。
- `rt/impl/effects.lua`：三个文字特效原语应用后让出一帧（官方 thread_lock 等价）。
- `rt/impl/motion_looks.lua`：删除 `pointer_ignore=true`（P1-11）；`rotation_type`
  同步 `rotation_style`。
- `rt/core.lua`：`spawn_rotation_type` 快照 + restart 重置（P1-9）。
- `rt/impl/op_sensing.lua`：`bump_into(--mouse)` 不要求按下（P1-10）；
  `get_mouse_info` round2（P1-6）；`math_arc_trig` 已在 5.141 修（P1-13）。
- `rt/impl/audio.lua`：`play_audio_and_wait` 逐帧轮询 `host:audio_playing`（P1-12）。
- `tests/semantics_p1_test.lua`（新，73 项）；`tests/note_fall_test.lua` 的音频 mock 补
  `audio_playing`；`tests/vm_conformance.lua` 浮点期望改为 JS 语义；`tests/all.sh` 纳入新测试。

#### 验证

- 新测试：lua5.1 / luajit 各 **73/73**。
- 双 VM 全量：`sh tests/all.sh` → EXIT=0；53 个测试文件 × 2，Lua 断言 696/VM，Python 132，0 失败；
  `vm_conformance` 23 PASS / 0 FAIL / 1 探路。
- 31 个已编译作品：lua5.1 与 luajit 各 smoke 60 帧，载入/运行/缺失原语全 0。
- `now` 900 帧：无错误；实体 130 / 线程 98（文本特效让出一帧导致的时序小差）。
- 额外：209 个随机/边界 double 与 node `String(v)` 对比，**209/209 一致**（V.str）。
- 打包脚本未改；阶段 0 的单作品/At 断言仍有效（重新打 effects 包通过）。

#### 仍未解决

- **topmost-only 点击派发**：当前点击帽仍对指针下所有重叠角色派发；PIXI 只派发给最上层 target。
  这会改变 now 的"手指光标"行为，需要单独设计 + 真机验证（未授权/未改）。
- P1-8 图片印章特效只能真机看；H-1/H-2/H-4 与 main.lua 的 LÖVE 回调本机无法执行，
  已用 host API + 纯函数覆盖可测部分。
- 阶段 3 性能（画布池化、effect cache、args 表复用、图集）未做。

### 5.143 性能优化执行记录（PERF-1/2/4/5/6/7；不打包）

授权：执行上一轮报告 §3 的性能项；明确**不打包任何作品**。PERF-3（args 表分配）、
PERF-8（SpriteBatch/图集）、PERF-9（字体分级）、PERF-10（音频预载）未做，原因见末尾。

#### 改动

- **PERF-1 效果画布池**（`rt/host/love.lua`）
  - 新增 `H:_fx_get_canvas/_fx_put_canvas/_fx_release_caches`，按尺寸复用（每尺寸最多 8 张）。
  - `draw_clone_effects`：删除"把 out 再拷到 cc"的第二次绘制与 `newCanvas`；缓存直接持有 out，
    下一帧 `begin_frame` 归还池子。
  - `sprite_effect_canvas`：src/各 pass 都走池；pass 结束立即归还上一张；最终结果帧末归还。
- **PERF-2 背景拷贝惰性化**
  - `rt/init.lua` 按 `M.requires` 是否含 `bump_into_color` 设 `game.uses_color_touch`。
  - `H:draw` 只有颜色作品/`color_debug` 才执行 `_capture_bg`（原来所有作品每帧整屏拷贝）。
- **PERF-3（部分）**：`script_var_name`/`resolve_var_key` 对普通变量键跳过 JSON 正则；
  `show_hide_list` 不再改调用方 args（为将来常量表复用解除污染）。
- **PERF-4 渲染列表**
  - `scene.render_list` 复用同一张表；先 O(n) 检查顺序，顺序没变就不 `table.sort`。
- **PERF-5 克隆候选缓存**
  - 新增 `Game:clones_of(owner)`（版本含 clone_seq/clones/#entities，防止延迟克隆漏项）；
    `fire_bump` / 广播 / `live_listeners` / 点击执行主体都改用它。
- **PERF-6 alpha 取样**
  - `H:style_pixels` 不再逐像素 `sub` 重建 alpha 串，直接返回 RGBA8 原始串；
    新增 `Hit.alpha_at(px,i)`（兼容旧 alpha 串），所有命中/内部点/alpha 包围盒/颜色检测改用它。
- **PERF-7 笔层批量**
  - 新增 `_pen_batch_begin/_pen_batch_end`：步骤内多笔/印章只 push+setCanvas 一次，帧末统一 pop；
    绘制阶段 (`pen_update`) 仍用局部 push/pop，避免把舞台画进笔层。
- 热路径：`math_arithmetic` 数值快路径；`coordinate_of_sprite` --self 快路径；
  `bump_into(--self, X)` 的 actor/edge/mouse/screen 快路径（camp_* 仍走完整路径）。
- 新增 `tools/perf_bench.lua`、`tests/perf_opt_test.lua`（35 项：alpha_at 两格式、render_list、
  clones_of、uses_color_touch、快路径结果、画布池/笔层批量伪 love 测试）。

#### 数据（本机 headless；同一 1200/300 帧方法）

| 项 | 优化前 | 优化后 | 变化 |
|---|---|---|---|
| `now` step（lua5.1） | 2.816 ms | 2.202 ms | **-21.8%** |
| `perf_extreme` step（lua5.1） | 1.559 ms | 1.327 ms | **-14.9%** |
| `now` step（luajit） | — | 0.885 ms | — |
| `perf_extreme` step（luajit） | — | 0.271 ms | — |
| 克隆候选扫描（20 hat×300 clone） | 1.408 ms/1000 | 0.0367 ms/1000 | **38×** |
| render_list（同 132 实体 A/B） | 0.090 ms | 0.083 ms | -8% |
| alpha 串重建 512² / 2048² | 50 / 830 ms | **0（不再重建）** | 内存 5B/px→4B/px |
| 效果画布（同尺寸/同 key 稳态） | 每帧 newCanvas + 第二次拷贝 | 池复用、0 新分配 | — |
| 笔层 push/setCanvas | 每角色/每印章一次 | 每批一次 | — |

#### 验证

- `tests/perf_opt_test.lua`：35/35（lua5.1 与 luajit）。
- 双 VM 全量：`sh tests/all.sh` → EXIT=0；54 个测试文件 × 2，Lua 731/VM，Python 132，0 失败；
  `vm_conformance` 23 PASS。
- 31 个已编译作品：两 VM 各 smoke 60 帧，0 错误/0 缺失原语；`now` 900 帧 130 实体/98 线程。
- 未打包任何作品（按要求）。

#### 未做 / 限制

- **PERF-3 完整版**：要把生成代码里的 args 表改为常量表复用/池化，需要编译器级改动并审计
  所有原语不写 args；当前只做了键解析快路径。收益也小于绘制/GC 侧。
- **PERF-8/9/10**：SpriteBatch/图集、字体分级、音频预载会改变绘制/内存策略，本机无 LÖVE
  无法验证，未动。
- **绘制侧数据不是真机 FPS**：画布池/笔层批量/背景拷贝是静态推理 + 伪 love 单测；
  GPU/驱动差异必须真机 `love . probe` 复核。

### 5.144 打包 now + k3t V2（2026-10-23 r1）

- `now`：产物 `works/now.lua`（23:41 编译，5294 行，303 素材闭包）→
  `knplayer-now-atui-20261023-r1.love`：**206.8 MB / 738 files / 307 asset files**，
  sha256 `c92cf937855eb05f382c802a93ac5a3d1fe5c476855e5ed9114431535178a033`，
  conf `work=now`、`key_sim=false`、`probe=false`，build `498d1c21`。
- `k3t V2`：源 `work/custom_latest.bcmkn`，按 `--proc-trampoline` 重编译到临时文件与
  `works/custom_latest.lua` **diff=0**（912 行，43 过程，15/15 素材）→
  `knplayer-k3tv2-atui-20261023-r1.love`：**20.9 MB / 446 files / 15 assets**，
  sha256 `ee242197ca1dee965e0be0919cee04235f15bb5beb0e109f20c3ec5985af9ec7`，
  conf `work=custom_latest`、`key_sim=true`（沿用 r4 的屏幕按键）、`probe=false`。
- 两包均：只含目标作品 Lua、`At/` 30 文件、`rt/` 398 文件、无 diag/draw_dump/probe 标记、
  CRC 全通过、包内作品 Lua 与仓库 md5 一致。
- 双 VM headless 300 帧：now 120 实体/90 线程、k3t 9 实体/3 线程，0 错误、0 缺失原语。
- 体积差说明：k3t 包比 r4 小 10MB，是 `font.ttf` 由 **stored(0) 改为 deflate(8)**，
  原始 10.5MB 不变；不是漏文件。
- `tools/pack.py` 新增 `--key-sim`：只改写包内 conf，不动仓库 conf.lua。
- 未运行 `love`（本机没有），绘制/触摸/音频仍需真机复核。

### 5.145 阶段 4：原语注册表 / schema / 缺口块 / 离线清单

授权：阶段 4（扩展性/缺口），不打包作品。

#### 1) 原语注册表（rt/registry.lua）

- 所有原语模块按顺序登记到 `rt.registry`（defs/providers/conflicts/overrides），
  `rt.init` 构建 `rt.f` 时**同名不同实现直接 error**；确实需要覆盖必须在 `allow` 登记
  （当前没有例外）。
- 清理了 10 处跨模块静默覆盖：
  - 删除 `motion_looks` 的 3 个动画空桩（effects 才有真实现）；
  - 删除 `data` 的 `show_hide_timer/show_hide_ranking/update_ranking` 空桩；
  - 删除 `op_sensing` 的 `get_answer/get_choice_and_index` 桩（ui 真实现）、
    `bump_into_body_part` 空桩、`multiline_text` 别名、`shadow_text=nil` 占位；
  - 删除 `audio.translate` 桩（ui 真实现）。
- 另清死代码：`rt/host/panel.lua`（无引用）、`rt/decimal.lua`（已归档、无引用）、
  `rt.norm_args`（从未调用）、`Game:declare_lists`（从未调用）。
- `rt.impl.aliases` 导出 `ALIAS`，注册表记录别名来源；`install` 函数不再混进 `rt.f`。

#### 2) schema（tools/gen_schema.py → rt/schema.lua）

- 从 `kn_spec/block_catalog.json` 生成：每个类型的参数名、事件标记、离线原因、
  历史/内部原语白名单；`--check` 可当门禁（已接入 `tests/all.sh`）。
- `tests/registry_test.lua`（10 项）覆盖：
  - 冲突 0；
  - 目录 266 条里：**155 个运行期实现 / 111 个事件/编译期/离线 / 0 缺失**；
  - 运行期 **0 个未登记原语**；
  - 参数 schema 能查出未知键（`Registry.unknown_args`）。
- 说明：默认不在每次原语调用上做参数校验（会拖慢热路径）；schema 供注册表覆盖门、
  调试与工具链使用。

#### 3) 补齐 5 个通用缺口块

- `script_variables_set`：写线程 `script_vars`；JSON `{"name":...}`/名字/alias 都解析；
  非脚本变量回落到 `variables_set`。
- `change_script_variables`：increase/decrease，V.num 数值语义；同样回落 `change_variables`。
- 修复 `change_variables` 脚本 JSON 路径的一个旧 bug：以前用**名字**直接写
  `th.script_vars`，而读取按 **id**（alias）→ 现在统一 `g:resolve_var_key`。
- `get_sprite_property`：x/y、style_index、scale/width/height/direction/visibility、
  distance、0..6/color/opacity/brightness/pixelate/ripple/distortion/grayscale；
  未知属性 NaN（官方"暂不支持"）。
- `math_trig_rad`：弧度制 sin/cos/tan/asin/acos/atan，不做角度换算、不 round2。
- `sound_color`：保存 per/speed/pitch/volume 到 `game.voice_color`，调用可选
  `host:set_voice_color`；官方是 TTS 语音音色，离线没有语音合成，**不假装改变音乐**。
- `get_play_audio`：作为 LEGACY_BLOCK 收进目录（目录 265→266）；运行期保留兜底原语。

#### 4) 离线不支持清单 + 编译期报告

- 单一分类源 `kntl/support.py`：编译期构造、事件（目录 isEvent）、离线前缀/精确类型
  （AI/micro:bit/CatBit/魔棒/机器人/人脸/人体/物体/摄像头/在线排行榜等）。
- 编译时打印：
  `离线不支持：N 类块（LOVE 无对应服务/硬件，运行期为空操作）` + 每类原因；
  产物写 `M.unsupported_blocks = { [type]="原因" }`。
- `tests/support_test.py`（18 项）：分类正确、最小作品编译触发清单、产物元数据存在。
- 明确：这些块仍是 no-op/0，不是已实现；用到它们的作品在 LÖVE 上不会有对应功能。

#### 验证

- 新测试：`registry_test` 10/10、`gap_blocks_test` 26/26（lua5.1 与 luajit 各一遍）。
- 双 VM 全量：`sh tests/all.sh` → EXIT=0；**56 个测试文件 × 2**，Lua **767/VM**，
  Python **150**，0 失败；vm_conformance 23 PASS。
- 31 个已编译作品：两 VM 各 smoke 60 帧，0 错误/0 缺失原语；`now` 600 帧 131/99。
- 重新编译 `now`、`k3t V2` 与仓库产物 **diff=0**（本次只影响缺块/元数据，不改既有代码生成）。
- 未打包任何作品。

#### 仍未做

- 硬件/AI 真实功能（需要设备/在线服务，不在离线运行时范围）。
- 每次调用的 schema 强校验（会拖慢；目前是工具/测试门）。
- topmost-only 点击派发、绘制/GPU 性能、真机触摸/印章视觉。

### 5.146 k3t V2 专项性能优化（先剖析后优化）

#### 剖析方法

- headless 按帧计时（lua5.1 + luajit 各跑），统计每帧原语调用数、过程调用数、
  host 笔迹调用；用 `debug.getinfo(proc).linedefined` 定位热点过程。
- k3t V2：9 实体、3–4 线程；没有 clone 爆炸。600 帧统计
  `pen_stamps=1024`（1.7/帧）、`pen_lines=0`、`pen_dots=0`、`pen_clears=87`；
  绘制侧很轻，**瓶颈在脚本解释层**。

#### 结论：尖峰来自作品自己的 10Hz 渲染

- `wait 0.1` 的 render 循环每约 7 帧执行一次 `clear_drawing` + 重建 3D 模型。
- 正常帧约 1k 次原语调用；render 帧约 **27 万次**：
  `logic_compare 86586 / list_item 39999 / script_variables_value 34604 /
   math_arithmetic 32607 / variables_set 32149 / script_variables 30858 /
   temporary_list 3317`。
- 热点过程 `proc_25eb...`（模型顶点访问器）单帧 **29,784 次**：
  3 个 script_variables 声明、3 个 variables_set（JSON 键）、多次 script_variables_value /
  list_item / math；而每次调用都经 trampoline（`coroutine.create/yield/resume` + args 表）。
- `fps/count/t` 三个变量的逐帧差异是作品用 `os.date("%S")` 真实时钟做 FPS 统计，
  不是优化改变了语义（初始状态对比完全一致）。

#### 已实现的优化

1. **叶子过程直调**（kntl/emit.py）
   - 编译后扫描 `proc_* = function` 体；体内没有 `th:call_proc` 的过程视为叶子，
     调用点改成 `proc_x(th, self, ...)`；递归/相互调用的过程仍走 trampoline。
   - k3t：43 个过程中 **14 个叶子**，44 个调用点改直调；300 帧省下约 167 万次
     coroutine 往返。
2. **常量参数表复用**（kntl/emit.py）
   - 全字面量 args hoist 到模块级 `local __CONST = { {…}, … }`，调用点用 `__CONST[i]`。
   - k3t：149 个常量表；`script_variables_value{TEXT="a"}` 等不再每帧分配。
   - **踩坑**：最初每个常量一个 `local __C1`，now 140+ 常量直接触发 Lua 5.1
     “more than 200 local variables”；改为单张表解决。
3. **运行时快路径**（rt/impl/data.lua、rt/core.lua、rt/impl/op_sensing.lua）
   - `script_var_name`：JSON 变量键解析结果缓存（字符串常量 → name）。
   - `Game:resolve_var_key`：JSON 键解析缓存，避免每次正则。
   - `script_variables_value`：无 alias 的脚本变量直接读 `th.script_vars[name]`
     （有 alias 仍走 resolve，保持语义）。
   - `list_item`：list 已是表 + 整数 index + any 的快路径（k3t 模型访问器）。
   - `logic_compare`：number/number 的 LT/LTE/GT/GTE 直接比较。
4. 重新编译 `works/custom_latest.lua`（--proc-trampoline）：1061 行，含 149 个 __CONST；
   未改 `now` 等其它产物。

#### 数字（headless，同一台机；只统计 `rt.step`）

| 版本 | lua5.1 | luajit | max 尖峰 |
|---|---|---|---|
| 基线（旧产物 + 旧运行时） | 181.9 ms/帧 | 67.6 ms/帧 | 1.3s / 539ms |
| 旧产物 + 新运行时（仅运行时快路径） | — | ~40.6 ms/帧（3 次 36.3/44.9/40.6） | — |
| **新产物 + 新运行时（最终）** | **~88 ms/帧** | **~14.5 ms/帧**（3 次 14.0/15.6/21.0；复测 14.1/14.4） | **~0.67s / 150ms** |

- LuaJIT 约 **4.5×**，Lua5.1 约 **2.1×**；最大尖峰 LuaJIT 539→150ms。
- 剩余单帧 render 仍是 27 万次原语调用；继续往下压需要编译器级
  script-variable 本地化/内联访问器（会改变作用域策略，未做）。

#### 验证

- `sh tests/all.sh` → EXIT=0：56 个测试文件 × 2，Lua 767/VM，Python 159，0 失败。
- 31 个已编译作品：两 VM 各 60 帧，0 错误/0 缺失原语；`now` 600 帧 131/99。
- k3t 600 帧：无错误，9 实体/3–4 线程，笔迹统计不变（1024 stamps/87 clears）。
- 初始变量状态（load 后）新旧产物完全一致；逐帧 fps 变量差异来自 `os.date`，已说明。
- 未打包任何作品。

#### 仍未做

- 编译期 script variable 本地化/热点访问器内联（收益最大、风险也最大）。
- `temporary_list` 向量表池化（需要所有权/逃逸分析）。
- 绘制侧（k3t 只有 1.7 次 pen_stamp/帧，不是瓶颈）。
- 真机 FPS/触摸/视觉复测。

### 5.147 k3t V2 过程原子性修正（按用户实测反馈）

用户反馈：r2 包（叶子过程直调）从 4fps 提升到 8fps；但 `proc_74d5d8c1…` 失去原子性，
递归过程中能看到中间状态；若恢复 `th:proc` 原子性，fps 预计降到 2–4（官方 2fps）。

#### 根因与取舍

- r2 的 `--leaf-procs` 把 14 个叶子过程的调用从 `th:call_proc`（trampoline 协程）改成直调。
  这些叶子如果自身有 `iter_n/iter_w` 循环，会让出在**父过程的调用栈**上，调度器在
  `proc_74d5…` 递归中途切到其它线程，暴露半成品状态。
- 先尝试“过程帧内一律禁止 iter 让出”：**不可行**——`pen_order_test` 一类作品的
  proc 循环依赖逐帧让出推进，会直接死循环。已回退该方案。
- 最终按“原子性优先”：**叶子直调默认关闭**（`--leaf-procs` 仅显式开启），k3t V2 用
  `--proc-trampoline` 全量 trampoline 重新编译，恢复 r1 的过程执行机制。

#### 结果

- `works/custom_latest.lua`：116 个 `th:call_proc`、149 个 `__CONST`；不再有直接 proc 调用。
- headless k3t：**LuaJIT ~40.3ms/帧、Lua5.1 ~161.5ms/帧**（优化前 67.6/181.9），
  即保留约 1.7×/1.13× 的常量表+运行时快路径收益；真机 `wait 0.1` 下预计约 4fps，
  符合“原子性恢复后 2–4fps”的预期。
- 常量参数表复用、脚本变量/键缓存、list_item/logic_compare 快路径保留；这些不影响
  过程调用边界。
- 回归：`sh tests/all.sh` EXIT=0（56 文件 ×2，Lua 767/VM、Python 159）；31 作品 smoke
  两 VM 0 bad；`pen_order_test` 通过；`now` 600 帧 131 实体。
- 已重新打 k3tv2 r3 包（见打包记录；`--work=custom_latest --key-sim`）。

#### 说明

- 本次没有实现“所有过程一律原子”的调度锁：它会让依赖逐帧 `iter_n` 的过程死循环
  （已用 `pen_order_test` 复现）。若后续仍看到中间态，需要按具体过程加白名单/锁，
  而不是全局禁止过程内让出。

### 5.148 sync_tell 内联修复执行记录（按 5.17 计划）

#### 改动

- `rt/impl/control.lua`：`sync_tell` 不再 `spawn + th:join`，改为官方 `eval_sync_tell` 语义：
  - 解析 target；
  - 保存 `th.execution_self`，切到 target；
  - **直接调用 DO**（同一线程、不 spawn、不 join）；
  - 调用返回后恢复 `execution_self`。
  - 不用 pcall（DO 可能含 wait/yield，Lua5.1 不能跨 pcall 让出）。
- `rt/core.lua`：
  - `Thread` 新增 `base_exec_self`；`Sched:finish` 统一复位 `execution_self`，
    覆盖 DO 抛错/被 stop/restart 等未走到恢复点的路径。
- `tests/sync_tell_test.lua`（16 项）：不新建线程、DO 的 self/execution_self、嵌套恢复、
  DO 内让出期间上下文、抛错清理、target 缺失、tell 仍 spawn。
- 编译器/产物未改；仍 `--proc-trampoline`，`--leaf-procs` 仍默认关闭。

#### 验证

- k3t V2 300 帧探针：
  - `Render/self_listen` 因 sync_tell 的 proc 挂起：**254 → 0**；
  - 剩余 wait_for 仅 `Main/on_running_group_activated` 2 次（启动广播，非 proc 中断）；
  - 性能：LuaJIT ~41.6ms/帧（600 帧 ~48.8ms，受作品 fps 统计/负载波动），
    Lua5.1 ~149.5ms/帧；与 r3 的 40.3/161.5 基本持平/略优。
- 全量 `sh tests/all.sh`：EXIT=0；57 个测试文件 ×2，Lua 783/VM，Python 159，0 失败。
- 31 个作品 smoke：两 VM 0 bad；`now` 600 帧 131 实体；
  `control_test`/`action_test`/`pen_order_test`/`sync_tell_test` 均通过。
- 用户建议的 non-trampoline 仅做探针：同一 256 次 join 等待，不能修复；本轮未实现/未启用。

#### 包

- `knplayer-k3tv2-atui-20261023-r4.love`（20.9MB/446 files，`--work=custom_latest --key-sim`）。
- 真机仍需确认：中间状态是否消失、FPS 是否维持 ~4（官方 2）。

### 5.149 代码结构整理 + HateNeko 0.1.0-test.1 测试发布

- 目录：
  - `player/` 仅保留可运行工程；`player/dist/` 放当前 .love；`player/archive/{packages,legacy,dev}` 放旧包/旧实现/探针。
  - 工作区新增 `archive/{backups,dev,reference}`：开发日志、备份、早期临时资料。
  - 官方 bundle/analysis/atlua 移到 `reference/`；`tools/gen_block_catalog.py`/`fetch_official_player.py`
    已更新路径并保留旧布局回退。
  - `player/diag.on`、`probe_out/`、`.tmp/` 移出运行根；正式运行不再默认开 diag。
- 文档：
  - 根 `README.md`（项目快速开始/目录/边界）、`CHANGELOG.md`、`VERSION=0.1.0-test.1`；
  - `archive/README.md`、`player/archive/README.md`、`release/README.md`、`RELEASE.md`。
- 发布：
  - `release/HateNeko-0.1.0-test1/`：
    - `HateNeko-0.1.0-test1-source.zip`（23MB；代码/测试/文档/演示作品+10 素材；不含其它作品 190MB 素材与官方 bundle）
    - `HateNeko-0.1.0-test1-demo.love`（21MB；演示作品）；
    - `SHA256SUMS`、`RELEASE.md`。
  - 源码包内 `player/conf.lua` 默认 `template3d_0243`，解压后 `cd player && love .` 可直接跑演示；
    `sh tests/all.sh` 需要完整 `works/assets`（开发工作区有）。
- 回归：整理后 `sh tests/all.sh` EXIT=0（57 文件 ×2，Lua 783/VM，Python 159）；
  解压 source zip 后 demo 300 帧正常，`sync_tell_test`/`gen_schema --check` 通过。

### 5.150 修复 self_listen 自我广播续播（图片渲染技术）

- 现象：`works/work.lua`（`bcmkn/picture.bcmkn`）只画到第 36/309 行，`运行=9999` 卡住。
- 根因：`self_listen_with_param` 在自身运行中广播 `"下一个像素"`；`Sched:broadcast`
  的 `has_live_listener` 守卫把它当作重复实例丢弃。作品依赖该广播分块续播。
- 修复（`rt/core.lua`）：
  - `find_live_listener` 返回活跃实例；
  - 普通广播（非 wait）遇到 live listener 时记录 `_pending_broadcast`（保留最新 event/param），
    不丢弃也不重复 spawn；
  - 新增 `restart_finished_listener`：在**两个线程结束路径**（step 入口已 done / resume 中结束）
    统一处理；有 pending 用新 event 续跑；`when` 保持轮询重启；`self_listen*` 无 pending 时
    回到空闲，不再拿旧 event 无限重跑；
  - 续播线程 `_defer_frame` 到下一帧，避免一次 step 画完整图造成长时间卡顿；
  - error/stop/epoch/hat_active 守卫。
- 验证：
  - `tests/listen_pending_test.lua` 9/9（续播参数、最新事件、无重复、线程不爆炸）；
  - `bcmkn/picture.bcmkn` 重新编译后，17 帧内到 `行=308`、`dots=169950`、
    y=`-27..281`（全图），无错误；
  - 全量 `sh tests/all.sh` EXIT=0：58 文件 ×2，Lua 792/VM，Python 175，0 失败。
- 包：`player/dist/knplayer-picture-atui-20261023-r1.love`（20.5MB/434 files，work=`work`，3 素材）。

### 5.151 AtLua 长列表虚拟化 + timer 官方语义 + sort 包

- AtLua：
  - `monitors_at.open_list` 不再为 N 项创建 N 个 Panel + 2N Label，改为 `ListLines`
    自定义内容：`measure` 只算总高度，`draw` 只画 `scrollY` 视口内行（O(可见行)）。
  - `At/components/Panel` 增加通用子项裁剪（有裁剪区时），`Label` 缓存 safe_utf8 结果；
    Console 原本已是 `first/last` 虚拟绘制。
  - 新增 `tests/virtual_list_test.lua`：10 万项只画 10 行、无行组件。
- Timer（官方 `get_timer`/`reset_timer`，非伪造）：
  - `Game.timer_block_ms`；`rt.start`/`Sched:restart` 重置；
  - `get_timer` = `(now_ms - timer_block_ms)/1000`（墙钟秒，带小数）；
  - `reset_timer` 只重置墙钟起点，不启动/停止可见计时器；
  - `执行计时器 停止` 仍冻结显示 `game.timer`，但不再影响 `get_timer`；
  - 新增 `tests/timer_semantics_test.lua` 12 项。
- 回归：全量 EXIT=0；60 文件 ×2，Lua 808/VM，Python 175，0 失败。
- `bcmkn/sort.bcmkn` 编译 `works/sort.lua`（146 行/6 素材），包：
  `dist/knplayer-sort-atui-20261023-r1.love`，sha256 `d6acfc0c…b09b8379`。

### 5.152 弹窗模态/分页/2×2 选择 + TextInput 光标

- 弹窗几何：`ui_at` 的 stage/ask/choice/translate 统一 `ph = stage_h * 0.5`，文本从卡片顶部开始，
  底部固定操作区。
- 舞台对话框分页：`paginate_text` 按字体/宽度/行高切页；`下一页` 只翻页，最后一页 `确定`
  才 `lock.stop()`；页码显示 `n/N`。
- 选择框改为 2×2：`(i-1)%2` 列、`floor((i-1)/2)` 行；索引语义不变。
- 模态隔离：
  - 遮罩改为可交互全屏 Panel（注册到 At）；
  - `atui.modal_active()` + `mousepressed/mousereleased/keypressed/textinput/wheelmoved` 全消费；
  - `main.lua` 在弹窗期间拦截 `mousemoved/touchmoved/keyreleased`；
  - 弹窗打开时 `release_all_input()`，弹窗期间 F1/F2 等快捷键也不透传。
- TextInput：
  - UTF-8 字节光标/选择锚点、左右/Home/End/Shift、Delete/Backspace、Ctrl+A/C/X/V；
  - 点击定位、水平滚动保持光标可见、选择高亮、密码模式；
  - `At/core/input.lua` 新增 byteOffset/charIndex/prevBoundary/nextBoundary/insert/removeRange。
- 测试：`modal_dialog_test.lua` 20 项、`textinput_cursor_test.lua` 13 项、`virtual_list_test.lua` 4 项；
  全量 `sh tests/all.sh` EXIT=0：62 文件 ×2，Lua 841/VM，Python 175，0 失败。
- 按要求未打包项目代码包。

### 5.153 IME 候选实验回退（textedited 不可靠）

- 上一轮尝试用 `love.textedited` 建立候选态/候选光标；真机上 LÖVE 的 IME 事件不可靠
  （社区 issue #2268 也指出 `love.textedited` 数据不可用/不完整）。
- 现象：输入法成对插入后，应用光标仍在插入串末尾；候选期方向键被吞，移动到其他位置仍失效。
- 已回退本轮 IME 相关代码：
  - `main.lua love.textedited`、`atui.textedited`、`At.textedited`、`registry.textedited`；
  - TextInput 的 `_ime_*` 候选态、候选光标映射、候选提交、候选期吞键、失焦 commit；
  - `tests/textinput_ime_test.lua` 与 all.sh 条目。
- 保留：上一轮的弹窗/分页/2×2、TextInput UTF-8 光标/选择/点击定位/水平滚动、timer/虚拟列表。
- 回归：62 文件 ×2，Lua 841/VM，Python 175，0 失败。

### 5.154 一站式 .bcmkn → .love 打包

- `tools/pack.sh` 首参为 `*.bcmkn` 时自动分派：
  `tools/build_love.py <src> <out>`：
  1. 内部作品名默认取输出文件基本名（非字母数字下划线替换为 `_`，可用 `--work=` 覆盖）；
  2. `python3 -m kntl.compile` 编译到 `works/<名>.lua`，素材同步；
  3. 刷新 `rt/build.lua`；
  4. 调用 `tools/pack.py` 收素材闭包、原子写出并校验。
- 保留旧用法：`sh tools/pack.sh out.love --work=name`。
- 临时验证：`sort.bcmkn → dist/_oneshot_test.love` 成功（20.2MB/437，CRC/At/单作品校验通过），测试包已清理。

### 5.155 nodevm 输入覆盖层点击（ask 卡片外透传）

- 现象：`input("a")` 时 `新角色1` 显示，但点击无效。
- 根因：`新角色1` 可见时同时存在 ask 弹窗；`atui.mousepressed` 的模态门禁在进入 `rt.hit` 前消费了舞台点击。
- 修复：
  - 普通非模态状态下，命中“有有效点击 hat 的可见舞台角色”时优先于 AtUI 浮层，直接交给舞台；
  - 对 **ask 弹窗**再开放一个窄例外：
  - 点击在弹窗卡片内：仍完全由弹窗消费；
  - 点击在卡片外且命中一个可见、带活跃 `sprite_on_tap/sprite_on_click` hat 的舞台角色：透传给舞台；
  - 其它卡片外点击仍被門禁消费。
- `atui.mousepressed` 记录 `_modal_passthrough`，`mousereleased` 对应交回舞台。
- 测试：`modal_dialog_test` 增加卡片外点击角色透传/卡片内消费，5 项。
