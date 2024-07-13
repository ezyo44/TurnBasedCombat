extends Node2D

@export var skill_set:PackedScene
@export var Standart_button:PackedScene
@onready var VboxContainer = $CanvasLayer/PanelContainer/VBoxContainer
@onready var Saver = $Saver
var button
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$sets.add_child(skill_set.instantiate())
	init_skill_sets()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_skill_sets():
	
	for skill_sets in $sets.get_children():
			if VboxContainer.get_child_count() !=skill_sets.get_child_count():
				button = Standart_button.instantiate() as Button
				button.custom_minimum_size.y=100
				button.name=skill_sets.name
				button.text=skill_sets.name

				VboxContainer.add_child(button)
				button.pressed.connect(skill_set_choosen)

func skill_set_choosen():

	var skill_manager = $Skill_manager as SkillManager
	PlayerStats.skills.append(skill_set)
	Saver.save_player_states()
	SceneSwitcher.switch_scene("res://Map_Scene.tscn")
