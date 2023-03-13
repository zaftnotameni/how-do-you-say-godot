shader_type canvas_item;

void fragment() {
  COLOR.r = 0.0;
  COLOR.g = UV.x;
  COLOR.b = UV.y;
}
