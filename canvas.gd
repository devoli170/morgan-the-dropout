extends Node2D

var mouse_pos := Vector2(0,0)
var prev_mouse_pos := Vector2(0,0)
@onready var seeder :CornSeed = $Seeder

var seeds = []
var max_seeds = 50
var seed_cd = 0.05
var seed_buff = 0.0

var bladeScene  = preload("res://blade.tscn")
var blades = {}

func _ready() -> void:
	Input.emulate_mouse_from_touch = true

func _process(delta: float) -> void:
	if prev_mouse_pos == Vector2(0,0):
		prev_mouse_pos = get_local_mouse_position()
	mouse_pos = get_local_mouse_position()
	
	var mouse_delta = mouse_pos.x - prev_mouse_pos.x
	for bladeX in blades:
		if blades[bladeX].touched:
			continue
		if prev_mouse_pos.y > blades[bladeX].head_pos.y:
			if mouse_delta > 0:
				if prev_mouse_pos.x < bladeX && bladeX < mouse_pos.x:
						blades[bladeX].touched = true
						blades[bladeX].touch_point = Vector2(bladeX, prev_mouse_pos.y) # mouse y good enough
						blades[bladeX].touch_x_direction = mouse_delta
			else:
				if prev_mouse_pos.x > bladeX && bladeX > mouse_pos.x:
					blades[bladeX].touched = true
					blades[bladeX].touch_point = Vector2(bladeX, prev_mouse_pos.y) # mouse y good enough
					blades[bladeX].touch_x_direction = mouse_delta
	
	prev_mouse_pos = mouse_pos
	# TODO: calculate blade intersects and direction of mouse
	
	queue_redraw()
	
	seed_buff += delta
	if Input.is_action_pressed("Click"):
		
		if seeds.size() < max_seeds:
			if seed_buff >= seed_cd:
				if blades.has(seeder.p.x):
					return
				seeds.append(seeder.p)
				var newBlade = bladeScene.instantiate()
				newBlade.seed_pos = seeder.p 
				newBlade.seed_pos.y -= 5
				newBlade.head_pos = newBlade.seed_pos
				add_child(newBlade)			
				blades[seeder.p.x]=(newBlade)
				seed_buff = 0.0
		else:
			$Seeder.full = true
			

func _draw() -> void:
	#draw_circle(mouse_pos,10,Color.RED,false,2,true)	
	for seed in seeds:
		draw_circle(seed, 5, Color.SADDLE_BROWN)
