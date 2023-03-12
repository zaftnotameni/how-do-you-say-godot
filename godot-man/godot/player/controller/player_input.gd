extends Node2D

func input_vector() -> Vector2 :
  var y = Input.get_axis('p1_up', 'p1_down')
  var x = Input.get_axis('p1_left', 'p1_right')
  var input = Vector2(x, y).limit_length(1)
  return input

func input_bombs() -> bool:
  return Input.is_action_just_pressed('p1_place_bomb')
