// 角色/背景共用的颜色特效：官方滤镜链 hue → brightness → saturate。
// 色调矩阵由 Lua 侧算好（rt/core/effects.lua hue_matrix），这里用 9 个标量 uniform
// 传入——避免不同 LÖVE 版本对 mat3 uniform 的发送格式/布局差异。
extern number e_hue_on;
extern number e_m00;
extern number e_m01;
extern number e_m02;
extern number e_m10;
extern number e_m11;
extern number e_m12;
extern number e_m20;
extern number e_m21;
extern number e_m22;
extern number e_bright;
extern number e_sat;

const vec3 LUMA = vec3(0.2126, 0.7152, 0.0722);

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  vec4 t = Texel(tex, tc);
  // 官方 ColorMatrixFilter 的 shader 在做颜色矩阵前会先**反预乘**（player.main:5326864
  // "Un-premultiply alpha before applying the color matrix"），矩阵后再预乘。
  // LÖVE 11 的画布/贴图同样是预乘色；不反预乘会让半透明像素被"再乘一次 alpha"→发暗。
  float a = t.a;
  if (a <= 0.0) return t * color;
  vec3 rgb = t.rgb / a;
  if (e_hue_on > 0.5) {
    rgb = clamp(vec3(
      e_m00 * rgb.r + e_m01 * rgb.g + e_m02 * rgb.b,
      e_m10 * rgb.r + e_m11 * rgb.g + e_m12 * rgb.b,
      e_m20 * rgb.r + e_m21 * rgb.g + e_m22 * rgb.b
    ), 0.0, 1.0);
  }
  if (e_bright != 0.0) rgb = clamp(rgb + vec3(e_bright), 0.0, 1.0);
  if (e_sat != 1.0) {
    float g = dot(rgb, LUMA);
    rgb = mix(vec3(g), rgb, e_sat);
  }
  t.rgb = rgb * a;   // 重新预乘
  return t * color;
}
