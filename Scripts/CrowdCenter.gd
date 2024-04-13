class_name CrowdController
extends Node3D

@export var speed = 10000.0;
@onready var minion_manager = get_node("/root/MinionsManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 1.0

func _process_input_2d(delta):
	var crowd_position = minion_manager.get_crowd_position()
	var movement_dir = int(Input.is_action_pressed("Left")) - int(Input.is_action_pressed("Right"))
	position.x = crowd_position.x + movement_dir * speed * delta
	
func _process_input_3d(delta):
	var crowd_position = minion_manager.get_crowd_position()
	var x = int(Input.is_action_pressed("Left")) - int(Input.is_action_pressed("Right"))
	var z = int(Input.is_action_pressed("Up")) - int(Input.is_action_pressed("Down"))
	var movement_dir = Vector3(x, 0.0, z)
	position = crowd_position + movement_dir * speed * delta
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_process_input_2d(delta)
