extends HBoxContainer

onready var timer = $TextTimer
onready var type_speed = 0.1

var text = "Med osmo in deveto zjutraj ne srečam na vasi prav veliko ljudi. Kdor je imel za iti v službo je že šel, ostali še niso zapustili hiše, Sužid je ovit v meglo. Sliši se zvok kravjega zvonca. V daljavi, na polju, zagledam tri srne, ki se pasejo. Na vasi koze, po cesti se sprehajajo kokoši. Nalaja me Minčev pes, takoj za tem se mi stisne ob nogo in želi, da ga čoham. Minča še vedno nisem spoznala, ima pa od lanskega leta popravljeno steklo na vratih. Na stopnicah Radojke, ki ima pred hišo kavč , je mačka. Jutro na vasi je mirno in tiho. Najbolj glasni so zvokovi oddaljenih zvonov ali kravjega zvonca. Včasih in počasi zaslišim tudi traktor. Vsako soboto in nedeljo Marjan ob 12:00 zvoni. Suši se perilo, ljudje delajo na njivah ali vrtovih okoli hiše. Vas se prebuja počasi, s soncem ki se dviguje izza gozdov."
var loading_text = true
var vidCount = 0
var fade_in = false

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(type_speed)
	load_text()
	fadeIn()

func fadeIn():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	fade_in = true

func finished_print():
	loading_text = false

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
		$VideoPlayer.set_stream(load("res://videos/Loop.webm"))
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
