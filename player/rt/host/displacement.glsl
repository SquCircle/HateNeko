extern Image mapSampler;
extern vec2 u_size;
extern number displ_scale;
extern vec2 map_scale;
extern vec2 map_offset;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  // 官方 map sprite：2*view 尺寸，vFilterCoord 由 filterMatrix 映射。
  // 这里用等价的局部映射：filterArea 坐标 / (2*view) + map 偏移。
  vec2 map_uv = map_offset + tc * u_size * map_scale;
  vec2 m = Texel(mapSampler, map_uv).rg - vec2(0.5);
  vec2 offset = m * displ_scale / max(u_size, vec2(1.0));
  vec2 uv = clamp(tc + offset, vec2(0.0), vec2(1.0));
  return Texel(tex, uv) * color;
}
