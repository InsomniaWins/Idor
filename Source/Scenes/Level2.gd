extends Level

func _ready():
	
	if !is_instance_valid(Global.sceneManager):
		return
	
	if Global.sceneManager.prevScene == "res://Scenes/TestLevel.tscn":
		$Player.velocity.y = -320
