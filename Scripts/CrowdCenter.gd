class_name CrowdController
extends Node3D

@export var speed = 10.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 1.0

func _process_input_2d(delta):
	var movement_dir = int(Input.is_action_pressed("Left")) - int(Input.is_action_pressed("Right"))
	position.x += movement_dir * speed * delta
	
func _process_input_3d(delta):
	var input = Input.get_vector("Right", "Left", "Down", "Up")
	var movement_dir = Vector3(input.x, 0.0, input.y)
	position += movement_dir * speed * delta
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_process_input_3d(delta)
