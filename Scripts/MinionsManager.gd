extends Node

@onready var first_time = true
@onready var crowd_center = get_node("/root/CrowdCenter")

@export var MINIONS_SPRITES: Array = [
	preload("res://Sprites/Minions/MinionHatB_180x256.png"),
	preload("res://Sprites/Minions/MinionTreeB_180x256.png")
]

var active_minions: Dictionary = {}

func _process(_delta):
	if Input.is_action_just_pressed("SpawnMinion"):
		for i in 3:
			var minion_instance = preload("res://Scenes/ball.tscn").instantiate()
			minion_instance.position = Vector3(i,2,i)
			minion_instance.set_name("minion")
			minion_instance.get_node("Sprite3D").texture = MINIONS_SPRITES.pick_random()
			add_child(minion_instance)
			
		if first_time:
			var item = preload("res://Scenes/Item.tscn").instantiate()
			item.position = Vector3(0,2,0)
			item.set_name("item")
			add_child(item)
			first_time = false
			
	for minion in active_minions.keys():
		active_minions[minion] = _get_minion_distance_to_controller(minion)

func register_minion(minion, state):
	if state && !active_minions.has(minion):
		active_minions[minion] = _get_minion_distance_to_controller(minion)
	elif !state && active_minions.has(minion):
		active_minions.erase(minion)

func _get_minion_distance_to_controller(minion):
	return (crowd_center.position - minion.position).length_squared()

func get_item_position(minions_count):
	
	#inverted_dic = {distance: minion}
	var inverted_dic: Dictionary = {}
	for minion in active_minions.keys():
		inverted_dic[active_minions[minion]] = minion
	
	var sorted_distances = inverted_dic.keys()
	sorted_distances.sort()
	var closest_distances = sorted_distances.slice(0, minions_count)
	
	var new_item_pos = Vector3.ZERO
	for dist in closest_distances:
		new_item_pos += inverted_dic[dist].position
	
	return new_item_pos / max(1, closest_distances.size())
