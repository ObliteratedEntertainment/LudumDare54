extends Control

signal scene_leaving(scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.change_track(2)

