extends Node

const NORMAL = 0
const RIGHT = 1
const LEFT = 2

const PLAYING = 0
const LOSE = 1

var state = 0
var barrel = preload("res://scenes/barrel.tscn")
var left_barrel = preload("res://scenes/left_barrel.tscn")
var right_barrel = preload("res://scenes/right_barrel.tscn")

var last_enemy = false

onready var felpudo = get_node("Felpudo")
onready var camera = get_node("Camera")
onready var barrels = get_node("Barrels")
onready var destroy_barrels = get_node("DestroyBarrels")
onready var bar = get_node("Bar")
onready var points_label = get_node("Control/Points")

var points = 0

func _ready():	
	set_process_input(true)
	randomize()
	init()
	bar.connect("lose", self, "lose")

func _input(event):
	event = camera.make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		if event.pos.x < 360:
			felpudo.left()
		else:
			felpudo.right()
		felpudo.hitting()
		
		if not is_collision():
			felpudo.hitting()
			var first = barrels.get_children()[0]
			barrels.remove_child(first)
			destroy_barrels.add_child(first)
			first.destroy(felpudo.side)
			
			randomize_barrels(Vector2(360, 1090 - 10*172))
			go_down()
			bar.add_time(0.014)
			
			points += 1 
			points_label.set_text(str(points))
			
			if is_collision():
				lose()
		else:
			lose()
	
func randomize_barrels(position):
	var number = rand_range(0, 3)
	if last_enemy:
		number = 0
	generate_barrels(int(number), position)

func generate_barrels(type, position):
	var new_barrel = null
	if type == NORMAL:
		new_barrel = barrel.instance()
		last_enemy = false
	elif type == RIGHT:
		new_barrel = right_barrel.instance()
		last_enemy = true
		new_barrel.add_to_group("right_barrel")
	elif type == LEFT:
		new_barrel = left_barrel.instance()
		last_enemy = true
		new_barrel.add_to_group("left_barrel")
	else:
		print("Invalid barrel type")
	new_barrel.set_pos(position)
	barrels.add_child(new_barrel)

func init():
	for i in range(0,3):
		generate_barrels(NORMAL, Vector2(360, 1090 - i * 172))
		
	for i in range(3,10):
		randomize_barrels(Vector2(360, 1090 - i * 172))

func is_collision():
	var side = felpudo.side
	var first = barrels.get_children()[0]

	# collision
	if side == felpudo.LEFT and first.is_in_group("left_barrel"):
		return true
	elif side == felpudo.RIGHT and first.is_in_group("right_barrel"):
		return true
	else:
		return false	
		
			
func go_down():
	for barrel in barrels.get_children():
		barrel.set_pos(barrel.get_pos() + Vector2(0, 172))
		
func lose():
	felpudo.dies()
	bar.set_process(false)
	state = LOSE
	get_node("Timer").start()

func _on_Timer_timeout():
	get_tree().reload_current_scene()
