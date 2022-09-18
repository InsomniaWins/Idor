extends Area2D

var moveSpeed = 80
var dir = -1
var health = 2

onready var sprite = $AnimatedSprite
onready var wallDetection = $AnimatedSprite/WallDetection

func damage(amount=1):
	health -= amount
	
	if health < 1:
		killed()
		return
	
	$DamageSound.play()
	
	var i = 0
	while i < .15:
		var delta = get_process_delta_time()
		
		sprite.visible = !sprite.visible
		
		i += delta
		yield(get_tree(),"idle_frame")
	
	sprite.visible = true

func killed():
	Global.playSound(preload("res://Sounds/GrayMageDeath.wav"))
	queue_free()

func _physics_process(delta):
	if wallDetection.is_colliding():
		var collider = wallDetection.get_collider()
		if collider is TileMap:
			dir = -dir
			sprite.scale.x = -dir
	
	position.x += dir*moveSpeed*delta
	

func _on_GrayMage_body_entered(body):
	if body.is_in_group("player"):
		body.damage()
