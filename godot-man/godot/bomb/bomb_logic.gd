extends Node2D

@onready var bomb : Node2D = find_parent('bomb')
@onready var placed_explosions := find_parent('level').find_child('placed_explosions')
@onready var power : int = bomb.power
@onready var countdown : int = bomb.countdown
const ExplosionScene := preload('res://godot/bomb/explosion.tscn')

@onready var explosion := ExplosionScene.instantiate()

func _ready() -> void:
  setup_explosion()
  get_tree().create_timer(countdown).timeout.connect(explode)

func setup_explosion() -> void:
  explosion.power = power
  explosion.countdown = countdown
  explosion.global_position = bomb.global_position
  placed_explosions.add_child(explosion)

func explode():
  explosion.start_explosion()
  bomb.queue_free()
