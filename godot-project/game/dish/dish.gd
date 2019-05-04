extends Area2D

signal effect_plus_time
signal effect_minus_time

var effect : String = 'plus_time'


func set_combined_effect(effect_1, effect_2):
	if effect_1 != 'plus' and effect_1 != 'minus':
		var aux = effect_1
		effect_1 = effect_2
		effect_2 = aux
	effect = "effect_" + effect_1 + '_' + effect_2


func _on_dish_body_entered(body):
	if body.name == 'player':
		print('player ate me!')
		print(effect)
		emit_signal(effect)
