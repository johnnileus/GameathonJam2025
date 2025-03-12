extends Control

const arrow = preload("res://Scenes/arrow.tscn")
var enemies
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#terrible
func delete_children():
	for child in get_children():
		child.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemies = get_tree().get_nodes_in_group("enemy")
	player = get_tree().get_nodes_in_group("player")[0]
	var camera = player.camera
	delete_children()
	
	for enemy in enemies:
		var vec_diff = (player.global_position - enemy.global_position).normalized()
		var vec_angle = Vector2(vec_diff.x, vec_diff.z).angle()
		var camera_rot = player.camera.global_rotation
		
		var new_arrow = arrow.instantiate()
		new_arrow.rotation = vec_angle + camera_rot.y - PI/2
		var arrow_mesh = new_arrow.get_node("arrow")
		arrow_mesh.material.set_shader_parameter("alert_progress", enemy.alertness)


		add_child(new_arrow)
		
	
