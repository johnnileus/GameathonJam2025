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


#TODO increase alert from movement based on distance
func update(delta):
	if !enemy.is_dead:
		var result = enemy.is_player_visible()
		var alert_increased = false
		
		var playerState = player.state
		var dist_to_player = enemy.global_position.distance_to(player.global_position)
		
		if result:
			enemy.increase_alert(delta, enemy.spotted_alert_rate)
			alert_increased = true
		if playerState == player.states.running && dist_to_player < player.current_ball_size.x:
			enemy.increase_alert(delta, enemy.running_alert_rate)
			alert_increased = true
		if playerState == player.states.walking && dist_to_player < player.current_ball_size.x:
			enemy.increase_alert(delta, enemy.walking_alert_rate)
			alert_increased = true
			
		if !alert_increased:
			enemy.decrease_alert(delta, enemy.alert_decay)
			
			
		if last_changed + change_delay < Time.get_unix_time_from_system():
			last_changed = Time.get_unix_time_from_system()
			enemy.update_target_pos(get_new_target())
			


		if enemy.alertness == 1:
			state_machine.transition_to("chase")
			
		
