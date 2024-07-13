extends Node2D

var implements = Interface.SkillInterface
@onready var player_health_bar:ProgressBar
@onready var enemy_health_bar:ProgressBar
@onready var text_box_controller:Text_box_controller
@onready var health_controller:Health_component
@onready var mana_bar:ProgressBar
@onready var mana_controller:Mana_component
var enemy_container
var mana_cost:int
@onready var name_of=""
signal disable_buttons
# Called when the node enters the scene tree for the first time.
func _ready():
	mana_cost=4
	name_of="Double Attack" # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _effect():
	if PlayerStats.player_turn && mana_cost <= mana_bar.value: 
		mana_controller._spend_energy(mana_bar,mana_cost)
		var _double_damage_value=PlayerStats.damage*2-PlayerStats.damage/2
		text_box_controller._display_text("The "+ enemy_container.enemy.name + 
		" was Attacked twice for %d damage" % _double_damage_value )
		disable_buttons.emit()
		PlayerStats.attack_enemy_twice.emit()
		
		PlayerStats.player_turn=false

		await get_tree().create_timer(1).timeout
		PlayerStats.player_turn_finished.emit()
		
