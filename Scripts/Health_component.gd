extends Node
class_name Health_component

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_health(prograss_bar:ProgressBar,health,max_health):
	prograss_bar.value=health
	prograss_bar.max_value=max_health
	prograss_bar.get_node("Label").text = "HP: %d/%d" % [health,max_health]

func _heal(prograss_bar:ProgressBar,health):
	prograss_bar.value+=health
	prograss_bar.get_node("Label").text = "HP: %d/%d" % [prograss_bar.value,prograss_bar.max_value]
	
func _deal_damage(prograss_bar:ProgressBar,damage):

	prograss_bar.value= max(0,prograss_bar.value-damage) 
	prograss_bar.get_node("Label").text = "HP: %d/%d" % [prograss_bar.value,prograss_bar.max_value]
