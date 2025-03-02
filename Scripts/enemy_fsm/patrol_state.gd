extends "res://Scripts/enemy_fsm/base_state.gd"

func enter():
	print("entered patrol")

func update(delta):
	var result = enemy.raycast_to_player()
	if result:
		enemy.increase_alert(delta)
	else:
		enemy.decrease_alert(delta)
		
	if enemy.alertness == 1:
		state_machine.transition_to("chase")
		
	print(enemy.alertness)
