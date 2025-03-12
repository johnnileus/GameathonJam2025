extends Node3D

@onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("slash")

func kill_self():
	queue_free()
