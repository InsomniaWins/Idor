extends Area2D

var moveSpeed = 60
var dir = -1
var health = 1
var scared = false

onready var sprite = $AnimatedSprite
onready var wallDetection = $AnimatedSprite/WallDetection

func damage(amount=1):
	health -= amount
	
	$DamageSound.play()
	
	var i = 0
	while i < 1:
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
		if collider is TileMap or collider.is_in_group("door") or collider.is_in_group("boolPlatform"):
			dir = -dir
			sprite.scale.x = -dir
	
	position.x += dir*moveSpeed*delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if !scared:
			$Scream.play()
			scared = true
			moveSpeed = 120

func _on_Citizen_body_entered(body):
	if "velocity" in body:
		if "snap" in body:
			body.snap = Vector2.ZERO
		body.velocity.y = -400
		body.velocity = body.move_and_slide(body.velocity,Vector2.UP)
