tool
extends StaticBody2D

export var locked = false setget setLocked
var opened = false
var closed = true

func setLocked(value):
	locked = value
	if locked:
		$Sprite.frame = 1
		$CollisionShape2D.call_deferred("set","disabled",false)
		
	else:
		$Sprite.frame = 0
		$CollisionShape2D.call_deferred("set","disabled",true)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		
		if locked:
			if body.hasKey:
				body.hasKey = false
				setLocked(false)
				open()
				
		else:
			if closed:
				open()

func open():
	opened = true
	closed = false
	$Sprite.visible = false

func close():
	opened = false
	closed = true
	$Sprite.visible = true

func _on_Area2D_body_exited(body):
	if opened:
		close()
