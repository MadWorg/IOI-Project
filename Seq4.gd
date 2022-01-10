extends HBoxContainer

onready var timer = $TextTimer
onready var type_speed = 0.1

signal finished
var vidCount = 0

var text = "Po desetih dneh osamitve na vasi sem lahko raziskovala občutke, ki so se ob tem pojavljali. Kdo sem jaz na vasi, kaj je moje mesto tukaj? Hkrati pa soočanje z občutki samote, ki se pojavljajo. Bili so dnevi, ko nisem srečala nikogar, čez dan tega nisem opazila, tega sem se zavedala komaj zvečer. Ko je temno in tiho. Večer na vasi je lahko izjemno osamljen ampak lahko je pa tudi zelo čaroben. Če se le prepustiš tišini in vsem zvokom, ki jim ne znaš vedno pripisati izvora."
var loading_text = true
var fade_in = false

func _ready():
	timer.set_wait_time(type_speed)
	load_text()
	fadeIn()

func finished_print():
	loading_text = false

func fadeIn():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	fade_in = true

func load_text():
	for letter in text:
		timer.start()
		$PanelContainer/RichTextLabel.bbcode_text += letter
		yield(timer, "timeout")
	finished_print()


func _on_RichTextLabel_clicked():
	if(loading_text):
		type_speed /= 3
		timer.set_wait_time(type_speed)
	else:
		emit_signal("finished")
		$VideoPlayer.stop()

func swap_video():
	if(vidCount == 0):
		$VideoPlayer.set_stream(load("res://videos/000.webm"))
		vidCount += 1
		$Tween.interpolate_property($VideoPlayer, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, $Tween.TRANS_LINEAR, $Tween.EASE_IN)
		$Tween.start()

func _on_VideoPlayer_finished():
	if(vidCount == 0):
		$Tween.interpolate_property($VideoPlayer, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, $Tween.TRANS_LINEAR, $Tween.EASE_IN)
		$Tween.start()
	else:
		$VideoPlayer.play()


func _on_Tween_tween_completed(object, key):
	if(fade_in):
		fade_in = false
	elif(vidCount == 0):
		swap_video()
	else:
		$VideoPlayer.play()
