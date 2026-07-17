extends Node2D

class_name Fighter

enum FighterType { ATTACKER, DEFENDER, HEALER, UNDEFINED }

var type: FighterType = FighterType.UNDEFINED
var max_health: float = 0.0
var health: float = 0.0:
	set(value): health = clamp(value, 0.0, max_health)
var attack: float = 0.0
var defense: float = 0.0
var speed: float = 0.0
var skill_priority: int = 0
var skill_value: float = 0.0
var is_alive: bool:
	get: return health > 0

func take_damage(amount: float) -> void:
	health -= amount

@warning_ignore("unused_parameter")
func act(allies: Array[Fighter], enemies: Array[Fighter]) -> void:
	var target = enemies.filter(func(enemy): return enemy.is_alive).pick_random()
	var damage = attack * (100.0 / (100.0 + target.defense))
	
	target.take_damage(damage)
