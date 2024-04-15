extends Node3D

class_name TerrainManager

## This builds and operates the terrain "conveyor belt"
##
## A set of randomly choosen terrain blocks is rendered to the viewport.
## As the game played the terrian is moved in the posative Z direction.
## When a given block passes behind this node it is removed and a new block
## is added to the far end of the conveyor
@export var z_size = 5.0
@export var speed = 5.0
## The number of blocks to keep rendered to the viewport
@export var num_of_sections = 10
## Path to directory holding the terrain block scenes
@export_dir var sections_path = "res://Scenes/TerrainSections/"

## Holds the catalog of loaded terrian block scenes
var sections_catalog = []
## The set of terrian blocks which are currently rendered to viewport
var sections_instances = []


func _ready():
	_load_terrain_scenes(sections_path)
	_init_blocks()

func _physics_process(delta):
	_progress_terrain(delta)


func _load_terrain_scenes(target_path):
	#var dir = DirAccess.open(target_path)
	#for scene_path in dir.get_files():
		#sections_catalog.append(load(target_path + "/" + scene_path))
		sections_catalog.append(preload("res://Scenes/TerrainSections/floor_tile.tscn"))

func _init_blocks():
	for section_index in num_of_sections:
		var new_section = sections_catalog.pick_random().instantiate()
		if section_index == 0:
			#new_section.position.z = new_section.mesh.size.z/2
			new_section.position.z = z_size / 2			
		else:
			_append_to_far_edge(sections_instances[section_index - 1], new_section)
		add_child(new_section)
		sections_instances.append(new_section)
		_tween_section(new_section)

func _append_to_far_edge(last_section, new_section):
	#new_section.position.z = last_section.position.z + last_section.mesh.size.z
	new_section.position.z = last_section.position.z + z_size

func _progress_terrain(delta):
	#if sections_instances[0].position.z <= -sections_instances[0].mesh.size.z:
	if sections_instances[0].position.z <= -z_size:
		var last_section = sections_instances[-1]
		var first_section = sections_instances.pop_front()

		var new_section = sections_catalog.pick_random().instantiate()
		_append_to_far_edge(last_section, new_section)
		add_child(new_section)
		sections_instances.append(new_section)
		first_section.queue_free()
		_tween_section(new_section)

func _tween_section(section):
	#var duration = abs((-section.mesh.size.z) - section.position.z) / speed
	var duration = abs((-z_size) - section.position.z) / speed
	var tween = get_tree().create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	#tween.tween_property(section, "position", Vector3(position.x, position.y, -section.mesh.size.z), duration)
	tween.tween_property(section, "position", Vector3(position.x, position.y, -z_size), duration)
