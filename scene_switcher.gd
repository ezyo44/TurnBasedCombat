extends Node

var current_scene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)


func switch_scene_choose_Enemy(res_path, enemy:PackedScene):
	
	call_deferred("_deffered_switch_scene_for_Enemy",res_path,enemy)
	
func _deffered_switch_scene_for_Enemy(res_path, enemy:PackedScene):
	current_scene.free()
	var s = load(res_path)
	var scene = s.instantiate() as Battle
	scene.Enemy_scene = enemy
	current_scene=scene
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
# Called every frame. 'delta' is the elapsed time since the previous frame.
func switch_scene(res_path):
	
	call_deferred("_deffered_switch_scene",res_path)
	
func _deffered_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path)
	current_scene=s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
