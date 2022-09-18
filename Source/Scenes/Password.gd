extends Control

var chars = "ABCEDFGHIJKLMNOPQRSTUVWXYZ1234567890"
var currentChar = 0
var selectedButton = 0
onready var buttons = [$CurrentCharacter,$Select,$Cancel]
onready var currentCharLabel = $CurrentCharacter

func _ready():
	currentCharLabel.text = chars.substr(currentChar,1)

func _input(event):
	if Input.is_action_just_pressed("down"):
		selectedButton += 1
		if selectedButton > buttons.size()-1:
			selectedButton = 0
		$Arrows.rect_position.y = buttons[selectedButton].rect_position.y
	elif Input.is_action_just_pressed("up"):
		selectedButton -= 1
		if selectedButton < 0:
			selectedButton = buttons.size()-1
		$Arrows.rect_position.y = buttons[selectedButton].rect_position.y
	elif Input.is_action_just_pressed("right"):
		currentChar += 1
		if currentChar == chars.length():
			currentChar = 0
		currentCharLabel.text = chars.substr(currentChar,1)
	elif Input.is_action_just_pressed("left"):
		currentChar -= 1
		if currentChar == -1:
			currentChar = chars.length()-1
		currentCharLabel.text = chars.substr(currentChar,1)
	elif Input.is_action_just_pressed("accept"):
		match selectedButton:
			0:
				$Password.text = $Password.text + currentCharLabel.text
			1:
				if Global.checkpointKeys.has($Password.text):
					Global.sceneManager.changeScene(Global.checkpointKeys[$Password.text])
					Global.playGameMusic()
			2:
				Global.sceneManager.changeScene("res://Scenes/TitleScreen.tscn")
		
	elif Input.is_action_just_pressed("cancel"):
		$Password.text = $Password.text.substr(0,$Password.text.length()-1)

