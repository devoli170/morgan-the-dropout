class_name Blade
extends Node2D

@export var seed_pos = Vector2(0,0)
@export var head_pos = Vector2(0,0)
@export var touched = false
@export var touch_point = Vector2(0,0)
@export var touch_x_direction = -1

var rand_max = 0.6
var anim_time = 1
var anim_timer = 0.0


func _ready():
	randomize()
	rand_max = randf_range(0.5,0.67)
	
func _process(delta: float) -> void:
	if head_pos.y > seed_pos.y * rand_max:
		head_pos += Vector2.UP * 0.5 
		queue_redraw()
		
	if touched:
		anim_timer += delta
		if anim_timer > anim_time:
			touched = false
			anim_timer = 0.0
		if touch_point.y > seed_pos.y:
			touch_point.y = seed_pos.y
		queue_redraw()

func _draw() -> void:
	if !touched:
		draw_line(seed_pos, head_pos, Color.GREEN, 4, true)
	if touched:
		var grass_line = PackedVector2Array([seed_pos, touch_point])
		var bend_len = abs(head_pos.y - touch_point.y)
		var numPoints = int(bend_len)
		if numPoints % 2 != 0:
			numPoints -= 1
		var force = clamp(abs(touch_x_direction), 15, 30)
		for x in range(numPoints):
			var newPoint = touch_point + x * Vector2.UP / (0.025 * force**1.4)
			if touch_x_direction < 0:
				## Some parabolic here. The bigger the abs(x), the smaller the Left increase				
				newPoint += Vector2.LEFT * 0.0025 * force * x ** 1.5
			else:				
				newPoint += Vector2.RIGHT * 0.0025 * force * x ** 1.5
			grass_line.append(newPoint)

		# TODO: add other bent vectors
		draw_polyline(grass_line, Color.GREEN,2,true)
