extends Control

export (int) var seconds_remaining = 30
var score : int = 0
signal timeout
var max_hp : int = 5
var hearts : Array = []


func _ready():
	update_time(0)
	update_score(0)
	var heart_template = preload("res://game/gui/gui_heart/gui_heart.tscn")
	
	var i = 0
	while i < max_hp:
		var heart = heart_template.instance()
		hearts.append(heart)
		$CenterContainer/HBoxContainer/VBoxContainer/hp_hearts.add_child(heart)
		i += 1


func _on_timer_timeout():
	update_time(-1)
	

func update_time_label():
	var minutes : int = seconds_remaining / 60
	var seconds : int = seconds_remaining % 60
	$CenterContainer2/time_label.text = str(minutes) + ":" + str("%02d" % seconds)


func update_time(delta_time):
	seconds_remaining += delta_time
	if seconds_remaining < 0:
		seconds_remaining = 0
		emit_signal('timeout')
	update_time_label()


func update_score(delta_score):
	score += delta_score
	update_score_label()


func update_score_label():
	$CenterContainer/HBoxContainer/VBoxContainer/score_label.text = "%08d" % score


func update_hp_label(hp):
	var i = 0
	while i < hp:
		hearts[i].set_full(true)
		i += 1
	while i < max_hp:
		hearts[i].set_full(false)
		i += 1


func _on_player_hp_updated(hp):
	update_hp_label(hp)
