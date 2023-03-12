extends Node2D

@export var player_index := 1
@onready var player_movement := $player_movement

func _physics_process(delta: float) -> void:
  player_movement.do_physics(delta)
