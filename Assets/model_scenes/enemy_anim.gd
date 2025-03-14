extends Node3D


@onready var anim = $AnimationPlayer

func play_anim(name):
	anim.play(name)
