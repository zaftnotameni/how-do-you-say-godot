extends Node2D

var power := 2
var countdown := 3

@onready var placed_sound := $bomb_placed_sound

func _ready() -> void:
  placed_sound.play()
  var tween := create_tween()
  tween.set_trans(Tween.TRANS_BOUNCE)
  tween.set_ease(Tween.EASE_IN)
  tween.set_loops(countdown)
  tween.tween_property(self, 'scale', Vector2(0.75, 0.75), 0.85)
  tween.tween_property(self, 'scale', Vector2(1.05, 1.05), 0.15)
