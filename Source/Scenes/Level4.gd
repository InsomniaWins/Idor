extends Level
onready var movingPlatform = $MovingPlatformA/MovingPlatform
onready var prevPlatformPosition = movingPlatform.position

func _ready():
	Global.saveDetails.checkpoint = Global.findCheckpoint(filename)
	$MovingPlatformA.play("Default")
	$MovingPlatformA.seek(4)

func _physics_process(delta):
	movingPlatform.constant_linear_velocity = (movingPlatform.position - prevPlatformPosition) / delta
	prevPlatformPosition = movingPlatform.position


func _on_BoolActivator_valueChanged():
	$BoolPlatform.active = !$BoolPlatform.active

func _on_BoolActivator2_valueChanged():
	$BoolPlatform2.active = !$BoolPlatform2.active
