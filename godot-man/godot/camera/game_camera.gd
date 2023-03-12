extends Camera2D

@onready var player := find_parent('player')
@onready var player_body : CharacterBody2D = player.find_child('player_body')

func _process(delta: float) -> void:
  position = player_body.position
