extends Node

var minions_alive = []

func _ready():
	minions_alive.append_array(get_tree().get_nodes_in_group("minion"))
	
func _process(delta):
	if Input.is_action_just_pressed("SpawnMinion"):
		var minion_instance = preload("res://Scenes/ball.tscn").instantiate()
		minion_instance.position = Vector3(0,2,0)
		minion_instance.set_name("scene")
		add_child(minion_instance)
		minions_alive.append(minion_instance)

func get_crowd_position():
	var crowd_position = Vector3.ZERO
	for minion in minions_alive:
		crowd_position += minion.position
	return crowd_position / max(1, minions_alive.size())

func set_minion_as_active(minion, is_active):
	if is_active && !minions_alive.has(minion):
		minions_alive.append(minion)
	elif !is_active && minions_alive.has(minion):
		minions_alive.erase(minion)
