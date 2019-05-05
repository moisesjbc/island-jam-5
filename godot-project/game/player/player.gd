extends KinematicBody2D

export (int) var speed = 300
export (float) var shoot_cooldown = 1.0
export (PackedScene) var bullet_template = null
export (int) var max_hp = 5
onready var hp : int = max_hp
signal dead
signal hp_updated


func _ready():
	emit_signal('hp_updated', hp)


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
	$bullet_respawn_origin.look_at(get_global_mouse_position())
	
	var degrees = rad2deg(get_angle_to(get_global_mouse_position()))
	if degrees < 0:
		degrees = abs(degrees) - 90
		if degrees < 0:
			degrees = 360 + degrees
	else:
		degrees = 270 - degrees
	
	var anim_name = ''
	if degrees < 45:
		anim_name = 'top'
	elif degrees < 85:
		anim_name = 'top_left'
	elif degrees < 115:
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

	if not $sprite.is_playing() or anim_name != $sprite.animation:
		$sprite.play(anim_name)

func shoot():
	"""
	Shoot if user press the shooting key
	"""
	if Input.is_action_pressed("ui_shoot") and $shoot_cooldown.is_stopped():
		var bullet = bullet_template.instance()
		bullet.global_position = $bullet_respawn_origin/bullet_respawn.global_position
		bullet.global_rotation = $bullet_respawn_origin.global_rotation
		get_tree().get_root().add_child(bullet)
		$shoot_cooldown.start(shoot_cooldown)


func hit():
	"""
	Damage the player and check if it died
	"""
	hp -= 1
	emit_signal('hp_updated', hp)
	if hp == 0:
		emit_signal('dead')


func _process(delta):
	move(delta)
	look_at_mouse()
	shoot()