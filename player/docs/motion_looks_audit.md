# 动作 / 外观 积木对照表

对照基准：**官方运行时源码**（见 `docs/official_notes.md`）+ 作品真实调用数据。

| 积木 | 官方语义 | 本实现 | 状态 |
|---|---|---|---|
| `self_move_to` / `self_set_position_x/y` / `self_change_coordinate_x/y` | 直接改位置 | 同 | ✓ |
| `self_go_forward` | 沿朝向前进，y 向上、逆时针为正 | `x+=d·cos, y+=d·sin` | ✓ |
| `self_point_towards` / `self_face_to` | 设朝向（逆时针为正）| `dir=d` | ✓ |
| `self_rotate` | 转角（逆时针为正）| `dir+=d` | ✓ |
| `self_rotate_around` | 绕点旋转，位置随之移动 | 本轮实现 | ✓（原为空 ✗）|
| `self_bounce_off_edge` | 碰边反弹（按朝向反射）| 反射朝向 | ✓ |
| `self_reset` | 位置(0,0)、朝向90、大小100、特效清零 | 本轮实现 | ✓（原为空 ✗）|
| `set_scale` / `self_change_scale` | 统一大小（百分比）| `scale` | ✓ |
| `set_width_height_scale` / `add_width_height_scale` | **两轴独立**缩放（百分比，9999% 上限）| `scale_x/scale_y` | ✓（`add_` 曾写废弃字段 ✗）|
| `set_sprite_style` / `next/prev_style` / `switch_style` | 换造型（按 UUID）| 按 id | ✓ |
| `self_appear` | 显示/隐藏 | `visible` | ✓ |
| `self_set_effect` / `self_change_effect` / `effect_of_sprite` | 颜色/透明/亮度/像素化/波纹/扭曲/黑白 | `effects[scope]` | ✓ |
| `self_set_pen_color/size/property`、`clear_drawing`、`image_stamp`、`stamp`、`set_pen_layer` | 笔层（官方：一个笔层位图）| 笔层画布 | ✓ |
| `self_stress_animation` / `self_appear_animation` / `global_animation` | 官方为装饰性动画 | 空实现 | ✗ 待实现 |

**文字印章/图像印章**：单基准字体(128)+缩放；印章尺寸 = 纹理×|scale| 取整、翻转只取符号、>8192px 不画（与官方一致 ✓）。
