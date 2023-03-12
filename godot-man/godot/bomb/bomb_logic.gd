extends Node2D

@onready var bomb : Node2D = find_parent('bomb')
@onready var placed_explosions := find_parent('level').find_child('placed_explosions')
const ExplosionScene := preload('res://godot/bomb/explosion.tscn')

func _ready() -> void:
  get_tree().create_timer(3).timeout.connect(explode)

func explode():
  var explosion := ExplosionScene.instantiate()
  explosion.global_position = bomb.global_position
  placed_explosions.add_child(explosion)
  bomb.queue_free()
