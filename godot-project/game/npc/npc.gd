extends KinematicBody2D


export (int) var speed = 250
var player = null


func _ready():
	player = get_node("../player")


func decide_direction(delta):
	"""
	Return the direction vector the npc will move on in the current frame
	"""
	return (player.global_position - global_position).normalized() * speed * delta


func look_at_player():
	"""
	Look at the player's position
	"""
	look_at(player.global_position)


func _process(delta):
	move_and_collide(decide_direction(delta))
	look_at_player()