extends RigidBody3D

# these weights where defined through
# trial and error. You can play with them
# to check how they affect the flock.
const SEPARATION_WEIGHT = 0.001
const ALIGNMENT_WEIGHT = 0.001
const COHESION_WEIGHT = 0.001


var _max_speed = 4
var _speed = 2
var _direction = Vector3(0, -1, 0)
var _separation_distance = 1

var _local_flockmates = []


func _physics_process(_delta):
	move_and_collide(_direction * _delta * 9.8)
	_direction = _flock_direction()

# This function is pretty much all you need for calculating
# the flocking movement
func _flock_direction():
	var separation = Vector3()
	var heading = _direction
	var cohesion = Vector3()
	
	print(_local_flockmates.size())

	for flockmate in _local_flockmates:
		heading += flockmate.get_direction()
		cohesion += flockmate.position

		var distance = self.position.distance_to(flockmate.position)

		if distance < _separation_distance:
			separation -= (flockmate.position - self.position).normalized() * (_separation_distance / distance * _speed)

	if _local_flockmates.size() > 0:
		heading /= _local_flockmates.size()
		cohesion /= _local_flockmates.size()
		var center_direction = self.position.direction_to(cohesion)
		var center_speed = _max_speed * self.position.distance_to(cohesion) / $DetectionRadius/CollisionShape3D.shape.radius
		cohesion = center_direction * center_speed

	return (
		_direction +
		separation * SEPARATION_WEIGHT +
		heading * ALIGNMENT_WEIGHT +
		cohesion * COHESION_WEIGHT
	).clamp(Vector3.ZERO, Vector3(_max_speed,_max_speed,_max_speed))


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