extends Node

@export var MINIONS_SPRITES: Array = [
	preload("res://Sprites/Minions/MinionHatB_180x256.png"),
	preload("res://Sprites/Minions/MinionTreeB_180x256.png")
]

func _process(delta):
	if Input.is_action_just_pressed("SpawnMinion"):
		for i in 10:
			var minion_instance = preload("res://Scenes/ball.tscn").instantiate()
			minion_instance.position = Vector3(i,2,i)
			minion_instance.set_name("minion")
			minion_instance.get_node("Sprite3D").texture = MINIONS_SPRITES.pick_random()
			add_child(minion_instance)

