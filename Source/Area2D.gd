tool
extends Area2D

export(String,FILE) var toScene = ""
export(Vector2) var toPosition = Vector2()
export(int) var width = 16 setget setWidth
export(int) var height = 16 setget setHeight


func setWidth(value):
	width = value
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.extents.x = width/2
	$CollisionShape2D.position.x = width/2

func setHeight(value):
	height = value
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.extents.y = height/2
	$CollisionShape2D.position.y = height/2


func _on_LevelTransition_body_entered(body):
	if body.is_in_group("player"):
		Global.sceneManager.changeLevel(toScene,toPosition)
