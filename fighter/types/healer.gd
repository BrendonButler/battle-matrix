extends Fighter

class_name Healer

func _init() -> void:
	type = FighterType.HEALER
	max_health = 12.0
	health = max_health
	attack = 0
	defense = 0
	speed = 6
	skill_priority = 1
	skill_value = .2

@warning_ignore("unused_parameter")
func act(allies: Array[Fighter], enemies: Array[Fighter]) -> void:
	for ally in allies:
		if ally.is_alive:
			ally.take_damage(-ally.health * skill_value)
