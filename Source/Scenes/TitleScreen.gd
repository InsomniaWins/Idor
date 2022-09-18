extends Control

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		Global.sceneManager.changeScene("res://Scenes/Password.tscn")
	
	if (Input.is_action_just_pressed("shoot")):
		
		Global.playGameMusic()
		
		Global.sceneManager.changeScene("res://Scenes/TestLevel.tscn")

func _on_AudioStreamPlayer_finished():
	Global.sceneManager.changeScene("res://Scenes/Intro.tscn")
