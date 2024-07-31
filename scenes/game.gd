extends Control

var level = 1

var color_e = preload("res://scenes/element.tscn")
var elements = []

var impos = [0,0,0,0,0,0,0,1]

func _ready():
	
	$"Restart".hide()
	
	create_level(level)

func create_level(i):
	var r = randf_range(0, 1)
	var g = randf_range(0, 1)
	var b = randf_range(0, 1)
	var real_color = Color(r, g, b)

	impos.shuffle()
	$"LevelText".text = "Level " + str(level)
	for a in elements:
		a.queue_free()
	elements = []
	for j in range(8):
		var inste = color_e.instantiate()
		inste.position = Vector2(j * 100 + 206, 140)
		add_child(inste)
		elements.append(inste)
		if impos[j] == 1:
			var ra = randi() % 3
			
			var adjusted_color = Color(
				clamp(r + (randf_range(-1.0 / level, 1.0 / level) if ra == 0 else 0), 0, 1),
				clamp(g + (randf_range(-1.0 / level, 1.0 / level) if ra == 1 else 0), 0, 1),
				clamp(b + (randf_range(-1.0 / level, 1.0 / level) if ra == 2 else 0), 0, 1)
			)
			inste.set_color(adjusted_color)
			inste.set_imp(true)
		else:
			inste.set_imp(false)
			inste.set_color(real_color)

func loose():
	
	$"LevelText".text = "Level " + str(level) + "\nWRONG!"
	await get_tree().create_timer(0.5).timeout
	for a in elements:
		
		if not a.is_impo:
			
			a.queue_free()
		else:
			a.f_end()
	elements = []
	
	$"Restart".show()

func next():
	$"LevelText".text = "Level " + str(level) + "\nCORRECT!"
	await get_tree().create_timer(1).timeout
	level += 1
	create_level(level)


func _on_restart_button_down():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
