extends CharacterBody3D

@onready var state_machine = $state_machine
var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]



func raycast_to_player():
	var space_state = get_world_3d().direct_space_state
	var origin = get_node("head").global_position
	var end = player.get_node("head").global_position

	DebugDraw3D.draw_line(origin, end, Color(1,0,0))
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.exclude = [self]
	query.set_collision_mask(1 << 1 | 1 << 0)	
	var result = space_state.intersect_ray(query)
	return result

func _process(delta):
	var result = raycast_to_player()
	if result:
		print(result.collider.name)
	else:
		print("not hit")
