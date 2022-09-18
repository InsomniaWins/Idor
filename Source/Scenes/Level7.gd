extends Level

func _ready():
	$Player.maxHealth = 4
	$Player.maxMagic = 8
	
	$Player.health = $Player.maxHealth
	$Player.magic = $Player.maxMagic
	
	Global.saveDetails.checkpoint = Global.findCheckpoint(filename)

func _physics_process(delta):
	$Path2D/PathFollow2D.offset += delta*100
	
	if has_node("Boss"):
		$Boss.position = $Path2D/PathFollow2D.position

func _on_Boss_body_entered(body):
	if body.is_in_group("player"):
		if !$Boss.dead:
			body.damage(1)

func _on_WizardDeath_finished():
	Global.sceneManager.changeScene("res://Scenes/Credits.tscn")
