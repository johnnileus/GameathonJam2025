extends Control

@onready var score_label = $score_label
@onready var time_label = $time_label

var start_time
var enemy_manager
var total_enemies
var end_time

# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = Time.get_unix_time_from_system()
	enemy_manager = get_tree().get_nodes_in_group("enemy_manager")[0]
	total_enemies = enemy_manager.total_enemies


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemy_manager.game_ended:
		time_label.text = ""
		score_label.text = ""
	else:
		time_label.text = "Time taken: " +String.num(Time.get_unix_time_from_system() - start_time, 2)
		score_label.text = "Enemies killed:" +str(enemy_manager.killed_enemies)+"/"+str(total_enemies)
