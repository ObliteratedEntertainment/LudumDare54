extends Sprite2D

signal scene_hidden
signal scene_showing

@onready var animation_player = $AnimationPlayer


var obscuring := false

func hide_scene():
	animation_player.play("swipe_hide")

func hide_finished():
	obscuring = true
	scene_hidden.emit()

func show_scene():
	animation_player.play("swipe_show")

func show_finished():
	obscuring = false
	scene_showing.emit()
