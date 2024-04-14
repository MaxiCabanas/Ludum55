class_name HUD
extends Control

func on_minion_spawned():
	_add_value_to_minion_counter(1)

func on_minion_killed():
	_add_value_to_minion_counter(-1)
	
func _add_value_to_minion_counter(value):
	var current_amount = int($MinionsCounter.text)
	$MinionsCounter.text = String.num(current_amount + value, 0).pad_zeros(2)
