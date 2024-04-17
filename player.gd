extends Node

var _move_direction : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float):
	_move_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	print(_move_direction)
