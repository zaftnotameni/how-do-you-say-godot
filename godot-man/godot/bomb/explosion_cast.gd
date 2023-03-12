extends RayCast2D

@export var power : int = 2

@onready var level := find_parent('level')

func _ready() -> void:
  target_position.y = power * XX.tile_size
  get_tree().create_timer(3).timeout.connect(func(): queue_free())

func _physics_process(delta: float) -> void:
  if is_colliding():
    explode(get_collider())

func explode(thing) -> void:
  if (thing is TileMap): explode_tile_map(thing)

func explode_tile_map(tiles : TileMap) -> void:
  var coords := tiles.get_coords_for_body_rid(get_collider_rid())
  tiles.set_cell(0, coords)
  queue_free()
