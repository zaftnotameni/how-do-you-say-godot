extends Node


const tile_size := 32
const tile_size_vector := Vector2(32, 32)
const half_tile_size := 16
const half_tile_size_vector := Vector2(16, 16)


func snap_to_grid(p : Vector2) -> Vector2:
  return (p + XX.half_tile_size_vector).snapped(XX.tile_size_vector) - XX.half_tile_size_vector
