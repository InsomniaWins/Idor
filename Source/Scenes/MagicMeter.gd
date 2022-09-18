extends Control

var value = 1.0 setget setValue

func setValue(val):
	value = val
	$Progress.rect_size.x = rect_size.x*value
