extends Node2D

@onready var player_body : CharacterBody2D = find_parent('player_body')
@onready var player_input := player_body.find_child('player_input')
@onready var player_stats := player_body.find_child('player_stats')
@onready var placed_bombs := find_parent('level').find_child('placed_bombs')

const BombScene := preload('res://godot/bomb/bomb.tscn')

var requested_bomb_placement := LastCurrent.new().of(false)

func can_place_bombs() -> bool:
  print(placed_bombs.get_child_count())
  return placed_bombs.get_child_count() <= 0

func place_bomb():
  var bomb_scene := BombScene.instantiate()
  bomb_scene.global_position = player_body.global_position
  placed_bombs.add_child(bomb_scene)
  requested_bomb_placement.change(false)

func do_physics(delta: float) -> void:
  requested_bomb_placement.change_if_was_false(player_input.input_bombs())
  if (requested_bomb_placement.current and can_place_bombs()):
    place_bomb()
