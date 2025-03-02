extends CharacterBody3D

@export var run_speed = 10.0
@export var jump_force = 6.0
@export var gravity = 9.8

@export var sensitivity = .001

var walkSpeed = 1.6
var runSpeed = 5
var crouchSpeed = .9
var moving = false

enum states {
	idle,
	walking,
	running,
	crouching
}
var stateAnims = {
	states.idle: "04_Idle",
	states.walking: "02_walk",
	states.running: "01_Run",
	states.crouching: "03_creep"
}
var state = states.idle
@onready var camera_pivot_y = $camera_pivot_y
@onready var camera_pivot_x = $camera_pivot_y/camera_pivot_x
@onready var camera = $camera_pivot_y/camera_pivot_x/camera
@onready var model = $model
@onready var wolf = $model/wolf
@onready var anim = wolf.animation_player

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera_pivot_y.rotate_y(-event.relative.x * sensitivity)
		camera_pivot_x.rotate_x(-event.relative.y * sensitivity)
		camera_pivot_x.rotation.x = clamp(camera_pivot_x.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func process_movement(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 3
	
	var speed
	var inputting = false
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (camera_pivot_y.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction != Vector3.ZERO:
		moving = true
	else:
		moving = false
		
	if Input.is_action_pressed("run"):
		speed = runSpeed
		state = states.running
		inputting = true
	elif Input.is_action_pressed("crouch"):
		speed = crouchSpeed
		state = states.crouching
		inputting = true
		
	else:
		speed = walkSpeed
		state = states.walking
	

		
		

	
	if moving:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		# Correct way to rotate the model smoothly
		var target_rotation = atan2(-direction.x, -direction.z)  # Calculate target Y rotation
		model.rotation.y = lerp_angle(model.rotation.y, target_rotation, 0.18)  # Smooth rotation

	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 15.0)
		velocity.z = lerp(velocity.z, 0.0, delta * 15.0)
		if not inputting:
			state = states.idle
	
	anim.play(stateAnims[state])
	if not moving and state == states.crouching:
		anim.speed_scale = 0
	else:
		anim.speed_scale = 1
	

func _physics_process(delta):
	process_movement(delta)

	move_and_slide()
