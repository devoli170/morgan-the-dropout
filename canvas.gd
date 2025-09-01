extends Node2D

var p := Vector2(0,0)

func _ready() -> void:
	Input.emulate_touch_from_mouse = true

func _process(delta: float) -> void:
	p = get_local_mouse_position()
	queue_redraw()

func _draw() -> void:
	draw_circle(p,10,Color.RED,false,2,true)
	
	
