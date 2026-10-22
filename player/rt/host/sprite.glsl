// 角色渲染效果：色相/亮度/黑白(饱和度)/像素化/扭曲/波纹
// 参数与官方 Pixi 滤镜对齐（见 crc_libs 的 effect 类）：
//   颜色  → ColorMatrixFilter.hue(value)
//   亮度  → 颜色矩阵偏移 = clamp(-1,1,value/100-1)（加性）
//   黑白  → saturate(0)；饱和度 → saturate(value/100)
//   像素化→ PixelateFilter(size)（按屏幕像素量化）
//   扭曲  → twist(angle, 中心)；波纹 → 正弦位移（近似官方 DisplacementFilter）
extern float e_hue;      // 色相旋转角度（度）
extern float e_bright;   // 亮度偏置（-1..1，0 = 不变）
extern float e_sat;      // 饱和度（1 = 原色，0 = 黑白，>1 更艳）
extern float e_pixel;    // 像素块大小（屏幕像素；<=1 表示关闭）
extern float e_twist;    // 扭曲角度（度）
extern float e_ripple;   // 波纹强度（0 = 关）
extern float e_time;     // 时间（秒，波纹动画用）
extern vec2  u_size;     // 绘制区域尺寸（屏幕像素）

const vec3 LUMA = vec3(0.2126, 0.7152, 0.0722);

vec3 hue_rotate(vec3 c, float deg) {
  float a = radians(deg);
  float cs = cos(a), sn = sin(a);
  mat3 m = mat3(
    0.213 + cs * 0.787 - sn * 0.213, 0.715 - cs * 0.715 - sn * 0.715, 0.072 - cs * 0.072 + sn * 0.928,
    0.213 - cs * 0.213 + sn * 0.143, 0.715 + cs * 0.285 + sn * 0.140, 0.072 - cs * 0.072 - sn * 0.283,
    0.213 - cs * 0.213 - sn * 0.787, 0.715 - cs * 0.715 + sn * 0.715, 0.072 + cs * 0.928 + sn * 0.072
  );
  return clamp(c * m, 0.0, 1.0);
}

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  // 官方滤镜链：Pixelate(2) → Displacement(3) → Twist(4)。
  // 对最终采样坐标而言，顺序反过来：先 Twist，再 Displacement，
  // 最后用 Pixelate 的屏幕坐标量化。
  vec2 uv = tc;

  // TwistFilter：官方 angle = ph(10 * value)，围绕中心/半径旋转。
  if (e_twist != 0.0) {
    vec2 p = uv - 0.5;
    float r = length(p) * 2.0;
    float ang = radians(e_twist * 10.0) * max(0.0, 1.0 - r);
    float cs = cos(ang), sn = sin(ang);
    uv = vec2(p.x * cs - p.y * sn, p.x * sn + p.y * cs) + 0.5;
  }

  // DisplacementFilter：官方用 mapSampler；这里保留正弦位移近似。
  if (e_ripple > 0.0) {
    uv += vec2(sin(uv.y * 40.0 + e_time * 4.0), cos(uv.x * 40.0 + e_time * 4.0)) * 0.010 * e_ripple;
  }

  // PixelateFilter：官方在 mapCoord 空间 floor(coord/size)*size。
  // 这是最终采样坐标上的量化，所以像素网格保持规则。
  if (e_pixel > 1.0) {
    float sz = max(1.0, min(e_pixel, min(u_size.x, u_size.y)));
    vec2 sp = uv * u_size / sz;
    uv = (floor(sp) * sz + sz * 0.5) / max(u_size, vec2(1.0));
  }

  vec4 t = Texel(tex, uv);
  if (t.a <= 0.0) return t * color;

  // 黑白 / 饱和度
  if (e_sat != 1.0) {
    float g = dot(t.rgb, LUMA);
    t.rgb = mix(vec3(g), t.rgb, e_sat);
  }
  // 色相
  if (e_hue != 0.0) {
    t.rgb = hue_rotate(t.rgb, e_hue);
  }
  // 亮度（加性偏置，与官方矩阵一致）
  if (e_bright != 0.0) {
    t.rgb = clamp(t.rgb + vec3(e_bright), 0.0, 1.0);
  }
  return t * color;
}
