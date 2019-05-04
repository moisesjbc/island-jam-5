extends Node2D

var npc_templates: Array = [
	preload('res://game/npc/npc_orc/npc_orc.tscn'),
	preload('res://game/npc/npc_rabbit/npc_rabbit.tscn')
]


func _ready():
	randomize()


func respawn_npc():
	"""
	Respawn a random NPC at a random position
	"""
	# Select a random NPC
	var npc_index = randi() % npc_templates.size()
	
	# Select a random respawn position
	$path/path_follow.set_offset(randi())
	
	# Instantiate NPC
	var npc = npc_templates[npc_index].instance()
	npc.global_position = $path/path_follow.global_position
	get_parent().add_child(npc)


func _on_cooldown_timeout():
	respawn_npc()
