# 官方播放器（KittenN web）—— 抓取与已查明的事实

## 怎么拿

```sh
python3 tools/fetch_official_player.py     # 下载到 /workspace/tanyue_kn/player/
```

来源链路：
```
https://kn.codemao.cn/player
  → https://creation.bcmcdn.com/neko/web/release/static/js/main.63b4a46c.js   （11.8MB，播放器主包）
  → 主包里的 webpack chunk 表 → 56 个 <id>.<hash>.chunk.js（懒加载，含运行时）
```
另外社区站的 `__app_config__` 里可以直接读到各子站地址（`"player": "https://player.codemao.cn"`,
`"kn": "https://kn.codemao.cn"` 等），比猜 URL 靠谱。

## 已确认的事实

1. **舞台坐标原点在中心**：`stage.hitArea = Rectangle(-w/2, -h/2, w, h)` → 角色 (0,0) 是舞台中心，y 向上。
2. **笔层画布 = 舞台尺寸**：`brush_canvas.width = stage:resize 的 data.width`，
   而角色精灵也监听同一个 `stage:resize` 并把自己的 `width` 设成它 → 该事件的尺寸就是**舞台设计尺寸**。
   ⇒ **文字印章的字号单位是舞台像素**（不是窗口像素）。我们据此把画布内所有尺寸改成舞台单位。
3. **文字印章原文**：
   ```js
   draw_text_stamp(text, size, align, rotation):
     n = stage.toGlobal(actor.position)        // 舞台 → 画布
     font = "bold " + size + "px ..."           // size 是画布像素
     translate(n.x, n.y); rotate; fillText(text, 0, 0)
   ```
4. **图像印章原文**：`translate(pos + view/2); rotate; scale(仅符号翻转); drawImage(-w/2,-h/2,w,h)`，
   `w/h` 取整；>8192px 不画。
5. **块的官方 callee 名**（我们实现里用的名字多数对得上，个别要注意）：
   | 积木 | 官方 callee |
   |---|---|
   | 角色属性值 | `get_sprite_appearance` |
   | 造型编号 | `get_sprite_style_index` |
   | 角色特效值 | `get_sprite_effect` |
   | 移动步数 | `self_go_forward` |
   | 设置大小 | `self_set_scale` |

## 待办

- [ ] 从懒加载 chunk 里取出**块实现**（`get_sprite_appearance` / `set_width_height_scale` 等），
      逐条与 `rt/impl/*.lua` 对照，补 `docs/units.md` 的"官方原值"
- [ ] 用 `node` 直接 require 运行时 chunk，做"同一作品 → 官方 vs 我们"的数值对比（不依赖浏览器）
