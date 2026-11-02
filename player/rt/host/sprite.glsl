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

// 官方 PIXI ColorMatrixFilter.hue（player.main:5329351 / set_hue 5401585）：
//   n = cos(rad), r = sin(rad), i = 1/3, a = sqrt(i)
// 逐通道写死，避免 mat3 列主序/转置写错（旧版就是错在这里 → 色调变暗绿）。
vec3 hue_rotate(vec3 c, float deg) {
  float rad = radians(deg);
  float n = cos(rad);
  float r = sin(rad);
  float i = 1.0 / 3.0;
  float a = sqrt(i);
  float one = 1.0 - n;
  float m00 = n + one * i;
  float m01 = i * one - a * r;
  float m02 = i * one + a * r;
  float m10 = i * one + a * r;
  float m11 = n + i * one;
  float m12 = i * one - a * r;
  float m20 = i * one - a * r;
  float m21 = i * one + a * r;
  float m22 = n + i * one;
  return clamp(vec3(
    m00 * c.r + m01 * c.g + m02 * c.b,
    m10 * c.r + m11 * c.g + m12 * c.b,
    m20 * c.r + m21 * c.g + m22 * c.b), 0.0, 1.0);
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
  // ★ 贴图是**直通 alpha**（LÖVE：文件贴图非预乘；只有画布是预乘，见 color.glsl）。
  //   颜色矩阵直接作用在直通色上，输出仍是直通色，由 "alpha" 混合模式乘一次 alpha。
  //   旧版在这里照搬 PIXI（PIXI 贴图是预乘）先 /a 再 *a：对 alpha=128 的素材
  //   （run 的 Run 图标）会把 rgb 放大 2 倍后进矩阵、被 clamp 成 1，再乘两次 alpha →
  //   淡紫被压成暗绿。

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
