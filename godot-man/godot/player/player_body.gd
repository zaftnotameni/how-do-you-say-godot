extends CharacterBody2D

@onready var player_logic := $player_logic

func _ready() -> void:
  motion_mode = MOTION_MODE_FLOATING
  player_logic.set_physics_process(true)
