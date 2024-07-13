class_name SaverLoaderBattle
extends Node
@onready var canves_layer = $"../CanvasLayer2"
@onready var player_health_bar = $"../CanvasLayer/PlayerContainer/VBoxContainer/ProgressBar"
@onready var player_mana_bar = $"../CanvasLayer/PlayerContainer/VBoxContainer/ManaBar"
func save_game():
	print("save game was called")
	var saved_game:SavedGameBattle = SavedGameBattle.new()
	
	var saved_data:Array[SavedEnemyData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_Battle_data=saved_data
	ResourceSaver.save(saved_game, "user://savegame2.tres")
	
func save_player_states():
	var saved_game:PlayerData = PlayerData.new()
	saved_game.current_health=PlayerStats.current_health

	saved_game.current_health = player_health_bar.value
	saved_game.Max_health = player_health_bar.max_value
	saved_game.damage = PlayerStats.damage
	saved_game.max_mana = player_mana_bar.max_value
	saved_game.current_mana = player_mana_bar.value
	saved_game.player_turn = PlayerStats.player_turn
	saved_game.is_defending = PlayerStats.is_defending


	ResourceSaver.save(saved_game, "user://savegame3.tres")

func load_player_states():
	if load("user://savegame3.tres") != null:
		var saved_game:PlayerData = load("user://savegame3.tres") as PlayerData
		PlayerStats.current_health=saved_game.current_health
		PlayerStats.Max_health=saved_game.Max_health
		PlayerStats.damage=saved_game.damage
		PlayerStats.max_mana=saved_game.max_mana
		PlayerStats.current_mana=saved_game.current_mana
		PlayerStats.player_turn=saved_game.player_turn
		PlayerStats.is_defending=saved_game.is_defending
		print("player states loaded")
	
func load_player_skills():
	if load("user://savegame4.tres") != null:
		var saved_game_skills:SkillData = load("user://savegame4.tres") as SkillData
		PlayerStats.skills=saved_game_skills.skills
		print("skills loaded")


func load_game():
	if load("user://savegame2.tres") != null:
		var saved_game:SavedGameBattle = load("user://savegame2.tres") as SavedGameBattle

		get_tree().call_group("game_events", "on_before_load_game")
		for item in saved_game.saved_Battle_data:
			
			var scene = load(item.scene_path) as PackedScene
			if scene != null:
				var restored_node = scene.instantiate()
				canves_layer.add_child(restored_node)
				
				if restored_node.has_method("on_load_game"):
					restored_node.on_load_game(item)
	
