extends Area2D

var invincible = false
var health = 12
var dead = false

func damage(amount=1):
	
	if dead or invincible:
		return
	
	var delta = get_process_delta_time()
	
	health -= amount
	invincible = true
	$AudioStreamPlayer.play()
	
	if health <= 0:
		dead = true
	
	var val = 0
	while val < 1:
		$AnimatedSprite.visible = !$AnimatedSprite.visible
		val += delta
		yield(get_tree(),"idle_frame")
	
	invincible = false
	if dead:
		$"../WizardDeath".play()
		queue_free()
		
