# 单位速查（实现必须遵守）

- **角色位置/尺寸/移动距离**：舞台单位（设计分辨率 px，原点=舞台中心，y 向上）
- **缩放类**：百分比（100 = 原尺寸）。内部统一存 `scale`(百分比) 和 `scale_x/scale_y`(倍数)
- **角度**：度，逆时针为正
- **字号**：逻辑像素（1 = 舞台 1px）。文字印章 final 尺寸 = 字号 × fit
- **笔层**：画在逻辑像素画布里（W×H），绘制到窗口时乘 fit
- **音量/透明度/特效强度**：0–100
- **颜色**：`#RRGGBB`

## 官方数值证据（crc_libs.cce421af.js / main.294b18c8.js）

```js
// 角色类（crc_libs）
anchor.set(.5)                                     // 锚点 = 纹理中心
update_pixi_position(x,y): transform_position = { x: x + w/2, y: -y + h/2 }   // y 取负
set_pixi_rotation(-rotation_value)                 // 旋转取负
get_scale() → { x: |pixi.x|, y: |pixi.y| }         // 返回**倍数**
tileTransform.pivot.set(w/2 + custom_pivot.x, …)   // 锚点可自定义
```

```js
// 笔层（crc_libs）
brush_canvas.width = stage 尺寸                     // 笔层 = 舞台大小 → 笔层内用舞台坐标
draw_text_stamp: ctx.font = "bold " + size + "px"  // 字号 = 舞台像素
draw_image_stamp: drawImage(img, -w/2, -h/2, w, h)// 图像印章尺寸 = 纹理×|scale|
```

```js
// 积木选项（main.294b18c8.js #message/#callee）
appearance_of_sprite → { scale: 大小, width: 宽度, height: 高度, direction: … }
self_change_scale / add_width_height_scale 都有「增加/减少」下拉
```

作品侧反证：`(115 - appearance)`、`(100 - appearance) / 5`、`math_round(appearance)` —— 只有**百分比**成立。

## 反例（曾经踩过的坑）
1. `add_width_height_scale` 写了废弃字段 `w/h` → 完全无效
2. `appearance_of_sprite` 改成返回小数 → `set_scale` 全体缩小 100 倍
3. 用 `currentSceneId` 当初始屏幕 → 开局进错场景（应为 `sortList[0]`）
4. `play_audio` 每次 newSource → 音乐叠播 + 泄漏（应单实例）
