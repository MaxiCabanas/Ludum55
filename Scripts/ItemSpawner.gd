extends RigidBody3D

@export var probability: int = 100

func _ready():
	if randi_range(0, 100) <= probability:
		var item_manager = get_node("/root/ItemManager")
		var food: Array = item_manager.get_random_food()
		print(food[1])
		add_child(food[0])
		_animate(food[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(Vector3.DOWN * delta)

func _animate(node):
	var tween: Tween = get_tree().create_tween()
	tween.bind_node(self)
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_loops()
	
	var q_target: Quaternion = Quaternion(Vector3.UP, 360)
	tween.tween_property(node, "quaternion", q_target, 1).as_relative()
	#tween.set_ease(Tween.EASE_IN_OUT)
	
#OLD IMPLEMENTATION
#func _calculate_size(food):
	#var all_meshes = food.find_children("", "MeshInstance3D", true)
	##var original_size: Vector3 = Vector3.ZERO
	#var aabb: AABB = all_meshes[0].get_aabb()
	#
	#for index in range(1, all_meshes.size(), 1):
		#aabb.merge(all_meshes[index].get_aabb())
	##for mesh_instance: MeshInstance3D in all_meshes:
		##aabb.merge(mesh_instance.get_aabb())
		##original_size += mesh_instance.get_aabb().size
	#
	##original_size = original_size.ceil()
	#var original_size: Vector3 = aabb.size
	#var final_size = (original_size.x + original_size.y + original_size.z)
	#final_size = ceil(final_size)
	#
	#print(food.name)
	#print("Size: ")
	#print(original_size)
	#print("Final Size: " + String.num(final_size))
