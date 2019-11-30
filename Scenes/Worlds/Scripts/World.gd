extends Node2D

func _ready():
	$scene.current_animation = "Scene"
	$scene.play()
	$Player.connect("life_change", $ui_layer/UI, "_on_Player_life_change")
	$Player.connect("life_change", self, "_on_Player_life_change")
	
func spawn(enemy, origin, argument2 = null):
	var enemy_object = GLOBAL_SCRIPTS.spawn(enemy, origin)
	
	if argument2 != null:
		match enemy:
			"Nekopter":
				enemy_object.hover_x = argument2
	
	return enemy_object

func _on_Player_life_change(life_val):
	#print("Meow!")
	if life_val >= 0:
		$player_respawn_control.current_animation = "Respawn"
		$player_respawn_control.play()
	else:
		GLOBAL_SCRIPTS.scene_change_in(3, "Menu.tscn")

func connect_to_UI(object, signal_name, UI_func):
	object.connect(signal_name, $ui_layer/UI, UI_func)