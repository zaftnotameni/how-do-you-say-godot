shader_type canvas_item;
render_mode blend_add;
uniform sampler2D color1;
uniform sampler2D color2;
uniform sampler2D screen_texture : hint_screen_texture;
uniform sampler2D noise_r : filter_nearest,repeat_enable;
uniform sampler2D noise_g : filter_nearest,repeat_enable;
uniform sampler2D noise_b : filter_nearest,repeat_enable;
uniform sampler2D noise_a : filter_nearest,repeat_enable;

const lowp vec2 scroll1 = vec2(1.0, 0.4);
const lowp vec2 scroll2 = vec2(0.2, 1.4);
const lowp vec2 speed1 = vec2(0.05, 0.05);
const lowp vec2 speed2 = vec2(0.05, 0.05);
const lowp vec2 stretch = vec2(0.5, 0.95);
const lowp float explosion_size = 0.7;
const lowp float wobble = 0.3;
const lowp float color_mix = 3.4;
const lowp float glow = 2.5f;

float calc_intensity(sampler2D tex, vec2 uv, vec2 scroll, vec2 speed) {
  return texture(tex, uv + TIME * scroll * speed, 0.0).r;
}
void axis_scale(vec2 uv, inout vec4 c) {
  // uv y left bigger 
  // uv x down bigger
  c.b = uv.y;
  c.g = uv.x;
}
void center_uv(vec2 uv, inout vec4 c) {
  // 0 -> 0.5 -> 1
  // 0 -> 1 -> 2 (v x 2)
  // -1 -> 0 -> 1 (v - 1)
  // 1 -> 0 -> 1 (abs(v))
  // 0 -> 1 -> 0 (1 - v)
  c.b = 1.0 - abs((uv.y * 2.0) - 1.0);
}
float distance_to_center(float value) {
  return abs((value * 2.0) - 1.0);
}
float closeness_to_center(float value) {
  return 1.0 - distance_to_center(value);
}
void moving_texture(vec2 uv, inout vec4 c) {
  c.a = texture(noise_a, uv + TIME).r;
}
void reset_color(vec2 uv, inout vec4 c) {
  c.rgba = vec4(vec3(0.0), 1.0);
}
void stepping_stones(vec2 uv, inout vec4 c) {
  // black -> blue
  // white -> green
  vec4 tex = texture(noise_b, uv);
  c.g = step(0.5, tex.g);
  c.b = step(0.5, 1.0 - tex.r);
}
vec2 scroll_on_y(vec2 uv, float s, float t) {
  return vec2(uv.x, uv.y + (t * s));
}
vec2 scroll_on_x(vec2 uv, float s, float t) {
  return vec2(uv.x + (t * s), uv.y);
}
const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
void fragment() {
  reset_color(UV, COLOR);
  vec4 tex_a = texture(noise_a, scroll_on_x(UV, -2.0, TIME));
  vec4 tex_b = texture(noise_b, scroll_on_x(UV, -3.0, TIME));
  COLOR.a = smoothstep(0.3, 0.6, closeness_to_center(UV.y) + tex_a.r / 3.0);
  vec4 target_color = mix(red, yellow, closeness_to_center(UV.y));
  COLOR.rgb = target_color.rgb;
  COLOR.rgb += vec3(smoothstep(0.89, 0.9, tex_b.r/2.0 + closeness_to_center(UV.y)));
}

//void fragment() {
//  vec2 suv = UV;
//  suv.x *= stretch.x;
//  suv.y *= stretch.y;
//
//  float intensity1 = calc_intensity(noise_a, suv, scroll1, speed1);
//  float intensity2 = calc_intensity(noise_b, suv, scroll2, speed2);
//  float intensity = intensity1 + intensity2;
//
//  float centrality = (1.0 - abs(UV.y - 0.5)) * 0.5;
//
//  if (wobble * intensity + (1.0 - wobble) * centrality > 1.0 - explosion_size) {
//    COLOR = mix(texture(color1, UV), texture(color2, UV), clamp(intensity * color_mix, 0.0, 0.1)) * glow;
//  }
//}
//
//
