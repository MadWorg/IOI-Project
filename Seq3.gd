extends HBoxContainer

signal final

onready var tween = $Tween

var readyFinal = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0
	
func _ready():
	print("Sekvenca 3")
	fadeIn()

func fadeIn():
	tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _on_Timer_timeout():
	counter += 1
	if(counter >= 60 and !readyFinal):
		readyFinal = true
		emit_signal("final")
