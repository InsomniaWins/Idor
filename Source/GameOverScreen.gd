extends Control

func _ready():
	if !Global.saveDetails.checkpoint.empty():
		$Label.text = $Label.text+"\nPassword: "+Global.saveDetails.checkpoint
	Global.stopGameMusic()
	$Sound.play()

func _input(event):
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("ui_accept"):
		goToTitle()

func goToTitle():
	if !Global.saveDetails.checkpoint.empty():
		Global.sceneManager.changeScene(Global.checkpointKeys[Global.saveDetails.checkpoint])
		Global.playGameMusic()
	else:
		Global.sceneManager.changeScene("res://Scenes/TitleScreen.tscn")
