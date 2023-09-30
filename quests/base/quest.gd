extends Node2D
class_name Quest

@onready var icon = $Icon
@onready var requirements = $StatRequiements
@onready var lore = $Lore
@onready var success = $Rewards/Success
@onready var failure = $Rewards/Success

@export var region:Region.RegionType

func get_requirements() -> Array:
	return requirements.get_children()

func get_success_rewards() -> Array:
	return success.get_children()
	
func get_failure_rewards() -> Array:
	return failure.get_children()
