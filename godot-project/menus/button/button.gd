extends TextureButton

export (String) var label = ''

func _ready():
	$label.text = label


func _on_button_mouse_entered():
	$hover_sound.play()
