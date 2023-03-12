extends Node2D

@onready var bomb := find_parent('bomb')

func _ready() -> void:
  get_tree().create_timer(3).timeout.connect(func(): bomb.queue_free())
