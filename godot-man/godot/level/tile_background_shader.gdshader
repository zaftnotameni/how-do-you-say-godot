shader_type canvas_item;

#include "res://godot/lib/utilities.gdshaderinc"

void fragment() {
  vec2 v2 = scroll_on_both(UV, vec2(0.2, 0.2), TIME);
  v2.x = mod(v2.x, 1.0);
  v2.y = mod(v2.y, 1.0);
  vec4 original = texture(TEXTURE, v2);
  reset_color(UV, COLOR);
  COLOR = original;
}
