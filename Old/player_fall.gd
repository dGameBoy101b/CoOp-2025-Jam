extends Node2D

@export var body : CharacterBody2D
@export var terminal_velocity : float

func calculate_velocity(delta: float) -> Vector2:
	var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
	var down: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
	var current = self.body.velocity
	var vertical = gravity * delta + current.dot(down)
	if self.terminal_velocity != 0:
		var max_vertical = self.terminal_velocity if self.terminal_velocity > 0 else -self.terminal_velocity
		var min_vertical = -self.terminal_velocity if self.terminal_velocity > 0 else self.terminal_velocity
		vertical = clamp(vertical, min_vertical, max_vertical)
	return current - current.project(down) + vertical * down

func _physics_process(delta: float) -> void:
	self.body.velocity = self.calculate_velocity(delta)
	self.body.move_and_slide()
