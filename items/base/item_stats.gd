extends Node
class_name ItemStats

enum Stat {
	ATTACK,
	DEFENSE,
	HOLY,
	
	RESTORE_HEALTH,
	RESTORE_MANA,
	
	KEY,
	FLAG,
	PILL,
	BOOMERANG
	
}

@export var stat: Stat
@export var amount:int
