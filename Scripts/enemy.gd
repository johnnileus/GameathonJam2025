extends CharacterBody3D

@onready var state_machine = $state_machine
@onready var alert_mesh = $alert_icon/alert_mesh

var player

var alertness = 0
var alert_rate = .5
var alert_decay = .1
var alerted = false

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func increase_alert(delta):
	alertness += alert_rate * delta
	if alertness > 1:
		alertness = 1
	
func decrease_alert(delta):
	alertness -= alert_decay * delta
	if alertness < 0:
		alertness = 0

func raycast_to_player():
	var space_state = get_world_3d().direct_space_state
	var origin = get_node("head").global_position
	var end = player.get_node("head").global_position

	DebugDraw3D.draw_line(origin, end, Color(1,0,0))
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.exclude = [self]
	query.set_collision_mask(1 << 1 | 1 << 0)	
	var result = space_state.intersect_ray(query)

	if result and result.collider.name == "Player":
		return true
	else:
		return false

func _process(delta):
	alert_mesh.alertness = alertness
