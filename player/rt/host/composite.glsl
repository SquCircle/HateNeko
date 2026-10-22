extern Image mapSampler;
extern vec2 u_size;
extern number pixel_size;
extern number displ_scale;
extern vec2 map_scale;
extern vec2 map_offset;
extern number twist_angle;
extern number twist_radius;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  // 官方 P→D→T 链的等价采样：Q(D(T(tc))).
  vec2 uv = tc;

  // Twist (last filter).
  vec2 p = (uv - vec2(0.5)) * u_size;
  float radius = max(twist_radius, 1.0);
  float dist = length(p);
  if (dist < radius) {
    float ratio = (radius - dist) / radius;
    float ang = ratio * ratio * twist_angle;
    float s = sin(ang), c = cos(ang);
    p = vec2(p.x * c - p.y * s, p.x * s + p.y * c);
  }
  uv = p / max(u_size, vec2(1.0)) + vec2(0.5);

  // Displacement.
  vec2 map_uv = map_offset + uv * u_size * map_scale;
  vec2 m = Texel(mapSampler, map_uv).rg - vec2(0.5);
  uv += m * displ_scale / max(u_size, vec2(1.0));

  // Pixelate.
  if (pixel_size > 1.0) {
    vec2 coord = uv * u_size;
    coord = floor(coord / pixel_size) * pixel_size;
    uv = coord / max(u_size, vec2(1.0));
  }

  return Texel(tex, clamp(uv, vec2(0.0), vec2(1.0))) * color;
}
