# 坐标系与单位（对照官方源码）

依据：`/workspace/tanyue_kn/static/js/crc_libs.cce421af.js` 等（见文末引文）。

## 三层坐标

| 层 | 原点 | 单位 | 说明 |
|---|---|---|---|
| **舞台坐标**（作品/角色位置）| **舞台中心 (0,0)**，y **向上** | 舞台单位 = 设计分辨率的 1px | 900×562 作品：x∈[-450,450], y∈[-281,281] |
| **逻辑像素**（渲染目标）| 左上角 | 1 | 我们的「舞台画布」= 900×562，1 舞台单位 = 1 像素 |
| **屏幕像素**（窗口/触摸）| 左上角，y **向下** | 设备像素 | 触摸/鼠标事件来自这里 |

**关键证据（官方原文）**：
```js
stage.hitArea = new Rectangle(-w/2, -h/2, w, h)      // 舞台原点在中心
stage.toGlobal(actor.position)                        // 舞台 → 屏幕（含舞台变换与缩放）
ctx.translate(view.width/2 + n.x, view.height/2 + n.y) // 笔层按"视图中心"落笔
```

## 换算规则

- 舞台 → 逻辑像素：`px = x + W/2`，`py = H/2 - y`（y 翻转 + 平移中心）
- 逻辑像素 → 屏幕像素：乘 `fit = min(窗口宽/W, 窗口高/H)`，再加黑边偏移
- **尺寸**永远是"缩放后"的：`屏幕尺寸 = 舞台尺寸 × |scale| × fit`
- 笔层（pen）画在**逻辑像素**里（画布 = W×H），**不乘 fit**；到了窗口再整体缩放

## 单位表（原语入参/出参）

| 原语 | 参数单位 | 返回单位 |
|---|---|---|
| `self_move_to` / `coordinate_x/y` | 舞台单位（px）| — |
| `self_go_forward` / `self_rotate` / `self_point_towards` | 度（逆时针为正）| — |
| `set_scale` / `self_change_scale` | **百分比**（100 = 原尺寸）| — |
| `set_width_height_scale` / `add_width_height_scale` | **百分比**（按轴）| — |
| `appearance_of_sprite`（xscale/yscale/scale）| — | **百分比**（100=原尺寸）※ 与 `100 × appearance` 写法配套 |
| `self_text_effect_size` | **像素**（逻辑像素里的字号）| — |
| `self_set_effect` 颜色 | `#RRGGBB` | — |
| `self_set_effect` 透明/亮度/灰度/像素化 | 0–100 | — |
| 音量 `play_audio(volume)` | 0–100 | — |

> ⚠️ `appearance_of_sprite` 的返回口径是 **百分比**：作品里出现 `100 * appearance(...)` 时，
> 那是作品自己在做"百分比→小数"的换算，**不是**要求原语返回小数。
> （此前误改成小数，导致 `set_scale` 全体缩小 100 倍——已回滚，见 `docs/motion_looks_audit.md`）

## 实现（单一事实来源）

`rt/host/coords.lua`（**纯 Lua，可单元测试**）提供全部换算：

| 函数 | 用途 |
|---|---|
| `canvas_pos(g, x, y)` | 舞台 → **画布像素**（画布内一切绘制都用它） |
| `stage_pos(g, px, py)` | 画布像素 → 舞台 |
| `fit(g, w, h)` | 画布 → 窗口的缩放与黑边偏移（**只在这里乘一次**） |
| `world_to_screen / screen_to_world` | 舞台 ↔ 屏幕（输入/HUD 用） |

**铁律**：`H:draw` 里把内容画进舞台画布时，一律用 `canvas_pos`；
`world_to_screen` 只允许出现在"画到窗口"或"输入换算"的地方。
`tests/coords_test.lua` 会用静态审计检查这条（扫 `H:draw` 源码）。
