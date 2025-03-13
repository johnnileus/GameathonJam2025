extends Node3D

@onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("slash")

func kill_self():
	queue_free()


func _on_area_3d_body_entered(body):
	if body in get_tree().get_nodes_in_group("enemy"):
		
		body.die()
