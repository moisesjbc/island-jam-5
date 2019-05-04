extends Node2D

signal game_over

func _process(delta):
	if Input.is_action_pressed("ui_pause"):
		$gui_canvas/pause_menu.pause_game()

func _on_main_game_over():
	$gui_canvas/game_over_menu.run()


func _on_gui_timeout():
	emit_signal('game_over')
