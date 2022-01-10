extends RichTextLabel

signal clicked

var hover = false

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and hover and not event.is_pressed() and event.button_index == 1:
			print("clicked")
			emit_signal("clicked")

func _on_RichTextLabel_mouse_entered():
	hover = true
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_RichTextLabel_mouse_exited():
	hover = false
	mouse_default_cursor_shape = Control.CURSOR_ARROW
