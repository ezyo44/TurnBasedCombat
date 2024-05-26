extends Node

@export var skill_set:PackedScene
@onready var HboxContainer= $"../CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer"
@export var Standart_button:PackedScene
var button
# Called when the node enters the scene tree for the first time.
func _ready():

	
	self.add_child(skill_set.instantiate())
	

	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_skills_pressed():
	
	_skill_pressed()
	if HboxContainer.get_child_count()==3:
		_init_skills()
		for skill_sets in self.get_children():
			for skill in skill_sets.get_children():
				
				button = Standart_button.instantiate() as Button
				button.name=skill.name_of
				button.text=skill.name_of
				HboxContainer.add_child(button)
				
				button.pressed.connect(skill._effect)
				button.pressed.connect(_skill_pressed)

				
func _init_skills():
	for skill_sets in self.get_children():
		for skill in skill_sets.get_children():
			skill.text_box_controller=$"../Text_Box_Controller"
			skill.player_health_bar=$"../CanvasLayer/PlayerContainer/VBoxContainer/ProgressBar"
			skill.health_controller=$"../Health_component"
			if "enemy_container" in skill:
				skill.enemy_container=get_tree().get_first_node_in_group("Enemies")
				
func _skill_pressed():
	for _i in HboxContainer.get_children():

		print(_i.name)
		_i.visible=!_i.visible
