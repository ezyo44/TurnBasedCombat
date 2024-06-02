extends Node
class_name Mana_component

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_mana(prograss_bar:ProgressBar,mana,max_mana):
	prograss_bar.value=mana
	prograss_bar.max_value=max_mana
	prograss_bar.get_node("Label").text = "MP: %d/%d" % [mana,max_mana]

func _add_mana(prograss_bar:ProgressBar,mana):
	prograss_bar.value+mana
	prograss_bar.get_node("Label").text = "MP: %d/%d" % [prograss_bar.value,prograss_bar.max_value]
	
func _spend_energy(prograss_bar:ProgressBar,spent_mana):

	prograss_bar.value= max(0,prograss_bar.value-spent_mana) 
	prograss_bar.get_node("Label").text = "MP: %d/%d" % [prograss_bar.value,prograss_bar.max_value]
