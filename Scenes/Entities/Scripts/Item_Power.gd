extends "res://Scenes/Entities/Scripts/Item.gd"

func _ready():
	pass

func collect_benefit():
	GLOBAL_SCRIPTS.particle("Player_Power", global_position)
	GLOBAL_SCRIPTS.external_audio("power-up")
	
	if GLOBAL_SCRIPTS.player_power < 3:
		GLOBAL_SCRIPTS.player_power += 1