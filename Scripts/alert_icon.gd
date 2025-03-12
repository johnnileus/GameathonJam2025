extends MeshInstance3D

var player
var alertness = 0.0

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	
func _process(delta):
	look_at(player.position)
	material_override.set_shader_parameter("alert_progress", alertness)
