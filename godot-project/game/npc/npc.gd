extends KinematicBody2D

export (PackedScene) var dish_template = null
export (int) var speed = 250
var player = null
var alive = true
var dragging : bool = false
export (float) var disappear_cooldown = 10.0


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
	if alive:
		get_parent().enemy_killed()
		
		alive = false
		$collider.disabled = true
		
		# Set a cooldown. When trigerred make the body disappear.
		$disappear_cooldown_timer.start(disappear_cooldown)
		
		$sprite.play('dead')


func _process(delta):
	if alive:
		var collision = move_and_collide(decide_direction(delta))
		if collision and collision.get_collider().name == 'player':
			collision.get_collider().hit()
			queue_free()
		decide_animation()
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
			# In both NPCs are dead, destroy them in any case
			queue_free()
			other_npc.queue_free()
			
			# If they are different, create a dish combining the effects.
			if get_effect() != other_npc.get_effect():
				# Deactivate the processing in the other NPC so this code isn't run again on it.
				other_npc.set_process(false)
				var dish = dish_template.instance()
				dish.set_combined_effect(get_effect(), other_npc.get_effect())
				dish.global_position = area.global_position
				get_parent().add_child(dish)
				


func _on_disappear_cooldown_timer_timeout():
	queue_free()


func decide_animation():
	var degrees = get_angle_to(get_global_mouse_position()) 
	print(degrees)
	#var degrees = global_rotation_degrees - 90
	
	var anim_name = ''
	if degrees < 45:
		anim_name = 'top'
	elif degrees < 90:
		anim_name = 'top_left'
	elif degrees < 135:
		anim_name = 'left'
	elif degrees < 170:
		anim_name = 'bottom_left'
	elif degrees < 220:
		anim_name = 'bottom'
	elif degrees < 245:
		anim_name = 'bottom_left'
	elif degrees < 300:
		anim_name = 'left'
	else:
		anim_name = 'top_left'
	
	$sprite.flip_h = degrees > 180

	if anim_name != $sprite.animation:
		$sprite.play(anim_name)