extends Control

var alertness
@onready var arrow = $arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	arrow.material.set_shader_parameter("alert_progress", alertness)
