extern vec2 u_size;
extern number pixel_size;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  vec2 coord = tc * u_size;
  coord = floor(coord / max(pixel_size, 1.0)) * max(pixel_size, 1.0);
  return Texel(tex, coord / max(u_size, vec2(1.0))) * color;
}
