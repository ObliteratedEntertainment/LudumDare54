extends Control

signal scene_leaving()

@onready var path_animator = $Path2D/PathFollow2D/PathAnimator

# Called when the node enters the scene tree for the first time.
func _ready():
	path_animator.play("path_progress")


func _on_accept_pressed():
	scene_leaving.emit()
	
	ItemManager.active_inventory.clear()
