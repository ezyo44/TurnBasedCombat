extends Node2D

@export var battle_scene:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_normal_enemy_pressed():
	var normalEnemy=$CanvasLayer/PanelContainer/TextureRect/ScrollContainer/VBoxContainer/NormalEnemy
	normalEnemy.disabled=true
	SceneSwitcher.switch_scene("res://node_2d.tscn")
	 # Replace with function body.
