extends CharacterBody3D

@onready var state_machine = $state_machine
@onready var alert_mesh = $alert_icon/alert_mesh

@onready var nav_agent = $NavigationAgent3D
@onready var map = get_tree().get_first_node_in_group("map").get_navigation_mesh()
@onready var player: Node3D = get_tree().get_first_node_in_group("player")

@onready var model = $model
@onready var soldier = $model/soldier

@export var sight_angle = 40

var path : Array = []
var current_target_index : int = 0
var speed : float = .3

var alertness = 0
var spotted_alert_rate = 1.5
var running_alert_rate = 1.2
var walking_alert_rate = .6
var alert_decay = .3
var alerted = false
var rot_blocked = false

var target_rot = 0.0

var is_dead = false

func _ready():
	update_target_pos(player.global_position)

func increase_alert(delta, amt):
	alertness += amt * delta
	if alertness > 1:
		alertness = 1
func decrease_alert(delta, amt):
	alertness -= amt * delta
	if alertness < 0:
		alertness = 0
func raycast_to_player():
	var space_state = get_world_3d().direct_space_state
	var origin = get_node("head").global_position
	var end = player.get_node("head").global_position

	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.exclude = [self]
	query.set_collision_mask(1 << 1 | 1 << 0)	
	var result = space_state.intersect_ray(query)
	if result and result.collider.name == "Player":
		
		return true
	else:
		
		return false

func update_target_pos(pos):
	nav_agent.target_position = pos

func is_player_visible():
	var facing = model.global_rotation.y
	var vec_to_player = player.global_position - global_position
	var dir = Vector2(vec_to_player.x, vec_to_player.z).angle()
	var diff = facing + dir - PI/2
	var visible = raycast_to_player()
	
	var origin = get_node("head").global_position
	var end = player.get_node("head").global_position
	
	if abs(diff) < deg_to_rad(sight_angle):
		#DebugDraw3D.draw_line(origin, end, Color(0,1,0))
		return visible
	else:
		#DebugDraw3D.draw_line(origin, end, Color(1,0,0))
		return false


func look_at_direction(dir):
	target_rot = -Vector2(dir.x, dir.z).angle() + PI/2

func move_along_path(delta):
	var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	
	look_at_direction(direction)
	
	velocity = velocity.lerp(direction * speed, 1 * delta) + Vector3.DOWN*9.81*delta


func die():
	if !is_dead:
		is_dead = true
		play_anim("death")
		get_parent().killed_enemies+=1
		alert_mesh.visible = false

func manage_anim():
	if rot_blocked:
		play_anim("pistol_idle")
	else:
		play_anim("pistol_walk")

func play_anim(animation):
	soldier.play_anim(animation)
	
func _process(delta):
	
	if !is_dead:
		alert_mesh.alertness = alertness
		if !rot_blocked:
			model.global_rotation.y = lerp_angle(model.global_rotation.y, target_rot, 1 * delta)
			move_along_path(delta)
		else:
			speed = 0;
		manage_anim()
		

		move_and_slide()
