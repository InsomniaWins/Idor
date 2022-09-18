extends Area2D

signal valueChanged

var value = 0 setget setValue

func setValue(val):
	$Sound.play()
	value = val
	$TextureRect.frame = value
	emit_signal("valueChanged")

func _on_BoolActivator_area_entered(area):
	if area.is_in_group("magicBullet"):
		setValue(!value)
		area.queue_free()

func _on_BoolActivator_body_entered(body):
	if body.is_in_group("player"):
		setValue(!value)
