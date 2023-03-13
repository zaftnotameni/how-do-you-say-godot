extends Node2D

var power := 2
var countdown := 3

signal on_explosion_started()

func start_explosion():
  on_explosion_started.emit()
