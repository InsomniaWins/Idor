extends StaticBody2D

func interact():
	$CollisionShape2D.call_deferred("set","disabled",true)
	open()

func open():
	$AnimationPlayer.play("bob")

func _on_AnimationPlayer_animation_finished(_anim_name):
	var itemLoad = load("res://Scenes/MagicPickup.tscn")
	var parent = get_parent()
	for i in 3:
		var itemInstance = itemLoad.instance()
		itemInstance.position = global_position
		itemInstance.velocity = Vector2(
			randi()%100-50,
			randf()*-100
		)
		parent.add_child(itemInstance)
	queue_free()
