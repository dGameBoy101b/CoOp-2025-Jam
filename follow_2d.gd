extends Camera2D

@export var target: Node2D

func _process(delta: float) -> void:
	self.global_position = self.target.global_position
