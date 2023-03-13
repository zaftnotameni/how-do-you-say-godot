extends Node2D

var power := 2
var countdown := 3

@onready var explosion_center := $explosion_center
@onready var explosion_sound := $explosion_sound

signal on_explosion_started()

func _ready() -> void:
  explosion_center.hide()

func start_explosion():
  explosion_sound.play()
  explosion_center.show()
  on_explosion_started.emit()
