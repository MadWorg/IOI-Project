extends TextureRect

signal img_clicked(ref)

var hover = false

func _ready():
	modulate = Color(1,1,1,0)

func _on_leftImage_mouse_entered():
	hover = true
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_leftImage_mouse_exited():
	hover = false
	mouse_default_cursor_shape = Control.CURSOR_ARROW

func _input(event):
	if event is InputEventMouseButton and hover and not event.is_pressed() and event.button_index == 1 and modulate == Color(1,1,1,1):
			print("clicked")
			emit_signal("img_clicked",self)
