extends "res://Scenes/Entities/Scripts/Enemy.gd"

func _ready():
	velocity = Vector2(-64, 0)

func _physics_process(delta):
	if max(abs(global_position.x-512)*9/16, abs(global_position.y-288)) < 288:
		var turret = $Enemy_Turret
		var turret_pos = turret.global_position
		turret.rotation = GLOBAL_SCRIPTS.rotation_approach(turret.rotation, atan2(GLOBAL_SCRIPTS.player_pos.y - turret_pos.y, GLOBAL_SCRIPTS.player_pos.x - turret_pos.x), delta * PI)

func _on_Timer_timeout():
	if max(abs(global_position.x-512)*9/16, abs(global_position.y-288)) < 288:
		GLOBAL_SCRIPTS.shoot("Enemy_0", $Enemy_Turret/sprite/Gun.global_position, 600, $Enemy_Turret.rotation)
		GLOBAL_SCRIPTS.external_audio("pew")

func destroy_ext():
	var item_object = GLOBAL_SCRIPTS.drop("Power", global_position)
	item_object.velocity.x = -0.25 * global_position.x
	
	for i in 4 + randi()%3:
		GLOBAL_SCRIPTS.particle("Single_Explosion", global_position + Vector2(rand_range(-64, 64), rand_range(-40, 40)))
