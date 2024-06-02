extends Node

var player_name="Warrior"
var current_health = 80
var Max_health=80
var damage=20
var max_mana = 20
var current_mana = 20
var player_turn=true
var is_defending=false
var skills:Array[PackedScene]
signal skill_pressed
signal player_turn_finished
signal attack_enemy
signal attack_enemy_twice

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

