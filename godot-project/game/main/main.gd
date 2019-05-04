extends Node2D

signal game_over
export (int) var score_per_enemy_killed = 20


func _process(delta):
	if Input.is_action_pressed("ui_pause"):
		$gui_canvas/pause_menu.pause_game()


func _on_main_game_over():
	$gui_canvas/game_over_menu.run()


func _on_gui_timeout():
	emit_signal('game_over')


func process_effect(effect, effect_value):
	"""
	Apply the given effect to the game
	"""
	print("Processing effect")
	if effect == 'effect_minus_time':
		$gui_canvas/gui.update_time(-effect_value)
	elif effect == 'effect_plus_time':
		$gui_canvas/gui.update_time(+effect_value)
	elif effect == 'effect_minus_enemy':
		get_tree().call_group('NPCs', 'kill')
	elif effect == 'effect_plus_enemy':
		var i = 0
		while i < effect_value:
			$npc_respawn.respawn_npc()
			i += 1


func enemy_killed():
	"""
	Update score based after killing an enemy
	"""
	$gui_canvas/gui.update_score(score_per_enemy_killed)