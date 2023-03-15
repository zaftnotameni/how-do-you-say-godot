extends CollisionShape2D

@onready var bomb_detection_box : CollisionShape2D = find_parent('*bomb*').find_parent('*bomb*').find_child('bomb_detection_box')
@onready var bomb_detection_area : Area2D = find_parent('*bomb*').find_parent('*bomb*').find_child('bomb_detection_area')

func _ready() -> void:
  bomb_detection_area.body_exited.connect(func(b):
    set_deferred('disabled', false)
    bomb_detection_box.set_deferred('disabled', true))
