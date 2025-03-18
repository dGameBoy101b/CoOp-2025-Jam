extends Node2D
class_name Level

@export var player: Player
@export var light_world: TileMapLayer
@export var dark_world: TileMapLayer

var is_flipped = false

func world_flip():
	if is_flipped:
		is_flipped = false
		light_world.enabled = false
		dark_world.enabled = true
	else:
		is_flipped = true
		light_world.enabled = true
		dark_world.enabled = false
	player.flip(is_flipped)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("flip"):
		world_flip()
