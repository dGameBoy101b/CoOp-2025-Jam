extends Node2D

@export var jump_input : StringName
@export var body : CharacterBody2D
@export var power : float

func get_input() -> bool:
	return Input.is_action_just_pressed(self.jump_input)

func get_velocity() -> Vector2:
	var current = self.body.velocity
	var input = self.get_input()
	if input && self.body.is_on_floor():
		current += self.body.up_direction.normalized() * self.power
	return current

func _physics_process(delta: float) -> void:
	self.body.velocity = self.get_velocity()
