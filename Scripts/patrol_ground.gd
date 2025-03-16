extends CharacterBody2D

@export var shape : CollisionShape2D
@export var speed : float
@export var gravity : float

var _direction : float = 1

## The direction of gravity.
var down: Vector2:
	get:
		return -self.up_direction.normalized()

## The direction this is facing.
var forward: Vector2:
	get:
		return (self.up_direction.rotated(PI/2) * self._direction).normalized()

func hit_edge(delta_time: float) -> bool:
	var motion = self.down * self.safe_margin
	var offset = (self.speed * delta_time + self.shape.shape.get_rect().size.x) * self.forward
	var from = self.transform.translated(offset)
	return not self.test_move(from, motion, null, self.safe_margin)

func calculate_velocity(delta_time: float) -> Vector2:
	#patrolling
	if self.is_on_floor():
	if self.is_on_wall() or self.hit_edge(delta_time):
		self._direction *= -1
		if self.is_on_wall():
			print("hit wall")
		else:
			print("hit edge")
	return self.speed * self.forward + self.velocity.project(self.down)

	#falling
	return self.gravity * delta_time * self.down + self.velocity

func _physics_process(delta_time: float) -> void:
	self.velocity = self.calculate_velocity(delta_time)
	self.move_and_slide()
