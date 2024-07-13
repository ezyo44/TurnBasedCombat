extends Node2D

@onready var scroll_container = $CanvasLayer/PanelContainer/TextureRect/ScrollContainer
@onready var saverLoader = $SaverLoader as SaverLoaderMapScene
@onready var VboxContainer = $CanvasLayer/PanelContainer/TextureRect/ScrollContainer/VBoxContainer
var buttons_to_enable:Array[TextureButton]
# Called when the node enters the scene tree for the first time.
func _ready():
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
	saverLoader.load_game()
	for button in VboxContainer.get_children():
		if button is TextureButton:
			if button.disabled == false:
				buttons_to_enable.append(button)
				button.disabled = true
			elif button.disabled == true:
				break
				
	if buttons_to_enable.size() != 0:
		buttons_to_enable[buttons_to_enable.size()-1].disabled=false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


