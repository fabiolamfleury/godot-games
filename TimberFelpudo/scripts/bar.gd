extends Node2D

onready var marker = get_node("Marker")

var porcentage = 1
signal lose

func _ready():
	set_process(true)
	
func _process(delta):
	if porcentage > 0:
		porcentage -= 0.1 * delta
		marker.set_region_rect(Rect2(0,0, porcentage * 188, 23))
		marker.set_pos(Vector2(-(1-porcentage) * 188 / 2, 0))
	else:
		emit_signal("lose")
		
func add_time(delta):
	porcentage += delta
	if porcentage == 1:
		porcentage = 1
