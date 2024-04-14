class_name Item
extends RigidBody3D

@export var speed: float = 10.0
@export var size: int = 1

@onready var _minion_manager = get_node("/root/MinionsManager")

var _nerby_minions = []
var _direction = Vector3.DOWN
var _movement_margin = .5

func _ready():
	_nerby_minions.push_back(get_node("/root/CrowdCenter"))

func _physics_process(delta):
	move_and_collide(_direction * delta)
	var dir_to_target = _minion_manager.get_item_position(size) - position
	_direction = dir_to_target.normalized() * speed if dir_to_target.length() > _movement_margin else Vector3.DOWN
