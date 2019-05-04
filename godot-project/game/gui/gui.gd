extends Control

export (int) var seconds_remaining = 30
var score : int = 0
signal timeout


func _ready():
	update_time(0)
	update_score(0)


func _on_timer_timeout():
	update_time(-1)
	

func update_time_label():
	var minutes : int = seconds_remaining / 60
	var seconds : int = seconds_remaining % 60
	$container/time_label.text = str(minutes) + ":" + str("%02d" % seconds)


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
	$container/score_label.text = "%08d" % score


func update_hp_label(hp):
	$container/hp_label.text = "HP: " + str(hp)


func _on_player_hp_updated(hp):
	update_hp_label(hp)
