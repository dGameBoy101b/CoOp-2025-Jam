extends Node2D

@export var body : CharacterBody2D
@export var shape : CollisionShape2D
@export var speed : float

var direction : float = 1

func hit_edge(delta: float) -> bool:
	var motion = -self.body.up_direction * self.body.safe_margin
	var offset = (self.speed * delta + self.shape.shape.get_rect().size.x) * self.direction * Vector2.RIGHT
	var from = self.body.transform.translated(offset)
	return not self.body.test_move(from, motion, null, self.body.safe_margin)

func calculate_velocity(delta: float) -> Vector2:
	if not self.body.is_on_floor():
		return self.body.velocity
	if self.body.is_on_wall() or self.hit_edge(delta):
		self.direction *= -1
		if self.body.is_on_wall():
			print("hit wall")
		else:
			print("hit edge")
	return Vector2(self.speed * self.direction, self.body.velocity.y)

func _physics_process(delta: float) -> void:
	self.body.velocity = self.calculate_velocity(delta)
