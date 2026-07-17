extends Fighter

class_name Defender

func _init() -> void:
	type = FighterType.DEFENDER
	max_health = 16.0
	health = max_health
	attack = 2
	defense = 4
	speed = 2
	skill_priority = 2
	skill_value = 6
