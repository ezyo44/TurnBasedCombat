extends Node

@export var skill_set:PackedScene
@onready var VboxContainer= $"../CanvasLayer/SkillPanel/ScrollContainer/VBoxContainer"
@onready var SkillPanel=$"../CanvasLayer/SkillPanel"
@export var Standart_button:PackedScene
var button
# Called when the node enters the scene tree for the first time.
func _ready():

	
	self.add_child(skill_set.instantiate())
	_check_interface()

	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _check_interface():
	for skill in self.get_children():
			Interface.node_implements_interface(skill,Interface.SkillInterface)

func _on_skills_pressed():
	_skill_pressed()
	
	for skill_sets in self.get_children():
		for skill in skill_sets.get_children():
			if VboxContainer.get_child_count() !=skill_sets.get_child_count():
				_init_skills()
				button = Standart_button.instantiate() as Button
				button.custom_minimum_size.y=100
				button.name=skill.name_of
				button.text=skill.name_of
				VboxContainer.add_child(button)
			
				button.pressed.connect(skill._effect)
				button.pressed.connect(_skill_pressed)

				
func _init_skills():
	for skill_sets in self.get_children():
		for skill in skill_sets.get_children():
			skill.text_box_controller=$"../Text_Box_Controller"
			skill.player_health_bar=$"../CanvasLayer/PlayerContainer/VBoxContainer/ProgressBar"
			skill.health_controller=$"../Health_component"
			skill.mana_bar=$"../CanvasLayer/PlayerContainer/VBoxContainer/ManaBar"
			skill.mana_controller=$"../Mana_component"
			if "enemy_container" in skill:
				skill.enemy_container=get_tree().get_first_node_in_group("Enemies")
				
func _skill_pressed():
		SkillPanel.visible=!SkillPanel.visible
		for _i in VboxContainer.get_children():
			
			print(_i.name)
			
		
