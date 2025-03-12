extends Node3D

var total_enemies
var killed_enemies = 0

var game_ended = false
var time_ended
# Called when the node enters the scene tree for the first time.
func _ready():
	total_enemies = get_child_count()

func _process(delta):
	if killed_enemies == total_enemies and game_ended == false:
		print("yay win")
		game_ended = true
		time_ended = Time.get_unix_time_from_system()
