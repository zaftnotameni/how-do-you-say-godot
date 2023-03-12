shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform sampler2D noise_r : filter_nearest,repeat_enable;
uniform sampler2D noise_g : filter_nearest,repeat_enable;
uniform sampler2D noise_b : filter_nearest,repeat_enable;
uniform sampler2D noise_a : filter_nearest,repeat_enable;
// uniform vec2 speed = vec2(-0.75, 0.0);
uniform vec2 scroll1 = vec2(1.0, 0.4);
uniform vec2 scroll2 = vec2(0.2, 1.4);
uniform vec2 speed1 = vec2(0.05, 0.05);
uniform vec2 speed2 = vec2(0.05, 0.05);
uniform vec2 stretch = vec2(0.5, 0.95);
uniform float explosion_size = 0.7;
uniform float wobble = 0.3;
uniform sampler2D color1;
uniform sampler2D color2;
uniform float color_mix = 3.4;
uniform float glow = 2.5f;

void do_thing(inout vec4 c, vec2 uv) {
  c.r = clamp(c.r * texture(noise_r, uv).r, .0, 1.0);
  c.g = clamp(c.g * texture(noise_g, uv).r, .0, 1.0);
  c.b = clamp(c.b * texture(noise_b, uv).r, .0, 1.0);
  c.a = clamp(c.a * texture(noise_a, uv).r, .0, 1.0);
}

float calc_intensity(sampler2D tex, vec2 uv, vec2 scroll, vec2 speed) {
  return textureLod(tex, uv + TIME * scroll * speed, 0.0).r;
}

void fragment() {
  vec2 suv = UV;
  suv.x *= stretch.x;
  suv.y *= stretch.y;
  
  float intensity1 = calc_intensity(noise_a, suv, scroll1, speed1);
  float intensity2 = calc_intensity(noise_b, suv, scroll2, speed2);
  float intensity = intensity1 + intensity2;
  
  float centrality = (1.0 - abs(UV.y - 0.5)) * 0.5;
  
  if (wobble * intensity + (1.0 - wobble) * centrality > 1.0 - explosion_size) {
    COLOR = mix(texture(color1, UV), texture(color2, UV), clamp(intensity * color_mix, 0.0, 0.1)) * glow;
  }
}


