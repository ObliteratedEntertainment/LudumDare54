extends Control

@onready var animation_player = $AnimationPlayer

@onready var success = $Success
@onready var failure = $Failure

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#GameManager.quest_accepted.connect(_on_quest_result)


func _on_quest_result(result: bool):
	success.visible = result
	failure.visible = not result
	
	animation_player.play("slide")


func _on_accept_pressed():
	animation_player.play_backwards("slide")
