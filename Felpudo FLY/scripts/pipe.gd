extends Node2D

export var velocity = -400

var scene

func _ready():
	scene = get_tree().get_current_scene()
	set_process(true)
	
	
func _process(delta):
	if scene.state == scene.PLAYING_STATE:
		set_pos(get_pos() + Vector2(velocity * delta, 0))
	
	if get_pos().x < -100:
		queue_free()


func _on_Area2D_body_enter( body ):
	if body.get_name() == "Felpudo":
		scene.kill()


func _on_PointMarker_body_enter( body ):
	scene.mark_point()
