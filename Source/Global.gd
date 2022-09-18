extends Node

var sceneManager
var gameMusic

var saveDetails = {
	"currentScene":null,
	"playerPosition":null,
	"checkpoint":"",
	"magic":0
}

var checkpointKeys = {
	"AB23":"res://Scenes/Level3B.tscn",
	"ABC1":"res://Scenes/Level4.tscn",
	"ACB6":"res://Scenes/Level6.tscn",
	"BOSS":"res://Scenes/Level7.tscn"
}

func _ready():
	resizeScreen()
	get_tree().connect("screen_resized",self,"resizeScreen")

func findCheckpoint(fileName):
	for i in checkpointKeys.keys():
		if checkpointKeys[i] == fileName:
			return i

func playGameMusic():
	
	if !is_instance_valid(gameMusic):
		gameMusic = AudioStreamPlayer.new()
		add_child(gameMusic)
	
	gameMusic.stream = preload("res://Sounds/GameplayMusic.mp3")
	gameMusic.play()

func pauseGameMusic():
	gameMusic.stream_paused = true

func resumeGameMusic():
	gameMusic.stream_paused = false

func stopGameMusic():
	if is_instance_valid(gameMusic):
		gameMusic.stop()

func saveGame():
	var saveFile = File.new()
	var saveString = to_json(saveDetails)
	
	saveDetails.currentScene = sceneManager.currentScene
	
	saveFile.open("res://SaveFile.save",saveFile.WRITE)
	saveFile.store_string(saveString)
	saveFile.close()

func loadGame():
	var saveFile = File.new()
	saveFile.open("res://SaveFile.save",saveFile.READ)
	var saveString = saveFile.get_as_text()
	saveFile.close()
	saveDetails = JSON.parse(saveString)
	sceneManager.changeScene(saveDetails.currentScene)

func playSound(sound):
	if sound is String:
		sound = load(sound)
	
	var audioStreamPlayer = AudioStreamPlayer.new()
	audioStreamPlayer.connect("finished",audioStreamPlayer,"queue_free")
	audioStreamPlayer.stream = sound
	add_child(audioStreamPlayer)
	audioStreamPlayer.play()
	return audioStreamPlayer

func resizeScreen():
	var window_size = OS.get_window_size()
	var base_resolution = Vector2(256,224)
	
	# see how big the window is compared to the viewport size
	# floor it so we only get round numbers (0, 1, 2, 3 ...)
	var scale_x = floor(window_size.x / base_resolution.x)
	var scale_y = floor(window_size.y / base_resolution.y)
	
	# use the smaller scale with 1x minimum scale
	var scale = max(1, min(scale_x, scale_y))
	
	var viewport = get_viewport()
	
	viewport.size_override_stretch = true
	viewport.set_size_override(true, base_resolution)
	
	# multiply screen size by scale to avoid pixelation of animations (sub pixels)
	# do not multiply if you would like to keep the pixelation of sub pixels (nothing smaller than a pixel will render)
	viewport.size = base_resolution
	
	# find the coordinate we will use to center the viewport inside the window
	var diff = window_size - (base_resolution * scale)
	var diffhalf = (diff * 0.5).floor()
	
	# attach the viewport to the rect we calculated
	viewport.set_attach_to_screen_rect(Rect2(diffhalf, base_resolution*scale))
	
	#aspect bars
	VisualServer.black_bars_set_margins(diffhalf.x,diffhalf.y,diffhalf.x,diffhalf.y)
