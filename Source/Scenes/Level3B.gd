extends Level

func _ready():
	$AnimationPlayer.play("MovingPlatform")
	Global.saveDetails.checkpoint = Global.findCheckpoint(filename)

func _on_BoolActivator_valueChanged():
	$BoolPlatform.call_deferred("set","active",!$BoolPlatform.active)
	$BoolPlatform2.call_deferred("set","active",!$BoolPlatform2.active)
	$BoolPlatform3.call_deferred("set","active",!$BoolPlatform3.active)
	$BoolPlatform4.call_deferred("set","active",!$BoolPlatform4.active)
