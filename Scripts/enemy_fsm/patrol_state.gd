extends "res://Scripts/enemy_fsm/base_state.gd"

func enter():
	print("entered patrol")

func update(_delta):
	if randi() % 50 == 0:
		state_machine.transition_to("chase")
