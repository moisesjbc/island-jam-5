extends Node2D

export (float) var cooldown_time = 1.0

var npc_templates: Array = [
	preload('res://game/npc/npc_orc/npc_orc.tscn'),
	preload('res://game/npc/npc_rabbit/npc_rabbit.tscn'),
	preload('res://game/npc/npc_fairy/npc_fairy.tscn'),
	preload('res://game/npc/npc_pig/npc_pig.tscn')
]


func _ready():
	randomize()
	$cooldown.start(cooldown_time)


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
