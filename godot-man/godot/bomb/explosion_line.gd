extends Node2D

@onready var explosion_path : Line2D = $explosion_path

var stopped_explosion = false

func show_explosion():
  show()

func stop_explosion_at(point : Vector2) -> void:
  if (stopped_explosion): return
  stopped_explosion = true
  var p := to_local(point)
  explosion_path.set_point_position(1, p)
  if (p.length() < XX.half_tile_size): explosion_path.hide()

func set_power(power : int) -> void:
  var original_point := explosion_path.get_point_position(1)
  var target_point := original_point * power
  explosion_path.set_point_position(1, target_point)
