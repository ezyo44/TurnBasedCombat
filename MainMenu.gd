extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if load("user://savegame2.tres") != null:
		var saved_game2:SavedGameBattle = load("user://savegame2.tres") as SavedGameBattle
		for item in saved_game2.saved_Battle_data:
			if item.was_Scene_closed == true:
				var EnemyScene = load(item.enemy_Scene_path)
				SceneSwitcher.switch_scene_choose_Enemy("res://node_2d.tscn",EnemyScene) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func delete_save(save_id):
	var save_game_path = "user://savegame{id}.tres"
	var formated_path = save_game_path.format({"id": save_id})
	DirAccess.remove_absolute(formated_path)	

func _on_button_pressed():

	delete_save(4) 
	delete_save(3)
	delete_save(2)
	delete_save(1) 

	SceneSwitcher.switch_scene("res://Map_Scene.tscn")


