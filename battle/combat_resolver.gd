class_name CombatResolver

enum CombatResult { ALLY_WIN, ENEMY_WIN, UNDECIDED }

static var tiebreakers: Dictionary = {}

static func resolve_battle(allies: Array[Fighter], enemies: Array[Fighter]) -> CombatResult:
	var all_fighters: Array[Fighter] = allies.duplicate()
	allies.append_array(enemies)

	for fighter in all_fighters:
		tiebreakers[fighter] = randf()
	
	all_fighters.sort_custom(func(fighter1: Fighter, fighter2: Fighter) -> bool:
		if fighter1.skill_priority != fighter2.skill_priority:
			return fighter1.skill_priority < fighter2.skill_priority
		if fighter1.speed != fighter2.speed:
			return fighter1.speed > fighter2.speed
		return tiebreakers[fighter1] > tiebreakers[fighter2]
	)
	
	for fighter in all_fighters:
		if fighter.is_alive:
			fighter.act(allies, enemies)
			
			if enemies.all(func(enemy: Fighter): return !enemy.is_alive):
				return CombatResult.ALLY_WIN
			elif allies.all(func(ally: Fighter): return !ally.is_alive):
				return CombatResult.ENEMY_WIN
	
	return CombatResult.UNDECIDED
