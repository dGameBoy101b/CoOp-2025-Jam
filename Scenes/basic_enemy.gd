extends CharacterBody2D

@onready var edge_check_left = $EdgeCheckLeft
@onready var edge_check_right = $EdgeCheckRight

@export var speed = 200
@export var gravity = 980
@export var current_direction = -1

func _physics_process(delta: float) -> void:
	if current_direction == -1:
		if edge_check_left.is_colliding():
			velocity.x = -1 * speed
		else:
			current_direction = 1
	elif current_direction == 1:
		if edge_check_right.is_colliding():
			velocity.x = 1 * speed
		else:
			current_direction = -1
	
	if !is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
