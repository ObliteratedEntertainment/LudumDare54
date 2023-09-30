extends Node2D

@onready var requirements = $StatRequiements
@onready var icon = $Icon
@onready var rewards = $Rewards

@export var region:Region.RegionType

func get_requirements() -> Array:
	return requirements.get_children()

func get_rewards() -> Array:
	return rewards.get_children()
