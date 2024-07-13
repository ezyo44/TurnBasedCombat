extends VBoxContainer
class_name Worm

@onready var enemy_sprite:AnimatedSprite2D=$AnimatedSprite2D
@onready var saverLoader =  $"../../../../../../SaverLoader" as SaverLoaderBattle
@export var enemy_health_bar:ProgressBar
@onready var player_health_bar:ProgressBar
@onready var text_box_controller:Text_box_controller
@export var health_controller:Health_component
@export var enemy:Resource 
@onready var attack_button:Button
@onready var defend_button:Button
@onready var skills_button:Button
var was_scene_switched:bool
var died=false
signal enemy_died
 
# Called when the node enters the scene tree for the first time.
func _ready():
	
	health_controller._set_health(enemy_health_bar,enemy.health,enemy.health)
	enemy_sprite.sprite_frames=enemy.sprite
	enemy_sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_save_game(saved_data:Array[SavedEnemyData]):

	var my_data = SavedEnemyData.new()
	my_data.health_value = self.enemy_health_bar.value
	my_data.max_health_value = self.enemy_health_bar.max_value
	my_data.scene_path = self.scene_file_path
	my_data.was_Scene_closed = self.was_scene_switched
	my_data.enemy_Scene_path= self.scene_file_path
	saved_data.append(my_data)

func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()
	
func on_load_game(Saved_data:SavedEnemyData):
	var my_data:SavedEnemyData = Saved_data as SavedEnemyData
	health_controller._set_health(enemy_health_bar,my_data.health_value,my_data.max_health_value)
	self.was_scene_switched = my_data.was_Scene_closed

func _enemy_turn():
	if (!died):
		var _damage_dealt
		enemy_sprite.play("attack")
		await enemy_sprite.animation_finished
		
		if PlayerStats.is_defending==true:
			health_controller._deal_damage(player_health_bar,enemy.damage/2)
			_damage_dealt= enemy.damage/2
		else :
			health_controller._deal_damage(player_health_bar,enemy.damage)
			_damage_dealt= enemy.damage
		if player_health_bar.value <= 0:
			delete_save(1)
			delete_save(2)
			delete_save(3)
			delete_save(4)
			SceneSwitcher.switch_scene("res://GameOver.tscn")

		text_box_controller._display_text("The "+ enemy.name+ " has Attacked you for %d damage" % _damage_dealt )
		_enable_buttons()
	
		enemy_sprite.play("default")
		
		PlayerStats.is_defending=false
		PlayerStats.player_turn=true

func _enable_buttons():
		attack_button.disabled=false
		defend_button.disabled=false
		skills_button.disabled=false
		
func _die():
	delete_save(2)
	died=true
	was_scene_switched=false
	enemy_sprite.play("die")
	await await enemy_sprite.animation_finished
	_enable_buttons()
	PlayerStats.is_defending=false
	PlayerStats.player_turn=true
	enemy_died.emit()
	
func _get_hit():
		enemy_sprite.play("got_hit")
		health_controller._deal_damage(enemy_health_bar,PlayerStats.damage)

		await enemy_sprite.animation_finished	
		if(enemy_health_bar.value==0 or enemy_health_bar.value<0):
			_die()
		else: 
			enemy_sprite.play("default")
			
func _get_hit_twice():
		var _double_damage_value=PlayerStats.damage*2-PlayerStats.damage/2
		enemy_sprite.play("got_hit")
		health_controller._deal_damage(enemy_health_bar,_double_damage_value)

		await enemy_sprite.animation_finished	
		if(enemy_health_bar.value==0 or enemy_health_bar.value<0):
			_die()
		else: 
			enemy_sprite.play("default")
			
		
func delete_save(save_id):
	var save_game_path = "user://savegame{id}.tres"
	var formated_path = save_game_path.format({"id": save_id})
	DirAccess.remove_absolute(formated_path)	
