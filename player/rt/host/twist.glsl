extern vec2 u_size;
extern number twist_angle;
extern number twist_radius;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  vec2 coord = (tc - vec2(0.5)) * u_size;
  // 官方 radius 来自 target_sprite.width/height，不含 filterArea padding。
  float radius = max(twist_radius, 1.0);
  float dist = length(coord);
  if (dist < radius) {
    float ratio = (radius - dist) / max(radius, 1.0);
    float angle_mod = ratio * ratio * twist_angle;
    float s = sin(angle_mod);
    float c = cos(angle_mod);
    coord = vec2(coord.x * c - coord.y * s, coord.x * s + coord.y * c);
  }
  vec2 uv = coord / max(u_size, vec2(1.0)) + vec2(0.5);
  return Texel(tex, uv) * color;
}
