extends KinematicBody2D

export (int) var speed = 250


func _process(delta):
	# Keep moving forward
	var collision = move_and_collide(Vector2(1.0, 0.0).rotated(rotation).normalized() * speed * delta)
	
	# Destroy NPCs if hit
	if collision:
		var body = collision.get_collider()
		queue_free()
		if body.is_in_group("NPCs") and body.alive:
			body.kill()
