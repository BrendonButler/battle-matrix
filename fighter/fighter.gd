extends Node2D

class_name Fighter

enum FighterType { ATTACKER, DEFENDER, HEALER, UNDEFINED }

var type: FighterType = FighterType.UNDEFINED
var max_health: float = 0.0
var health: float = 0.0:
	set(value): health = clamp(value, 0.0, max_health)
var speed: float = 0.0
var skill_priority: int = 0
var skill_value: float = 0.0
var is_alive: bool:
	get: return health > 0

func act(fighter: Fighter) -> void:
	print("This fighter is ", is_alive, " and the target is ", fighter.is_alive)
