extends Node

@export var _character : CharacterBody3D
@export var _camera : Camera3D
var _input_direction : Vector2
var _move_direction : Vector3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float):
	_input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	_move_direction = (_camera.basis.x * Vector3(1, 0, 1)).normalized() * _input_direction.x
	_move_direction += (_camera.basis.z * Vector3(1, 0, 1)).normalized() * _input_direction.y
	_character.move(_move_direction)
