class_name Minion
extends CharacterBody3D

@export var speed = 5.0
@export var separation = 5.0
#@export var jump_velocity = 4.5

@onready var minion_manager = get_node("/root/MinionsManager")
@onready var is_active = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var local_minions = []

func _physics_process(delta):
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	set_active(is_on_floor())

	var direction = get_node("/root/CrowdCenter").global_position - global_position
	
	if direction.length() >= 0.5:
		velocity.x += direction.normalized().x * speed * delta
		velocity.z += direction.normalized().z * speed * delta
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()
	
func _on_detection_area_body_entered(body):
	if body == self:
		return
		
	if body.is_in_group("minion"):
		local_minions.push_back(body)

func _on_detection_area_body_exited(body):
	if body.is_in_group("minion"):
		local_minions.erase(body)

func set_active(new_state):
	if is_active != new_state:
		is_active = new_state
		minion_manager.set_minion_as_active(self, is_active)
