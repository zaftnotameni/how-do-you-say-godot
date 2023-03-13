void reset_color(vec2 uv, inout vec4 c) {
  c.rgba = vec4(vec3(0.0), 1.0);
}
float distance_to_center(float value) {
  return abs((value * 2.0) - 1.0);
}
float closeness_to_center(float value) {
  return 1.0 - distance_to_center(value);
}
float ss(float v) {
  return v * v;
}
float squared_closeness_to_center(float u, float v) {
  return ss(closeness_to_center(u)) + ss(closeness_to_center(v));
}
float linear_closeness_to_center(float u, float v) {
  return closeness_to_center(u) + closeness_to_center(v);
}
vec2 scroll_on_y(vec2 uv, float s, float t) {
  return vec2(uv.x, uv.y + (t * s));
}
vec2 scroll_on_x(vec2 uv, float s, float t) {
  return vec2(uv.x + (t * s), uv.y);
}
vec2 scroll_on_both(vec2 uv, vec2 s, float t) {
  return vec2(uv.x + (t * s.x), uv.y + (t * s.y));
}
const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);