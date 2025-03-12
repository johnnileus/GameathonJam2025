extends Node

@onready var state_machine = get_parent()
@onready var enemy = state_machine.get_parent()
@onready var player = get_tree().get_nodes_in_group("player")[0]


func enter():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func exit():
	pass
