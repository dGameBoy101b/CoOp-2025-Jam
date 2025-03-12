extends Node2D

@export var left_input : StringName
@export var right_input : StringName
@export var body : CharacterBody2D
@export var speed : float

func get_input() -> float:
	return Input.get_axis(self.left_input, self.right_input)

func get_velocity() -> Vector2:
	var current = self.body.velocity
	var input = self.get_input()
	return Vector2(input * self.speed, current.y)

func _physics_process(delta: float) -> void:
	self.body.velocity = self.get_velocity()
