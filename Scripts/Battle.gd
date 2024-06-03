extends Node2D

@onready var text_box = $CanvasLayer/TextBox
@onready var text_box_label=$CanvasLayer/TextBox/Label
@onready var player_health_bar=$CanvasLayer/PlayerContainer/VBoxContainer/ProgressBar
@onready var enemy_health_bar
@onready var HboxContainer= $CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer
@onready var mana_bar=$CanvasLayer/PlayerContainer/VBoxContainer/ManaBar

@export var text_box_controller:Text_box_controller

@export var health_controller:Health_component
@export var mana_controller:Mana_component
@export var Enemy_scene:PackedScene

var enemy_container
var player_turn=true
signal attack_enemy
signal attack_enemy_twice
signal player_turn_finished
var enemy_instance
signal textbox_closed

# Called when the node enters the scene tree for the first time.
func _ready():
		
	enemy_instance=Enemy_scene.instantiate()

	get_node("CanvasLayer2").add_child(Enemy_scene.instantiate())
	enemy_container=get_node("CanvasLayer2/EnemyContainer")
	health_controller._set_health(player_health_bar,PlayerStats.current_health,PlayerStats.Max_health)
	mana_controller._set_mana(mana_bar,PlayerStats.current_mana,PlayerStats.max_mana)
	text_box_controller._hide_text() 
	text_box_controller._display_text("A " + enemy_container.enemy.name +" is Challanging you")
	
	enemy_container.player_health_bar=player_health_bar
	enemy_container.text_box_controller=text_box_controller
	enemy_container.attack_button=$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Attack
	enemy_container.defend_button=$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Defende
	enemy_container.skills_button=$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Skills
	PlayerStats.attack_enemy.connect(enemy_container._get_hit)
	PlayerStats.attack_enemy_twice.connect(enemy_container._get_hit_twice)
	PlayerStats.player_turn_finished.connect(enemy_container._enemy_turn)
	enemy_container.enemy_died.connect(_close_game)
	#PlayerStats.skill_pressed.connect(_skill_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _on_attack_pressed():
	
		PlayerStats.attack_enemy.emit()
		text_box_controller._display_text("The "+ enemy_container.enemy.name + 
		" was Attacked for %d damage" % PlayerStats.damage )
		
		_disable_buttons()
		PlayerStats.player_turn=false

		await get_tree().create_timer(1).timeout
		PlayerStats.player_turn_finished.emit()

func _on_defende_pressed():
	if(PlayerStats.player_turn): 
		text_box_controller._display_text("The "+ PlayerStats.player_name +" took a Block Stance")
		PlayerStats.is_defending=true
		_disable_buttons()
		await get_tree().create_timer(1).timeout
		PlayerStats.player_turn_finished.emit()

func _disable_buttons():
		$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Attack.disabled=true
		$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Defende.disabled=true
		$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Skills.disabled=true
		

func _heal():
	if(PlayerStats.player_turn): 
		text_box_controller._display_text("The "+ PlayerStats.player_name +" healed for %d " % 10)
		health_controller._heal(player_health_bar,10)

		await get_tree().create_timer(1).timeout
		PlayerStats.player_turn_finished.emit()
		
func _double_attack():
	if(PlayerStats.player_turn): 
		var _double_damage_value=PlayerStats.damage*2-PlayerStats.damage/2
		text_box_controller._display_text("The "+ enemy_container.enemy.name + 
		" was Attacked twice for %d damage" % _double_damage_value )
		
		attack_enemy_twice.emit()
		
		PlayerStats.player_turn=false

		await get_tree().create_timer(1).timeout
		player_turn_finished.emit()

func _close_game():
	SceneSwitcher.switch_scene("res://Map_Scene.tscn")
	#get_tree().quit()





