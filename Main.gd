extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const seq1 = preload("res://Seq1.tscn")
const seq2 = preload("res://Seq2.tscn")
const seq3 = preload("res://Seq3.tscn")
const seq4 = preload("res://Seq4.tscn")

var removing = false
var credits = false

var currScene = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$FinalPoem.visible = false
	$Credits.visible = false
	
	#$Seq1.queue_free()
	#$Seq2.queue_free()
	#$Seq4.queue_free()
	#$Seq3.queue_free()

	fullVersion()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func fullVersion():
	var initial = seq1.instance()
	initial.connect("finished", self, "_on_Seq1_finished")
	#initial.connect("done", self, "_on_faded")
	#initial.connect("final", self, "_on_Seq3_final")
	$SceneHolder.add_child(initial)

func fadeIn():
	$Tween.interpolate_property($SceneHolder.get_child(0), "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
	
func fadeOut():
	$Tween.interpolate_property($SceneHolder.get_child(0), "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	removing = true
	yield($Tween, "tween_all_completed")
	

func _on_Seq1_finished():
	print("Seq1 finished")
	
	currScene = 2
	fadeOut()
	
	var nextScene = seq2.instance()
	nextScene.modulate = Color(1,1,1,0)
	nextScene.connect("finished", self, "_on_Seq2_finished")
	
	$SceneHolder.add_child(nextScene)


func _on_Seq2_finished():
	print("Seq2 finished")
	
	fadeOut()
	
	
	var nextScene = seq3.instance()
	nextScene.modulate = Color(1,1,1,0)
	nextScene.connect("final", self, "_on_Seq3_final")
	
	$SceneHolder.add_child(nextScene)

		


func _on_Seq4_finished():
	print("Seq4 finished")
	
	fadeOut()
	
	$Timer.start()


func _on_toFinal_img_clicked():
	print("Seq3 finished")
	
	$Tween2.interpolate_property($toFinal, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween2.start()
	
	fadeOut()
	
	$SceneHolder.get_child(0).queue_free()
	
	var nextScene = seq4.instance()
	nextScene.modulate = Color(1,1,1,0)
	nextScene.connect("finished", self, "_on_Seq4_finished")
	
	$SceneHolder.add_child(nextScene)
	

	


func _on_Seq3_final():
	$toFinal.visible = true
	$Tween.interpolate_property($toFinal, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1.5, $Tween.TRANS_LINEAR, $Tween.EASE_IN)
	$Tween.start()


func _on_faded():
	$SceneHolder.get_child(0).queue_free()


func _on_Tween_tween_completed(object, key):
	if(removing):
		$SceneHolder.get_child(0).queue_free()
		if($SceneHolder.get_child_count() == 1):
			$SceneHolder.remove_child($SceneHolder.get_child(0))
		removing = false


func _on_Timer_timeout():
	$FinalPoem.fadeIn()


func _on_FinalPoem_showCredits():
	$FinalPoem.fadeOut()
	$Credits.fadeIn()


func _on_Credits_ending():
	get_tree().reload_current_scene()
