tool
extends Area2D

export(int) var width = 1 setget setWidth
export(int) var height = 1 setget setHeight

func setWidth(value):
	width = value
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.extents.x = width*8
	$CollisionShape2D.position.x = width*8

func setHeight(value):
	height = value
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.extents.y = height*8
	$CollisionShape2D.position.y = height*8

func _on_WaterDamage_body_entered(body):
	if Engine.editor_hint:
		return
	
	if body.is_in_group("player"):
		body.damage(1)
		body.velocity.y = -370
	
	
