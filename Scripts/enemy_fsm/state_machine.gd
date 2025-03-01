extends Node

var current_state = null

func _ready():
	if get_child_count() > 0:
		current_state = get_child(0)  # Start with the first state
		current_state.enter()

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func transition_to(new_state_name):
	var new_state = get_node_or_null(new_state_name)
	if new_state:
		if current_state:
			current_state.exit()
		current_state = new_state
		current_state.enter()
