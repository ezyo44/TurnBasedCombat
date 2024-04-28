extends Node2D

@onready var text_box = $CanvasLayer/TextBox
@onready var text_box_label=$CanvasLayer/TextBox/Label
@onready var player_health_bar=$CanvasLayer/PlayerContainer/VBoxContainer/ProgressBar
@onready var enemy_health_bar

@export var text_box_controller:Text_box_controller

@export var health_controller:Health_component
@export var Enemy_scene:PackedScene

var player_turn=true


signal attack_enemy
signal player_turn_finished
var enemy_instance
signal textbox_closed
# Called when the node enters the scene tree for the first time.
func _ready():
	
	enemy_instance=Enemy_scene.instantiate()

	get_node("CanvasLayer2").add_child(Enemy_scene.instantiate())
	
	health_controller._set_health(player_health_bar,PlayerStats.current_health,PlayerStats.Max_health)
	text_box_controller._hide_text() 
	text_box_controller._display_text("A "  + " is Challanging you")
	
	get_node("CanvasLayer2/EnemyContainer").player_health_bar=player_health_bar
	get_node("CanvasLayer2/EnemyContainer").text_box_controller=text_box_controller
	get_node("CanvasLayer2/EnemyContainer").attack_button=$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Attack
	
	attack_enemy.connect(get_node("CanvasLayer2/EnemyContainer")._get_hit)
	player_turn_finished.connect(get_node("CanvasLayer2/EnemyContainer")._enemy_turn)
	get_node("CanvasLayer2/EnemyContainer").enemy_died.connect(_close_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_attack_pressed():
	
	if(PlayerStats.player_turn):
		
		attack_enemy.emit()
	
		text_box_controller._display_text("The "+ " was Attacked for %d damage" % PlayerStats.damage )
		
		$CanvasLayer/PlayerContainer/VBoxContainer/HBoxContainer/Attack.disabled=true

		PlayerStats.player_turn=false

		await get_tree().create_timer(1).timeout
		player_turn_finished.emit()
		

func _close_game():
	get_tree().quit()

