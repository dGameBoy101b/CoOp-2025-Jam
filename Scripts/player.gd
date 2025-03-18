extends CharacterBody2D
class_name Player

@onready var camera: Camera2D = $Camera2D
@onready var left_wall_raycast: RayCast2D = $LeftWallRaycast
@onready var right_wall_raycast: RayCast2D = $RightWallRaycast

@export var health = 100
@export var speed = 300
@export var acceleration = 0.2
@export var jump_power = 300
@export var dash_power = 600
@export var wall_gravity_reduction = 0.5
@export var gravity = 980
var flipped = false

@export var dash = true
@export var wall_jump = false

var movement: float = 0.0

func _physics_process(delta: float) -> void:
	if not is_on_floor() or not is_on_wall():
		velocity.y += gravity * delta * -up_direction.y
	elif is_on_wall_only() and wall_jump:
		velocity.y += gravity * wall_gravity_reduction * delta * -up_direction.y

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_power * up_direction.y
		elif is_on_wall() and wall_jump:
			if left_wall_raycast.is_colliding():
				velocity.y = jump_power * up_direction.y
				velocity.x += jump_power
			elif right_wall_raycast.is_colliding():
				velocity.y = jump_power * up_direction.y
				velocity.x += -jump_power

	var direction
	if !flipped:
		direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("jump", "down"))
		rotation = lerpf(rotation, deg_to_rad(0), 0.05)
	else:
		direction = Vector2(-Input.get_axis("left", "right"), Input.get_axis("jump", "down"))
		rotation = lerpf(rotation, deg_to_rad(180), 0.05)
	
	movement = lerpf(movement, direction.x * speed, 0.2)
	velocity.x = movement
	
	if Input.is_action_just_pressed("dash"):
		velocity += direction * dash_power

	move_and_slide()

func flip(is_flipped: bool):
	if !is_flipped:
		up_direction = Vector2.DOWN
		flipped = true
	else:
		up_direction = Vector2.UP
		flipped = false

func take_damage(amount: int):
	health -= amount
	if health > 0:
		die()

func die():
	#idk what we should do when he dies yet
	pass
