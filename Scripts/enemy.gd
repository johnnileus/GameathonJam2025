extends CharacterBody3D

@onready var state_machine = $state_machine
var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func raycast_to_player():
	var space_state = get_world_3d().direct_space_state
	var origin = global_position
	var end = player.global_position
	
	var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(origin, end))
	return result

func _physics_process(delta):
	if raycast_to_player():
		print("hit")
	else:
		print("not hit")
