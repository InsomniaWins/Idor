extends RigidBody2D

var velocity = Vector2() setget setVelocity

func _ready():
	$AnimationPlayer.play("default")

func setVelocity(value):
	linear_velocity = value

func _integrate_forces(state):
	rotation = 0
	angular_velocity = 0
