extends Control

@onready var time_label = $time_label
var start_time
var enemy_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = Time.get_unix_time_from_system()
	enemy_manager = get_tree().get_nodes_in_group("enemy_manager")[0]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemy_manager.game_ended:
		visible = true
		time_label.text = "Your final time is: " + String.num(enemy_manager.time_ended - start_time, 2)
