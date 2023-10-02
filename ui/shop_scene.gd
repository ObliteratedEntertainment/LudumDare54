extends Control

signal scene_leaving(scene)


func _ready():
	GameManager.character_mission_start.connect(_on_character_battle)
	
func _on_character_battle():
	scene_leaving.emit(GameManager.Scenes.BATTLE)
