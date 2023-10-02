extends Control

signal scene_leaving(scene)


func _on_back_pressed():
	scene_leaving.emit(GameManager.Scenes.MAIN_MENU)


func _on_main_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value / 100.0))
