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
# Called when the node enters the scene tree for the first time.
func _ready():
	mana_cost=2
	name_of="Heal" # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _effect():
	if PlayerStats.player_turn && mana_cost<=mana_bar.value: 
		mana_controller._spend_energy(mana_bar,mana_cost)
		if player_health_bar.value==player_health_bar.max_value:
			text_box_controller._display_text("Player Health already full")
		else :
			text_box_controller._display_text("The "+ PlayerStats.player_name +" healed for %d " % 10)
			health_controller._heal(player_health_bar,10)

			await get_tree().create_timer(1).timeout
			PlayerStats.player_turn_finished.emit()
