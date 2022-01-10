extends TextureRect

signal img_clicked

var hover = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_toFinal_mouse_entered():
	hover = true
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _on_toFinal_mouse_exited():
	hover = false
	mouse_default_cursor_shape = Control.CURSOR_ARROW

func _input(event):
	if event is InputEventMouseButton and hover and not event.is_pressed() and event.button_index == 1 and modulate == Color(1,1,1,1):
			print("clicked")
			emit_signal("img_clicked")
