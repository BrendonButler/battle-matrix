extends Fighter

class_name Attacker

func _init() -> void:
	type = FighterType.ATTACKER
	max_health = 12.0
	health = max_health
	attack = 6
	defense = 2
	speed = 6
	skill_priority = 3
	skill_value = 6
