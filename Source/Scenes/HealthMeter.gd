extends Control

var value:float = 0 setget setValue

func setValue(val):
	value = val
	$Front.rect_size.x = rect_size.x*value
