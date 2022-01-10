extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal showCredits

onready var tween = get_node("../Tween2")

func fadeIn():
	tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	visible = true
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func fadeOut():
	tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _input(event):
	if event is InputEventMouseButton and visible and not event.is_pressed() and event.button_index == 1 and modulate == Color(1,1,1,1):
			print("clicked poem")
			emit_signal("showCredits")
			fadeOut()
			mouse_filter = Control.MOUSE_FILTER_PASS

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

