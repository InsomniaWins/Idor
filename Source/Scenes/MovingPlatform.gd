tool
extends StaticBody2D

export(Array,Vector2) var followPath
export(int) var width = 1 setget setWidth
export(float) var moveSpeed = 100
export(float) var pauseInterval = 1 setget setPauseInterval

var direction = 1
var currentPosition = 0
var timeUntilMove = 0

func _physics_process(delta):
	var prevPosition = position
	
	if timeUntilMove <= 0.0:
		if followPath.size() > 1:
			if currentPosition + direction < followPath.size() and currentPosition + direction > -1:
				
				if position.distance_to(followPath[currentPosition+direction]) < 1:
					
					currentPosition += direction
					position = followPath[currentPosition]
					timeUntilMove = pauseInterval
				
				else:
					
					position = position.move_toward(followPath[currentPosition+direction],moveSpeed*delta)
					
				
			else:
				
				direction = -direction
	else:
		timeUntilMove -= delta
	
	constant_linear_velocity = (position-prevPosition)/delta
	

func setPauseInterval(value:float):
	pauseInterval = value

func setWidth(value):
	width = value
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.position.x = width*8
	$CollisionShape2D.shape.extents.x = width*8
	$TextureRect.rect_size.x = width*16
