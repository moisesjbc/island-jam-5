extends Control


func set_full(full):
	$full_heart.visible = full
	$empty_heart.visible = not full