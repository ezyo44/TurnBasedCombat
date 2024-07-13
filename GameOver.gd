extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_button_pressed():
	reset_player_states()
	SceneSwitcher.switch_scene("res://Map_Scene.tscn")


func reset_player_states():
	PlayerStats.player_name="Warrior"
	PlayerStats.current_health = 110
	PlayerStats.Max_health=110
	PlayerStats.damage=20
	PlayerStats.max_mana = 30
	PlayerStats.current_mana = 30
	PlayerStats.player_turn=true
	PlayerStats.is_defending=false
	PlayerStats.skills=[]
