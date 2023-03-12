extends AnimationPlayer

@onready var player_body : CharacterBody2D = find_parent('player_body')
@onready var player_movement := player_body.find_child('player_movement')

func _process(delta: float) -> void:
  var v : Vector2 = player_movement.input_vector.current
  var right := v.project(Vector2.RIGHT).x > 0
  var left := v.project(Vector2.RIGHT).x < 0
  var down := v.project(Vector2.DOWN).y > 0
  var up := v.project(Vector2.DOWN).y < 0
  if (right): return play('player_right')
  if (left): return play('player_left')
  if (down): return play('player_down')
  if (up): return play('player_up')
