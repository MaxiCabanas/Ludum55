extends Node3D

@export var probability = 100.0

func _ready():
	var item_manager = get_node("/root/ItemManager")
	add_child(item_manager.get_random_food())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
