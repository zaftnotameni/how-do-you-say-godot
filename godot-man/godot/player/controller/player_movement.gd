extends Node2D

@onready var player_body : CharacterBody2D = find_parent('player_body')
@onready var player_input := player_body.find_child('player_input')
@onready var player_stats := player_body.find_child('player_stats')


var player_index
var input_vector := LastCurrent.new().of(Vector2.ZERO)
var velocity := LastCurrent.new().of(Vector2.ZERO)

func process_input():
  input_vector.change(player_input.input_vector())

func do_physics(delta : float):
  process_input()
  player_body.velocity = input_vector.current * player_stats.speed
  player_body.move_and_slide()
  velocity.change(player_body.velocity)
