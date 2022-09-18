extends Level

func _ready():
	Global.saveDetails.checkpoint = Global.findCheckpoint(filename)

func _on_BoolActivator2_valueChanged():
	$BoolPlatform.active = !$BoolPlatform.active
	$BoolPlatform4.active = !$BoolPlatform4.active
	$BoolPlatform5.active = !$BoolPlatform5.active


func _on_BoolActivator4_valueChanged():
	$BoolPlatform3.active = !$BoolPlatform3.active
	$BoolPlatform2.active = !$BoolPlatform2.active


func _on_BoolActivator_valueChanged():
	$BoolPlatform6.active = !$BoolPlatform6.active
