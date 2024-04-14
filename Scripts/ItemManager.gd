extends Node3D

enum ItemTypes {
	FOOD
}

@export_dir var food_path = "res://Meshes/Food/GLTF"

#var food_paths_array = []
var food_instances_dic = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	print(food_instances_dic.size())
	_init_path_array(food_path, food_instances_dic)
	print(food_instances_dic.size())

func _init_path_array(folder, path_dic):
	var dir = DirAccess.open(folder)
	dir.include_hidden = false
	for scene_path in dir.get_files():
		if !scene_path.ends_with("import"):
			path_dic[scene_path] = ""

func get_random_food():
	var random_food = food_instances_dic.keys().pick_random()
	food_instances_dic[random_food] = load(food_path + "/" + random_food)
	return food_instances_dic[random_food].instantiate()
