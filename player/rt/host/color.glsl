extern number e_hue;
extern number e_bright;
extern number e_sat;

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
  vec4 t = Texel(tex, tc);
  if (e_sat != 1.0) {
    float g = dot(t.rgb, LUMA);
    t.rgb = mix(vec3(g), t.rgb, e_sat);
  }
  if (e_hue != 0.0) t.rgb = hue_rotate(t.rgb, e_hue);
  if (e_bright != 0.0) t.rgb = clamp(t.rgb + vec3(e_bright), 0.0, 1.0);
  return t * color;
}
