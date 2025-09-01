class_name CornSeed
extends Node2D

@export var p := Vector2(0,0)
@export var full := false

func _ready() -> void:
	Input.emulate_touch_from_mouse = true
	
	var vp_max_y := int(get_viewport_rect().size.y)
	p = Vector2(0, vp_max_y)

func _process(delta: float) -> void:
	p.x = get_local_mouse_position().x
	queue_redraw()

func _draw() -> void:
	if ! full:
		draw_circle(p, 5, Color.SADDLE_BROWN)
		draw_line(p+Vector2.UP*5, p+Vector2.UP*8,Color.GREEN)
	#draw_circle(p,10,Color.GREEN,false,2,true)
	
	
