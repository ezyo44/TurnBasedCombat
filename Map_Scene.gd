extends Node2D

@onready var scroll_container = $CanvasLayer/PanelContainer/TextureRect/ScrollContainer
@onready var saverLoader = $SaverLoader as SaverLoader
# Called when the node enters the scene tree for the first time.
func _ready():
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
	saverLoader.load_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


