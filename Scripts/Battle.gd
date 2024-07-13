extends Node2D
class_name Battle

@onready var text_box = $CanvasLayer/TextBox
@onready var text_box_label=$CanvasLayer/TextBox/Label
@onready var player_health_bar=$CanvasLayer/PlayerContainer/VBoxContainer/ProgressBar
@onready var enemy_health_bar
@onready var HboxContainer= $CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer
@onready var mana_bar=$CanvasLayer/PlayerContainer/VBoxContainer/ManaBar
@onready var Skill_manager = $Skill_manager as SkillManager

@export var text_box_controller:Text_box_controller
@onready var saverLoader = $SaverLoader as SaverLoaderBattle
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


	
	if load("user://savegame4.tres") !=null:
		saverLoader.load_player_skills()
	
	if load("user://savegame3.tres") !=null:
		saverLoader.load_player_states()
	
	if load("user://savegame2.tres") != null:
		saverLoader.load_game()
	else :
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
	enemy_container.enemy_died.connect(_enemy_defeated)
	

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
		



func _enemy_defeated():
	saverLoader.save_player_states()
	SceneSwitcher.switch_scene("res://Map_Scene.tscn")
	#get_tree().quit()

func _notification(what):

	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		enemy_container.was_scene_switched = true
		saverLoader.save_player_states()
		saverLoader.save_game()
	elif what == NOTIFICATION_WM_CLOSE_REQUEST:
		enemy_container.was_scene_switched = true
		saverLoader.save_player_states()
		saverLoader.save_game()
	elif what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		enemy_container.was_scene_switched = true
		saverLoader.save_player_states()
		saverLoader.save_game()
		



func _on_skills_pressed():
	
	Skill_manager._on_skills_pressed()
