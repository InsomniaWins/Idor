extends Control

var dialog = [
	"Long ago, the world experienced many severe calamities.",
	"Ancient spells cast by a dark mage were to blame.",
	"The land needed a hero to rise and defeat...",
	"I D O R"
]
var currentDialog = 0

onready var charSound = $Blip
onready var label = $Label

func _ready():
	$NextCharacter.start()

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		showTitle()

func _on_NextDialog_timeout():
	currentDialog += 1
	
	label.text = ""
	
	if currentDialog == dialog.size():
		currentDialog -= 1
		showTitle()

func showTitle():
	Global.playSound(load("res://Sounds/TitleImpact.wav"))
	Global.sceneManager.changeScene("res://Scenes/TitleScreen.tscn",Color.white)

func _on_NextCharacter_timeout():
	
	if currentDialog == dialog.size():
		return
	
	if label.text.length() < dialog[currentDialog].length():
		
		var nextChar = dialog[currentDialog].substr(label.text.length(),1)
		label.text = label.text + nextChar
		if nextChar != " ":
			charSound.pitch_scale = randf()*.75+.5
			charSound.play(0.0)
		
	else:
		
		if $NextDialog.time_left == 0.0:
			$NextDialog.start()
	
	$NextCharacter.start(.08)
