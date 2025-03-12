extends "res://Scripts/enemy_fsm/base_state.gd"

var time_entered
var last_spotted
var time_to_patrol = 2.0


func enter():
	print("entered chase")
	time_entered = Time.get_unix_time_from_system()
	last_spotted = time_entered

	

func update(_delta):
	var cur_time = Time.get_unix_time_from_system()
	
	var result = enemy.is_player_visible()
	if result:
		last_spotted = cur_time
	
	if cur_time > last_spotted + time_to_patrol:
		state_machine.transition_to("patrol")
