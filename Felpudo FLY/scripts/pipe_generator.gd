extends Position2D

onready var pipe = preload("res://scenes/pipe.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	var new_pipe = pipe.instance()
	new_pipe.set_pos(get_pos() + Vector2(0, rand_range(-500, 500)))
	get_owner().add_child(new_pipe)