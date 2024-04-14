extends RigidBody3D

# these weights where defined through
# trial and error. You can play with them
# to check how they affect the flock.
const SEPARATION_WEIGHT = .5
const ALIGNMENT_WEIGHT = 0.05
const COHESION_WEIGHT = 0.05
const TARGET_WEIGHT = 1


var _max_speed = 10
var _speed = 5
var _direction = Vector3(0, -1, 0)
var _separation_distance = 1

var _local_flockmates = []

func _ready():
	get_node("/root/Hud").on_minion_spawned()

func _exit_tree():
	get_node("/root/Hud").on_minion_killed()

func _physics_process(_delta):
	move_and_collide(_direction * _delta)
	_direction = _flock_direction()

# This function is pretty much all you need for calculating
# the flocking movement
func _flock_direction():
	var separation = Vector3()
	var heading = _direction
	var cohesion = Vector3()
	
	for flockmate in _local_flockmates:
		heading += flockmate.get_direction()
		cohesion += flockmate.position

		var distance = position.distance_to(flockmate.position)

		if distance < _separation_distance:
			separation -= (flockmate.position - position).normalized() * (_separation_distance / distance * _speed)

	if _local_flockmates.size() > 0:
		heading /= _local_flockmates.size()
		cohesion /= _local_flockmates.size()
		var center_direction = position.direction_to(cohesion)
		var center_speed = _max_speed * position.distance_to(cohesion) / $DetectionRadius/CollisionShape3D.shape.radius
		cohesion = center_direction * center_speed
		
	#Target direction
	var target = global_position.direction_to(get_node("/root/CrowdCenter").global_position) * _speed

	return (
		_direction +
		separation * SEPARATION_WEIGHT +
		heading * ALIGNMENT_WEIGHT +
		cohesion * COHESION_WEIGHT +
		target * TARGET_WEIGHT
	).limit_length(_max_speed)


func get_direction():
	return _direction


func set_direction(direction):
	_direction = direction


func _on_detection_radius_body_entered(body):
	if body == self:
		return

	if body.is_in_group("minions"):
		_local_flockmates.push_back(body)


func _on_detection_radius_body_exited(body):
	if body.is_in_group("minions"):
		_local_flockmates.erase(body)
