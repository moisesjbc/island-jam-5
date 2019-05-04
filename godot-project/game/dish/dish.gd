extends Area2D


var effect : String = 'plus_time'


func set_combined_effect(effect_1, effect_2):
	if effect_1 != 'plus' and effect_1 != 'minus':
		var aux = effect_1
		effect_1 = effect_2
		effect_2 = aux
	effect = "effect_" + effect_1 + '_' + effect_2


func _on_dish_body_entered(body):
	queue_free()
	if body.name == 'player':
		get_parent().process_effect(effect, 5)
