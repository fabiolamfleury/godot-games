extends Node2D

onready var felpudo = get_node("Felpudo")
onready var points_marker_label = get_node("ControlNode/Control/PointsMarkerLabel")

var points = 0
var state = 1

const PLAYING_STATE = 1
const LOSE_STATE = 0

func _ready():
	pass


# once timer to replay timed out restart game
func _on_TimerToReplay_timeout():
	get_tree().reload_current_scene()
	
# stop animations and change game state 
func kill():
	felpudo.apply_impulse(Vector2(0,0), Vector2(-1000, 0))
	get_node("BackgroundAnimation").stop()
	state = LOSE_STATE
	get_node("HitSound").play()
	get_node("TimerToReplay").start()

func mark_point():
	points += 1
	points_marker_label.set_text(str(points))
	get_node("ScoreSound").play()
