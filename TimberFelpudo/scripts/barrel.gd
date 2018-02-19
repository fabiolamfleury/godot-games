extends Node2D

const LEFT = 0
const RIGHT = 1

func _ready():
	pass

func destroy(orientation):
	if orientation == LEFT:
		get_node("AnimationPlayer").play("barrel_right")
	elif orientation == RIGHT:
		get_node("AnimationPlayer").play("barrel_left")