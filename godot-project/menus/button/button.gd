extends TextureButton

export (String) var label = ''

func _ready():
	$label.text = label
