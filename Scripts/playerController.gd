extends CharacterBody3D

@export var speed = 5.0
@export var run_speed = 10.0
@export var jump_force = 6.0
@export var gravity = 9.8

var is_running = false



func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("right"):
		direction += transform.basis.x

	if direction.length() > 0:
		direction = direction.normalized()
		velocity.x = direction.x * target_speed
		velocity.z = direction.z * target_speed
		rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), delta * 5)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		velocity.z = move_toward(velocity.z, 0, speed * delta)

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()
