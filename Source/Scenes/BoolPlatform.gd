tool
extends StaticBody2D

export var active = false setget setActive

export(int) var width = 1 setget setWidth
export(int) var height = 1 setget setHeight

func setActive(value):
	active = value
	if active:
		$Out.visible = true
		$CollisionShape2D.call_deferred("set","disabled",false)
	else:
		$Out.visible = false
		$CollisionShape2D.call_deferred("set","disabled",true)

func setWidth(value):
	width = value
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.extents.x = width*8
	$CollisionShape2D.position.x = width*8
	$In.rect_size.x = width*16
	$Out.rect_size.x = width*16

func setHeight(value):
	height = value
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.extents.y = height*8
	$CollisionShape2D.position.y = height*8
	$In.rect_size.y = height*16
	$Out.rect_size.y = height*16
