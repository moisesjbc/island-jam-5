extends KinematicBody2D


export (int) var speed = 250
var player = null
var alive = true
var dragging : bool = false


func _ready():
	player = get_node("../player")
	add_to_group("NPCs")
	set_process_input(true)


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


func kill():
	alive = false
	$collider.disabled = true


func _process(delta):
	if alive:
		move_and_collide(decide_direction(delta))
		look_at_player()
	else:
		if dragging:
			global_position = get_global_mouse_position()


func _on_area_input_event(viewport, event, shape_idx):
	"""
	If NPC is dead, handle drag and drop
	"""
	if not alive:
		if event is InputEventMouseButton and \
			event.pressed and \
			event.button_index == BUTTON_LEFT:
				dragging = not dragging
