# 官方运行时（KN）源码结论

> 播放器 bundle 与编辑器 bundle 只是**参考研究**，未随仓库分发。
> 下面每条都是**从源码读出来的事实**，本项目按它实现（不是猜的）。

## 1. 事件与线程
```js
block_metadata: {
  finish_out_of_run_group: ["on_running_group_activated"],     // 切屏时只销毁"绿旗"线程
  restart_when_finished:   ["self_listen","self_listen_with_param","when"]  // 监听跑完自动重启
}
```
- 每个块带 `group_id`（= 所属实体的屏幕 id），**唯独 `start_on_click` 不带**
  → 它永不"跑出运行组" → **作品开始播放时启动一次、跨切屏存活**
- `on_running_group_activated` 带 group_id + 在销毁表里 → **只在进入该屏幕时启动**
- 循环收尾 `iter_n()` 是 **yield**（不是 break）；`break` 只由 `break` 积木置位

## 2. 命中与碰撞
```js
is_touching(点){ 反旋转/反缩放 → 映射到纹理像素坐标 → tex[y*W+x] >>> 24 > 0 }
check_bumped_other: 都要 visible、都不能 has_left_stage、**必须同一 scene**、
                    包围盒粗筛 → 重叠区每 2px 采样 is_touching → 命中数 ≥ 5
has_left_stage:     getBounds() 四条边都 ≤ 0
```
- 每个显示对象 `interactive = true`；stage 有全屏 hitArea；scene_container 也 interactive
- **点击 = 按下→抬起 < 1000ms**（`drag_end` 里 fire `actor:click`），且抬起时目标与按下时相同

## 3. 旋转 / 缩放 / 翻转
```js
case MO.ALL: this.set_pixi_rotation(-rotation_value)      // PIXI 顺时针为正 → 取负 = 逆时针为正
set_scale(x,y){ … is_horizontal_flipped ? -r : r … }      // 旋转方式 LEFT_RIGHT 时横向镜像
```
- 旋转方式：`ALL` 自由 / `LEFT_RIGHT` 左右翻转 / `DONT` 不旋转
- 几何与绘制都基于 `texture.width/height × scale.x/scale.y`（两轴独立）

## 4. 背景自适应
```js
adaption = (asset.adaption === NONE ? NONE : COVER)       // 没写就是 COVER
CONTAIN: a = min(viewW/texW, viewH/texH); COVER: a = max(...); STRETCH: {r,i}
```
- `NONE` 才 1:1 密铺

## 5. 文字/图章
- `stamp` = **文字印章**（text, size, align）
- `image_stamp` = **图片图章**：把角色**此刻的完整外观**（独立宽高/旋转/翻转/透明度特效）印到笔层
- `clear_drawing` 即时清空整层笔层

## 6. 数据格式
- 脚本变量的写：`variables_set` 的 `variable` 字段是
  `{"type":"NEKO_SCRIPT_VARIABLE_TYPE-…","name":"dx"}` → 要解析成脚本作用域
- `math_number` 的值可能在 `fields.NUM` **或** `fields.TEXT`
- 「看着像数字就当数字，否则原样返回字符串」→ `"NaN"` 这类要编译成**字符串**
