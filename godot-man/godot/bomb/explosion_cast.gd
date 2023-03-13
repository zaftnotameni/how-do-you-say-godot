extends RayCast2D

@onready var level := find_parent('level')
@onready var explosion := find_parent('*explosion*')
@onready var explosion_line := explosion.find_child('explosion_%s' % name)
@onready var power : int = explosion.power
@onready var countdown : int = explosion.countdown

var exploded = false

func _ready() -> void:
  target_position.y = power * XX.tile_size + XX.half_tile_size
  each_explosion_line(func(e : Node2D): e.set_power(power))
  each_explosion_line(func(e : Node2D): e.hide())
  explosion.on_explosion_started.connect(start_explosion)
  explosion.on_explosion_cleanup.connect(cleanup_explosion)

func cleanup_explosion() -> void:
  queue_free()
  each_explosion_line(func(e : Node2D): e.queue_free())

func start_explosion():
  exploded = true
  each_explosion_line(func(e : Node2D): e.show_explosion())


func each_explosion_line(fn : Callable) -> void:
  fn.call(explosion_line)

func _physics_process(delta: float) -> void:
  var collider = get_collider()
  if is_colliding():
    if (collider is TileMap): each_explosion_line(func(e): e.stop_explosion_at(get_collision_point()))
    if (exploded): explode(collider)

func explode(thing) -> void:
  if (thing is TileMap): explode_tile_map(thing)

func explode_tile_map(tiles : TileMap) -> void:
  var coords := tiles.get_coords_for_body_rid(get_collider_rid())
  tiles.set_cell(2, coords)
  queue_free()
