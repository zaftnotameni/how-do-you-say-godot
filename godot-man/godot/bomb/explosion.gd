extends Node2D

var power := 2
var countdown := 3
var explosion_lifespan := 1

@onready var explosion_center := $explosion_center
@onready var explosion_sound := $explosion_sound

signal on_explosion_started()
signal on_explosion_cleanup()

func _ready() -> void:
  explosion_center.hide()

func start_explosion():
  explosion_sound.play()
  explosion_center.show()
  on_explosion_started.emit()
  var timer = get_tree().create_timer(explosion_lifespan)
  timer.timeout.connect(cleanup_explosion)

func cleanup_explosion():
  on_explosion_cleanup.emit()
  queue_free()
