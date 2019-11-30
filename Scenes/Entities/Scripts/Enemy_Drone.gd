extends "res://Scenes/Entities/Scripts/Enemy.gd"

func _ready():
	velocity = Vector2(-128, 0)


func _on_Timer_timeout():
	if max(abs(global_position.x-512)*9/16, abs(global_position.y-288)) < 288:
		GLOBAL_SCRIPTS.shoot("Enemy_0", global_position, 600.0, PI)
		GLOBAL_SCRIPTS.external_audio("pew")

func destroy_ext():
	GLOBAL_SCRIPTS.particle("Single_Explosion", global_position)