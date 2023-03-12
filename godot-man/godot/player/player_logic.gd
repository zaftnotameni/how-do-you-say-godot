extends Node2D

@export var player_index := 1
@onready var player_movement := $player_movement
@onready var player_bombs := $player_bombs

func _physics_process(delta: float) -> void:
  player_movement.do_physics(delta)
  player_bombs.do_physics(delta)
