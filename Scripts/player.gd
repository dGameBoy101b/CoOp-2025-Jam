extends CharacterBody2D

@export var speed = 400
@export var acceleration = 0.35
@export var jump_strength = 800
@export var gravity = 1500
@export var fall_multiplier = 1.5

func _physics_process(delta: float) -> void:
	var movement_input = (Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left"))
	velocity.x = lerpf(velocity.x, movement_input * speed, acceleration)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_strength
	
	if !is_on_floor():
		if velocity.y > 0:
			velocity.y += gravity * delta * fall_multiplier
		else:
			velocity.y += gravity * delta
	
	move_and_slide()
