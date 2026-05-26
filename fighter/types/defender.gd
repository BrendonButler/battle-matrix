extends Fighter

class_name Defender

func _ready() -> void:
	type = FighterType.DEFENDER
	max_health = 16.0
	health = max_health
	speed = 2
	skill_priority = 2
	skill_value = 6
