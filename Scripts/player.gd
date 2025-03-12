extends CharacterBody2D

@export var speed = 350
@export var jump_strength = 700
@export var gravity = 980

func _physics_process(delta: float) -> void:
	var movement_input = (Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left"))
	velocity.x = movement_input * speed
	
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y -= jump_strength
	
	if !is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
