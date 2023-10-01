extends Sprite2D

const town   = preload("res://sprites/haul_town.png")
const forest = preload("res://sprites/deep_woods.png")
const mountain = preload("res://sprites/mt_smokey.png")
const swamp = preload("res://sprites/skull_swamp.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	match GameManager.current_quest.region:
		Region.RegionType.FOREST:
			texture = forest
		Region.RegionType.TOWN:
			texture = town
		Region.RegionType.MOUNTAIN:
			texture = mountain
		Region.RegionType.SWAMP:
			texture = swamp

