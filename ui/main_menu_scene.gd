extends Control

signal scene_leaving()


func _on_play_pressed():
	scene_leaving.emit()
