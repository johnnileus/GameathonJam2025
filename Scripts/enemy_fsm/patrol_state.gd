extends "res://Scripts/enemy_fsm/base_state.gd"

var last_changed = 0.0
var change_delay = 12.5

var change_distance = 5.0

func enter():
	print("entered patrol")

func get_new_target():
	var angle = randf() * 2 * PI
	var offset = Vector2(cos(angle), sin(angle)) * change_distance
	return enemy.global_position + Vector3(offset.x, 0, offset.y)

func update(delta):
	var result = enemy.is_player_visible()
	if result:
		
		enemy.increase_alert(delta)
	else:
		enemy.decrease_alert(delta)
		
	if last_changed + change_delay < Time.get_unix_time_from_system():
		last_changed = Time.get_unix_time_from_system()
		
		enemy.update_target_pos(get_new_target())
		
		
	if enemy.alertness == 1:
		state_machine.transition_to("chase")
		
		
