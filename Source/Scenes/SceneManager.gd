extends Control

signal fadedToBlack
signal fadedFromBlack

var prevScene = ""
var changingScene = false
var fadeSpeed = 6
var currentScene = ""
var paletteColors = [
	Color("37364E"),
	Color("6AAE9D"),
	Color("B9D4B4"),
	Color("F4E9D4"),
	Color("D0BAA9"),
	Color("9E8E91"),
	Color("355D69"),
	Color("5B4A68")
] setget setPaletteColors

onready var fadeRect = $CanvasLayer/FadeRect

func _ready():
	Global.sceneManager = self
	currentScene = $CurrentScene.get_child(0).filename
	updatePaletteColors()

func changeScene(path,fadeColor=Color.black):
	
	fadeColor.a = 0.0
	
	if changingScene:
		return
	
	changingScene = true
	
	$CanvasLayer/FadeRect.color = fadeColor
	
	fadeToBlack()
	yield(self,"fadedToBlack")
	
	setScene(path)
	
	changingScene = false
	
	fadeFromBlack()
	
	

func setScene(path):
	prevScene = currentScene
	
	$CurrentScene.get_child(0).queue_free()
	var nextScene = load(path).instance()
	$CurrentScene.add_child(nextScene)
	
	currentScene = path
	return nextScene

func fadeToBlack():
	
	while fadeRect.color.a < 1.0 and changingScene:
		var delta = get_process_delta_time()
		fadeRect.color.a += delta*fadeSpeed
		yield(get_tree(),"idle_frame")
	emit_signal("fadedToBlack")

func fadeFromBlack():
	while fadeRect.color.a > 0.0 and !changingScene:
		var delta = get_process_delta_time()
		fadeRect.color.a -= delta*fadeSpeed
		yield(get_tree(),"idle_frame")
	emit_signal("fadedFromBlack")

func changeLevel(level,pos):
	
	if changingScene:
		return
	
	changingScene = true
	
	fadeToBlack()
	yield(self,"fadedToBlack")
	
	var nextScene = setScene(level)
	
	changingScene = false
	
	var player = nextScene.find_node("Player")
	
	fadeFromBlack()
	
	player.position = pos

func setPaletteColors(value):
	paletteColors = value
	updatePaletteColors()

func updatePaletteColors():
	for i in paletteColors.size():
		$CanvasLayer/ColorRect.material.set_shader_param("color_"+str(i+1),paletteColors[i])
