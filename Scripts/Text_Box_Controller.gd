extends Node
class_name Text_box_controller

@export var text_box:Panel
@export var text_box_label:Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _display_text(text):
	text_box.show()
	text_box_label.text=text

func _hide_text():
	text_box.hide()
	

func _on_enemy_container_gui_input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and text_box.visible:
		text_box.hide()
		emit_signal("textbox_closed") 
