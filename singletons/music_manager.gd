extends Node2D

# Time to fade between tracks
const swap_time = 1.0

@onready var shopkeeper = $Shopkeeper
@onready var deep_forest = $DeepForest
@onready var challenge = $Challenge

@onready var tracks = [shopkeeper, deep_forest, challenge]

var time_counter := 0
var current_track:AudioStreamPlayer
var last_track:AudioStreamPlayer

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	for t in tracks:
		t.process_mode = Node.PROCESS_MODE_ALWAYS

func change_track(track_num:int):
	time_counter = 0
	last_track = current_track
	current_track = tracks[track_num]
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	time_counter += delta
	if current_track == null:
		return
	if !current_track.playing:
		current_track.playing = true
	if time_counter >= swap_time:
		if last_track != null:
			last_track.stop()
		current_track.volume_db = 0
		process_mode = Node.PROCESS_MODE_DISABLED
		return
	if last_track != null:
		last_track.volume_db = linear_to_db(lerp(1, 0, time_counter/swap_time))
	current_track.volume_db = linear_to_db(lerp(0, 1, time_counter/swap_time))
