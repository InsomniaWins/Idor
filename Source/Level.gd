class_name Level
extends Node2D

export(float) var musicPitch = 1

func _ready():
	
	if is_instance_valid(Global.gameMusic):
		Global.gameMusic.pitch_scale = musicPitch
	
	var cam:Camera2D = find_node("Camera2D")
	var camRegion:ReferenceRect = find_node("CamRegion")
	if is_instance_valid(cam) and is_instance_valid(camRegion):
		cam.limit_left = camRegion.rect_position.x
		cam.limit_top = camRegion.rect_position.y
		cam.limit_right = camRegion.rect_position.x+camRegion.rect_size.x
		cam.limit_bottom = camRegion.rect_position.y+camRegion.rect_size.y
