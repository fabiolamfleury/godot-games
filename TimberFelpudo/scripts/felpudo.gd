extends Node2D

onready var idle = get_node("Idle")
onready var hit = get_node("Hit")
onready var grave = get_node("Grave")
onready var animation = get_node("Animation")

var side;
const LEFT = 0
const RIGHT = 1

func _ready():
	idle.show()
	hit.hide()
	pass
func left():
	set_pos(Vector2(220, 1070))
	side = LEFT
	idle.set_flip_h(false)
	hit.set_flip_h(false)
	grave.set_pos(Vector2(-44, 41))
	grave.set_flip_h(true)
	
func right():
	set_pos(Vector2(500, 1070))
	side = RIGHT
	idle.set_flip_h(true)
	idle.set_flip_h(true)
	grave.set_pos(Vector2(28, 41))
	grave.set_flip_h(false)

func hitting():
	animation.play("Hitting")
	
func dies():
	animation.stop()
	idle.hide()
	hit.hide()
	grave.show()