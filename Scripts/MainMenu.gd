extends Control


func _on_play_button_up():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")

func _on_controls_button_up():
	pass # Replace with function body.

func _on_exit_button_up():
	get_tree().quit()
