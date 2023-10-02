extends Control

signal scene_leaving(scene)

@onready var path_animator = $Path2D/PathFollow2D/PathAnimator

# Called when the node enters the scene tree for the first time.
func _ready():
	path_animator.play("path_progress")


func _on_accept_pressed():
	
	var game_over = false
	
	if GameManager.quest_successful:
		game_over = GameManager.character_departed()
	
	if not game_over:
		ItemManager.active_inventory.clear()
		scene_leaving.emit(GameManager.Scenes.SHOP)
	
	
