extends VBoxContainer
class_name Worm

@onready var enemy_sprite:AnimatedSprite2D=$AnimatedSprite2D

@export var enemy_health_bar:ProgressBar
@onready var player_health_bar:ProgressBar
@onready var text_box_controller:Text_box_controller
@export var health_controller:Health_component
@export var enemy:Resource 
@onready var attack_button:Button

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
		enemy_sprite.play("attack")
		await enemy_sprite.animation_finished
	
		health_controller._deal_damage(player_health_bar,enemy.damage)
		text_box_controller._display_text("The "+ enemy.name+ " has Attacked you for %d damage" % enemy.damage )
		attack_button.disabled=false
	
		enemy_sprite.play("default")
	
		PlayerStats.player_turn=true

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
