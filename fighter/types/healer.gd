extends Fighter

class_name Healer

func _ready() -> void:
	type = FighterType.HEALER
	max_health = 12.0
	health = max_health
	speed = 6
	skill_priority = 1
	skill_value = 6
