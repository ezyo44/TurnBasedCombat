extends TextureButton

@onready var saverLoader =  $"../../../../../../SaverLoader" as SaverLoaderMapScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_save_game(saved_data:Array[SavedData]):

	var my_data = SavedData.new()
	my_data.is_pressed=self.disabled
	my_data.scene_path=self.scene_file_path
	saved_data.append(my_data)
	
func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()
	
func on_load_game(Saved_data:SavedData):

	self.disabled=Saved_data.is_pressed

func _pressed():
	self.disabled=true
	enable_next_button()
	saverLoader.save_game()
	SceneSwitcher.switch_scene("res://Skill_room.tscn")

func enable_next_button():
	$"../NormalEnemy2".disabled=false
	
