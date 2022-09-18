extends Area2D

var moveSpeed = 200
var direction = Vector2()

func _physics_process(delta):
	position += direction*delta*moveSpeed

func _on_FreeTimer_timeout():
	queue_free()

func _on_PlayerMagic_body_entered(body):
	if body is TileMap:
		queue_free()
		return
	
	if body.is_in_group("damagedByMagic"):
		body.damage(1)
		queue_free()
		return

func _on_PlayerMagic_area_entered(area):
	if area.is_in_group("damagedByMagic"):
		area.damage(1)
		queue_free()
		return
