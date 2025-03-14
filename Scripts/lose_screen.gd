extends Control

@onready var time_label = $time_label
@onready var player: Node3D = get_tree().get_first_node_in_group("player")

var start_time
var enemy_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = Time.get_unix_time_from_system()
	enemy_manager = get_tree().get_nodes_in_group("enemy_manager")[0]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.is_dead:
		visible = true
		time_label.text = "you lose sorry :(, press R to replay"
