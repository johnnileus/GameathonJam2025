extends "res://Scripts/enemy_fsm/base_state.gd"

var time_entered
var last_spotted
var last_hidden
var time_to_patrol = 2.0
var time_to_kill = 1.5


func enter():
	print("entered chase")
	time_entered = Time.get_unix_time_from_system()
	last_spotted = time_entered
	last_hidden = time_entered

#func look_at_direction(dir):
	#target_rot = -Vector2(dir.x, dir.z).angle() + PI/2
#
#func move_along_path(delta):
	#var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	#
	#look_at_direction(direction)

func update(_delta):
	if !enemy.is_dead:
		var cur_time = Time.get_unix_time_from_system()
		
		var result = enemy.is_player_visible()
		var visible = enemy.raycast_to_player()
		enemy.rot_blocked = false
		if result:
			last_spotted = cur_time
			
		else:
			last_hidden = cur_time
			
		if visible:
			enemy.rot_blocked = true
			var dir = player.global_position - enemy.global_position
			var target_rot = -Vector2(dir.x, dir.z).angle() + PI/2
			enemy.model.global_rotation.y = lerp_angle(enemy.model.global_rotation.y, target_rot, 2 * _delta)
			
		if cur_time > last_hidden + time_to_kill:
			player.die()
		
		if cur_time > last_spotted + time_to_patrol:
			state_machine.transition_to("patrol")
