// 背景（屏幕造型）渲染：仿官方 Pixi TilingSprite 的 tileTransform
//   * 形变作用于「纹理图案」而不是精灵矩形 → 旋转/缩放/平移都不会露出空白
//   * 平铺用 fract() 自己实现，不依赖 GL_REPEAT（非 2 次幂纹理在部分驱动上不可靠）
//   * **不使用 screen_coords**：安卓高 DPI 下 sc 是物理像素，而我们的舞台是逻辑像素，
//     两者差一个 DPI 倍数（会把图案缩小成"比舞台小 + 密铺"）。
//     这里改用纹理坐标 tc（0..1）乘舞台尺寸，得到稳定的舞台空间位置。
extern vec2 tex_size;     // 纹理像素尺寸
extern vec2 u_size;       // 舞台尺寸（逻辑像素 = 舞台单位）
extern vec2 u_center;     // 舞台中心（舞台空间）
extern float angle;       // 图案旋转（弧度）
extern vec2 tscale;       // 图案缩放
extern vec2 pivot;        // 纹理空间里的旋转锚点 = 纹理中心 + centerPoint
extern vec2 scroll;       // 图案滚动（舞台空间像素，来自屏幕实体位置）

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  // 片段在舞台空间的位置（tc 在整图绘制时是 0..1，乘以舞台尺寸即舞台坐标；与 DPI 无关）
  vec2 sp = tc * u_size;
  vec2 q = sp - u_center - scroll;
  // 反向旋转（图案转 angle ⇒ 取样时反向转回来）
  float c = cos(angle), s = sin(angle);
  vec2 p = vec2(q.x * c - q.y * s, q.x * s + q.y * c);
  // 去掉图案缩放，得到纹理空间坐标；再加回旋转锚点 pivot
  p /= tscale;
  vec2 uv = (p + pivot) / tex_size;
  // 自己在着色器里平铺（UV 恒在 [0,1]）
  uv = fract(uv);
  return Texel(tex, uv) * color;
}
