extends Node3D

#enum ItemTypes {
	#FOOD
#}

#@export_dir var food_path = "res://Meshes/Food/GLTF"

#value is size
@export var food_table: Dictionary = {
	preload("res://Meshes/Food/GLTF/apple.glb") : 1,
	preload("res://Meshes/Food/GLTF/banana.glb") : 1,
	preload("res://Meshes/Food/GLTF/barrel.glb") : 6,
	preload("res://Meshes/Food/GLTF/burgerDouble.glb") : 1,
	preload("res://Meshes/Food/GLTF/cakeBirthday.glb") : 3,
	preload("res://Meshes/Food/GLTF/chinese.glb") : 1,
	preload("res://Meshes/Food/GLTF/pizza.glb") : 2,
	preload("res://Meshes/Food/GLTF/wholeHam.glb") : 3,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _init_path_array(folder, path_dic):
	var dir = DirAccess.open(folder)
	dir.include_hidden = false
	for scene_path in dir.get_files():
		if !scene_path.ends_with("import"):
			path_dic[scene_path] = ""

func get_random_food():
	var food_resource = food_table.keys().pick_random()
	return [food_resource.instantiate(), food_table[food_resource]]
