extends VideoPlayer

onready var textOverlay = $CenterContainer

func _process(delta):
	$CenterContainer/ColorRect.rect_size = $CenterContainer.rect_size


func _on_rightVid_mouse_entered():
	paused = false
	textOverlay.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Timer.start()

func _on_rightVid_mouse_exited():
	paused = true
	textOverlay.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Timer.stop()
