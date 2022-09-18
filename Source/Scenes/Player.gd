extends KinematicBody2D

const MAGIC_BOLT = preload("res://Scenes/PlayerMagic.tscn")

var moveSpeed = 170
var acceleration = 550
var jumpSpeed = 250
var gravityJumping = 456
var gravityNormal = 800
var gravity = gravityNormal
var terminalVelocity = 300
var velocity = Vector2()
var magic:float = 5
var maxMagic:float = 5 setget setMaxMagic
var health:float = 3 setget setHealth
var maxHealth:float = 3 setget setMaxHealth
var hasKey = false
var snap:Vector2
var invincible = false

onready var parent = get_parent()
onready var magicMeter = $CanvasLayer/MagicMeter
onready var healthMeter = $CanvasLayer/HealthMeter

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.is_action("shoot"):
				
				if magic > 0:
					$MagicSound.play()
					var bulletInstance = MAGIC_BOLT.instance()
					bulletInstance.position = global_position
					bulletInstance.direction = Vector2($AnimatedSprite.scale.x,0)
					parent.add_child(bulletInstance)
					magic -= 1
				
			elif event.is_action("interact"):
				if $AnimatedSprite/InteractRay.is_colliding():
					var collider = $AnimatedSprite/InteractRay.get_collider()
					if collider.is_in_group("interactable"):
						collider.interact()

func setMaxHealth(value):
	maxHealth = value
	health = clamp(health,0,maxHealth)
	healthMeter.rect_size.x = maxHealth*11
	healthMeter.value = float(health)/float(maxHealth)

func setHealth(value):
	health = value
	healthMeter.value = float(health)/float(maxHealth)

func setMaxMagic(value):
	maxMagic = value
	magic = clamp(magic,0,maxMagic)
	magicMeter.rect_size.x = maxMagic*3
	magicMeter.value = float(magic)/float(maxMagic)
	

func damage(amount=1):
	if invincible:
		return
	
	invincible = true
	health -= amount
	setHealth(health)
	
	if health < 1:
		killed()
	
	$DamageSound.play()
	
	var i = 0
	while i < 1:
		var delta = get_process_delta_time()
		
		$AnimatedSprite.visible = !$AnimatedSprite.visible
		
		i += delta
		yield(get_tree(),"idle_frame")
	
	invincible = false
	$AnimatedSprite.visible = true

func killed():
	if is_instance_valid(Global.sceneManager):
		Global.sceneManager.changeScene("res://Scenes/GameOverScreen.tscn")
	else:
		get_tree().reload_current_scene()

func _ready():
	$AnimatedSprite/InteractRay.add_exception(self)
	$AnimatedSprite/InteractRay.add_exception($Area2D)

func _physics_process(delta):
	
	$CanvasLayer/MagicMeter.value = magic/maxMagic
	
	var walkInput = int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left"))
	
	velocity.y += gravity*delta
	velocity.y = min(velocity.y,terminalVelocity)
	
	velocity.x = move_toward(velocity.x,walkInput*moveSpeed,acceleration*delta)
	velocity.x = clamp(velocity.x,-moveSpeed,moveSpeed)
	
	snap = Vector2.DOWN * 8 if is_on_floor() else Vector2.ZERO
	
	if is_on_floor():
		$AnimatedSprite.animation = "walk"
		
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jumpSpeed
			gravity = gravityJumping
			$Jump.pitch_scale = randf()*.6+.4
			$Jump.play()
			snap = Vector2.ZERO
			
	else:
		$AnimatedSprite.animation = "jump"
	
	velocity = move_and_slide_with_snap(velocity,snap,Vector2.UP)
	
	if !Input.is_action_pressed("jump"):
		gravity = gravityNormal
	
	if walkInput != 0:
		$AnimatedSprite.scale.x = sign(walkInput)
	
	if velocity.x == clamp(velocity.x,-.1,.1):
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 1
	else:
		$AnimatedSprite.playing = true
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("magic") and magic < maxMagic:
		body.queue_free()
		magic += 1
	elif body.is_in_group("interactable"):
		body.interact()
