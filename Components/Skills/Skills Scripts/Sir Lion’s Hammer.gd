extends Node2D

var implements = Interface.SkillInterface
@onready var player_health_bar:ProgressBar
@onready var enemy_health_bar:ProgressBar
@onready var text_box_controller:Text_box_controller
@onready var health_controller:Health_component
@onready var mana_bar:ProgressBar
@onready var mana_controller:Mana_component
var mana_cost
@onready var name_of=""
signal disable_buttons
# Called when the node enters the scene tree for the first time.
func _ready():
	mana_cost=6
	name_of="Sir Lions Hammer" # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _effect():
	if PlayerStats.player_turn && mana_cost<=mana_bar.value: 
		mana_controller._spend_energy(mana_bar,mana_cost)

func _disable_buttons():
		$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Attack.disabled=true
		$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Defende.disabled=true
		$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Skills.disabled=true
		print("Buttons Disabled")
