shader_type canvas_item;
uniform sampler2D noise_r : filter_nearest,repeat_enable;
uniform sampler2D noise_g : filter_nearest,repeat_enable;
uniform sampler2D noise_b : filter_nearest,repeat_enable;
uniform sampler2D noise_a : filter_nearest,repeat_enable;
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
void fragment() {
  reset_color(UV, COLOR);
	float u = UV.x;
  float v = UV.y;
  vec4 tex_r = texture(noise_r, scroll_on_both(UV, vec2(0.8, 0.8), TIME));
  vec4 tex_g = texture(noise_g, scroll_on_both(UV, vec2(0.8, 0.8), TIME));
  vec4 tex_b = texture(noise_b, scroll_on_both(UV, vec2(0.8, 0.8), TIME));
  vec4 tex_a = texture(noise_a, scroll_on_both(UV, vec2(0.8, 0.8) * vec2(sign(cos(u * PI)), sign(sin(v * PI))), TIME));
  vec4 mixed_color = mix(red, yellow, linear_closeness_to_center(u, v)); // tex_r.r);
  COLOR.rgb = mixed_color.rgb;
  float noisy_distance = linear_closeness_to_center(u, v) + tex_a.r/3.0;
  COLOR.a = smoothstep(0.3, 0.6, noisy_distance);
  COLOR.rgb += vec3(smoothstep(0.65, 0.66, tex_b.r/1.5 + squared_closeness_to_center(u, v)));
}
