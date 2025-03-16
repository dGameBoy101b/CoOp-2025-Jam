class_name AttackHitbox extends Area2D

## Damage dealt to each target.
@export var damage : float = 1

## Maximum number of targets this can hit before disabling itself.
@export var max_targets : int = 1

@export var enabled : bool:
	get:
		return self.monitoring
	set(value):
		self.monitoring = value
		if value:
			self.hit_targets.clear()
		elif len(self.hit_targets) < 1:
			self.miss.emit()

signal hit(count: int)
signal miss()

var hit_targets : Array[Node2D] = []

func attack(target: Node2D) -> bool:
	if self.hit_targets.has(target):
		print("already hit target")
		return false
	self.hit_targets.append(target)
	var hit_count = len(self.hit_targets)
	self.hit.emit(hit_count)
	if hit_count >= self.max_targets:
		self.enabled = false
		print("hit max targets")
	print("hit target")
	return true

func _on_body_entered(body: Node2D) -> void:
	self.attack(body)

func _notification(what: int) -> void:
	if what == NOTIFICATION_DISABLED:
		self.enabled = false
	elif what == NOTIFICATION_ENABLED:
		self.enabled = true
