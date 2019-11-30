extends "res://Scenes/Entities/Scripts/Entity.gd"

func _ready():
	pass

func _physics_process(delta):
	if max(abs(global_position.x-512)*9/16, abs(global_position.y-288)) > 576:
		queue_free()
		
	pass

func _on_Enemy_area_entered(area):
	if area.is_in_group("Bullet_Player") && max(abs(global_position.x-512)*9/16, abs(global_position.y-288)) < 288:
		hit(area)

func hit(area):
	hit_ext()
	$sprite.self_modulate = Color(1.0,0.0,0.0,1.0)
	$dmg_timer.start()
	HP -= area.dmg
	if HP > 0:
		GLOBAL_SCRIPTS.external_audio(GLOBAL_SCRIPTS.choose(["hit_0", "hit_1", "hit_2"]))
	area.queue_free()

func hit_ext():
	pass

func _on_dmg_timer_timeout():
	#print("Meow!")
	$sprite.self_modulate = Color(1.0,1.0,1.0,1.0)
