extends VBoxContainer
class_name Knight

@onready var enemy_sprite:AnimatedSprite2D=$AnimatedSprite2D

@export var enemy_health_bar:ProgressBar
@onready var player_health_bar:ProgressBar
@onready var text_box_controller:Text_box_controller
@export var health_controller:Health_component
@export var enemy:Resource 
@onready var attack_button:Button
@onready var defend_button:Button
@onready var skills_button:Button
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
	died=true
	enemy_sprite.play("die")
	await await enemy_sprite.animation_finished
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
			
