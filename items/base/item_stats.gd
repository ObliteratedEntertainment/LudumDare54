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
	BOOMERANG,
	NUNCHUCK,
	SHIELD,
	ARMOR,
	AMULET,
	STAFF,
	FISHING_ROD,
	FOOD,
	SWORD
	
}

@export var stat: Stat
@export var amount:int
