class_name SaverLoader
extends Node
@onready var vBox = $"../CanvasLayer/PanelContainer/TextureRect/ScrollContainer/VBoxContainer"


func save_game():
	print("save game was called")
	var saved_game:SavedGame = SavedGame.new()
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data=saved_data
	ResourceSaver.save(saved_game, "user://savegame.tres")
	
func load_game():
	if load("user://savegame.tres") != null:
		var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
		for nodes in vBox.get_children():
			nodes.queue_free()
			
		get_tree().call_group("game_events", "on_before_load_game")
		for item in saved_game.saved_data:
			var scene = load(item.scene_path) as PackedScene
			var line = load("res://MapScenes/line.tscn") as PackedScene
			var restored_node = scene.instantiate()
			if restored_node is StrongEnemy:
				vBox.add_child(restored_node)
			else:
				vBox.add_child(line.instantiate())
				vBox.add_child(restored_node)

			
			if restored_node.has_method("on_load_game"):
				restored_node.on_load_game(item)
	
