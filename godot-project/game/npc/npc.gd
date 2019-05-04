extends KinematicBody2D

export (PackedScene) var dish_template = null
export (int) var speed = 250
var player = null
var alive = true
var dragging : bool = false



func _ready():
	player = get_node("../player")
	
	add_to_group("NPCs")
	set_process_input(true)
	
	
func get_effect():
	return ''


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


func _on_area_area_entered(area):
	"""
	If NPC collides with other and both are dead, transform them into a dish
	"""
	if dragging and area.get_parent().is_in_group("NPCs"):
		var other_npc = area.get_parent()
		if not alive and not other_npc.alive:
			if get_effect() != other_npc.get_effect():
				# Deactivate the processing in the other NPC so this code isn't run again on it.
				other_npc.set_process(false)
				var dish = dish_template.instance()
				dish.set_combined_effect(get_effect(), other_npc.get_effect())
				dish.global_position = area.global_position
				get_parent().add_child(dish)
				queue_free()
				other_npc.queue_free()
