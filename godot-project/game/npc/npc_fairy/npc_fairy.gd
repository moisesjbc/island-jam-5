extends "res://game/npc/npc.gd"

var start_global_position : Vector2


func _ready():
	start_global_position = global_position


func get_effect():
	return 'plus'


func decide_direction(delta):
	"""
	Return the direction vector the npc will move on in the current frame
	"""
	return -start_global_position.normalized() * speed * delta