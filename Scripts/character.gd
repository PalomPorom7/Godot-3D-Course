extends CharacterBody3D


const JUMP_VELOCITY = 4.5

@export var _walking_speed : float = 1
@export var _acceleration : float = 2
@export var _deceleration : float = 4
var _xz_velocity : Vector3

@onready var _animation : AnimationTree = $AnimationTree

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _direction : Vector3

func move(direction : Vector3):
	_direction = direction

func _physics_process(delta):
	# Copy the character's x and z velocity to isolate from y.
	_xz_velocity = Vector3(velocity.x, 0, velocity.z)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Apply movement input to the xz velocity
	if _direction:
		_xz_velocity = _xz_velocity.move_toward(_direction * _walking_speed, _acceleration * delta)
	else:
		_xz_velocity = _xz_velocity.move_toward(Vector3.ZERO, _deceleration * delta)
	
	_animation.set("parameters/Locomotion/blend_position", _xz_velocity.length() / _walking_speed)

	# Apply adjusted xz velocity to the character
	velocity.x = _xz_velocity.x
	velocity.z = _xz_velocity.z

	move_and_slide()
