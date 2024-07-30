extends StaticBody2D
@onready var game := get_parent()


var is_impo
var end = false

func set_imp(b):
	is_impo = b


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and not end:
		
		if is_impo:
			game.next()
		else:
			game.loose()

func f_end():
	
	end = true

func set_color(r_c):
	$"Color".color = r_c
