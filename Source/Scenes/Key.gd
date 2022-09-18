extends Area2D

func _ready():
	$AnimationPlayer.play("default")

func _on_Key_body_entered(body):
	if body.is_in_group("player"):
		body.hasKey = true
		queue_free()
