extends KinematicBody2D

export (int) var speed = 300

func move(delta):
	"""
	Move player according to user input
	"""
	var direction : Vector2 = Vector2(0.0, 0.0)
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
		
	move_and_collide(direction * speed * delta)


func look_at_mouse():
	"""
	Rotate player so it looks towards mouse position
	"""
	look_at(get_global_mouse_position())


func _process(delta):
	move(delta)
	look_at_mouse()