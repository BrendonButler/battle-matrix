extends Fighter

class_name Attacker

func _ready() -> void:
	type = FighterType.ATTACKER
	max_health = 12.0
	health = max_health
	speed = 6
	skill_priority = 3
	skill_value = 6
