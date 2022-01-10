extends HBoxContainer

onready var leftVid = $leftVideo
onready var leftImg = $leftImage
onready var rightVid = $rightVideo
onready var rightImg = $rightImage

onready var tween = $Tween 

signal finished
signal done

var steps = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	leftImg.modulate = Color(1,1,1,0)
	rightImg.modulate = Color(1,1,1,0)
	rightVid.modulate = Color(1,1,1,0)
	fadeIn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func fadeIn():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	


func _on_Timer_timeout():
	tween.interpolate_property(rightImg, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
	tween.start()


func _on_leftVideo_finished():
	if(steps == 0):
		tween.interpolate_property(leftVid, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
		tween.start()
		steps += 1
	elif(steps == 2):
		tween.interpolate_property(leftVid, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
		tween.start()
		steps += 1


func _on_Tween_tween_completed(object, key):
	print(object.name)
	
	
	if(object.name == "rightImage" and steps > 0):
		rightImg.visible = false
		rightVid.visible = true
	
	if(steps == 1 and object.name == "leftVideo"):
		leftVid.stop()
		leftVid.set_stream(load("res://videos/000.webm"))
		leftVid.play()
		tween.interpolate_property(leftVid, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
		tween.start()
		steps += 1
		tween.interpolate_property(rightImg, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
		tween.start()
		$Timer2.start()
	elif(steps == 3 and object.name == "leftVideo"):
		leftVid.visible = false
		leftImg.visible = true
		steps += 1
		tween.interpolate_property(leftImg, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
		tween.start()
	elif(steps == 15):
		rightVid.stop()
		
		
func _on_rightImage_img_clicked(ref):
	tween.interpolate_property(leftVid, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
	tween.start()
	steps += 1
	tween.interpolate_property(rightImg, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
	tween.start()


func _on_Timer2_timeout():
	rightVid.play()
	tween.interpolate_property(rightVid, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, tween.TRANS_LINEAR, tween.EASE_IN)
	tween.start()

func finishSegment():
	emit_signal("finished")
	rightVid.stop()


func _on_rightVideo_finished():
	finishSegment()

func _on_leftImage_img_clicked(ref):
	finishSegment()
