extends Control


signal scene_leaving(scene)


func _on_play_pressed():
	scene_leaving.emit(GameManager.Scenes.SHOP)


func _on_settings_pressed():
	scene_leaving.emit(GameManager.Scenes.SETTINGS)
