extends Node2D

signal game_over


func _process(delta):
	if Input.is_action_pressed("ui_pause"):
		$gui_canvas/pause_menu.pause_game()


func _on_main_game_over():
	$gui_canvas/game_over_menu.run()


func _on_gui_timeout():
	emit_signal('game_over')


func process_effect(effect, effect_value):
	print("Processing effect")
	if effect == 'effect_minus_time':
		$gui_canvas/gui.update_time(-effect_value)