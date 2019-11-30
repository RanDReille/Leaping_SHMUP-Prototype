extends "res://Scenes/Entities/Scripts/Boss.gd"

var AI = -1
var sub_AI = 0

var food_location = Vector2(0,0)


var internal_timer = 0

func _ready():
	pass

func _physics_process(delta):
	match AI:
		-1:
			if global_position.x - 50*delta > 896:
				global_position.x -= 50*delta
			else:
				global_position.x = 896
				AI = 0
				velocity.y = (2*randi()%2-1)*100
				$AI0_Timer.start()
		0:
			if (global_position.y - 288)*sign(velocity.y) > 160:
				velocity.y *= -1
			global_position.y = clamp(global_position.y, 128, 448)
			if internal_timer - delta > 0:
				internal_timer -= delta
			else:
				var to_player = GLOBAL_SCRIPTS.player_pos - global_position
				GLOBAL_SCRIPTS.shoot("Enemy_0", $sprite/Gun.global_position, 600, atan2(to_player.y, to_player.x))
				GLOBAL_SCRIPTS.external_audio("pew")
				internal_timer = 0.5 - 0.3 * (1 - HP/150)
		1:
			match sub_AI:
				0:
					if internal_timer - delta > 0:
						internal_timer -= delta
					else:
						internal_timer = 0
						sub_AI += 1
				1:
					food_location = GLOBAL_SCRIPTS.player_pos
					var to_food = GLOBAL_SCRIPTS.player_pos - global_position + Vector2(32, 0)
					var distance_to_food = GLOBAL_SCRIPTS.length(to_food)
					internal_timer = distance_to_food/800.0
					velocity = 800 * to_food/distance_to_food
					sub_AI += 1
				2:
					$sprite.frame = 1
					if internal_timer - delta > 0:
						internal_timer -= delta
					else:
						internal_timer = 0
						global_position = food_location + Vector2(32, 0)
						velocity = Vector2(0, 0)
						$Attack_Anim.current_animation = "Eat"
						$Attack_Anim.play()
						sub_AI += 1
				3:
					pass
				4:
					food_location = GLOBAL_SCRIPTS.player_pos
					var to_food = GLOBAL_SCRIPTS.player_pos - global_position + Vector2(32, 0)
					var distance_to_food = GLOBAL_SCRIPTS.length(to_food)
					internal_timer = distance_to_food/800.0
					velocity = 800 * to_food/distance_to_food
					sub_AI += 1
				5:
					$sprite.frame = 1
					if internal_timer - delta > 0:
						internal_timer -= delta
					else:
						internal_timer = 0
						global_position = food_location + Vector2(32, 0)
						velocity = Vector2(0, 0)
						$Attack_Anim.current_animation = "Eat"
						$Attack_Anim.play()
						sub_AI += 1
				6:
					pass
				7:
					food_location = GLOBAL_SCRIPTS.player_pos
					var to_food = GLOBAL_SCRIPTS.player_pos - global_position + Vector2(32, 0)
					var distance_to_food = GLOBAL_SCRIPTS.length(to_food)
					internal_timer = distance_to_food/800.0
					velocity = 800 * to_food/distance_to_food
					sub_AI += 1
				8:
					$sprite.frame = 1
					if internal_timer - delta > 0:
						internal_timer -= delta
					else:
						internal_timer = 0
						global_position = food_location + Vector2(32, 0)
						velocity = Vector2(0, 0)
						$Attack_Anim.current_animation = "Eat"
						$Attack_Anim.play()
						sub_AI += 1
				9:
					pass
				10:
					var to_neutral = Vector2(896 - global_position.x, clamp(global_position.y, 128, 448) - global_position.y)
					var distance_to_neutral = GLOBAL_SCRIPTS.length(to_neutral)
					internal_timer = distance_to_neutral/800.0
					velocity = 800 * to_neutral/distance_to_neutral
					sub_AI += 1
				11:
					if internal_timer - delta > 0:
						internal_timer -= delta
					else:
						internal_timer = 0
						AI = 0
						$AI0_Timer.start()
						global_position.x = 896
						velocity = Vector2(0, (2*randi()%2-1)*100)
		2:
			#print("Internal Timer = " + str(internal_timer))
			if internal_timer - delta > 0:
				internal_timer -= delta
				if randf()*internal_timer < 0.4:
					var r = randf() * 96
					var d = randf() * 2*PI
					GLOBAL_SCRIPTS.particle("Single_Explosion", global_position + Vector2(r*cos(d), r*sin(d)))
				if randf()*internal_timer < 0.2:
					var r = randf() * 112
					var d = randf() * 2*PI
					GLOBAL_SCRIPTS.particle("Single_Explosion", global_position + Vector2(r*cos(d), r*sin(d)))
				if randf()*internal_timer < 0.1:
					var r = randf() * 128
					var d = randf() * 2*PI
					GLOBAL_SCRIPTS.particle("Single_Explosion", global_position + Vector2(r*cos(d), r*sin(d)))
			else:
				for i in 32 + randi()%16:
					var r = randf() * 128
					var d = randf() * 2*PI
					var explosion_object = GLOBAL_SCRIPTS.particle("Single_Explosion", global_position + Vector2(r*cos(d), r*sin(d)))
					if i != 1:
						explosion_object.silent = true
				GLOBAL_SCRIPTS.scene_change_in(3, "Menu.tscn")
				queue_free()

func _on_AI0_Timer_timeout():
	AI = 1
	sub_AI = 0
	internal_timer = 2
	velocity = Vector2(0, 0)

func sub_AI_change(num):
	sub_AI += num

func _on_Corpse_Timer_timeout():
	#AI = 0
	$sprite/Corpse.hide()
	#sub_AI = 10

func _on_Bite_Area_area_entered(area):
	if area.is_in_group("Player"):
		$Bite_Area/CollisionShape2D.disabled = true
		area.dead()
		#$Attack_Anim.stop()
		sub_AI = 9
		velocity = Vector2(0, 0)
		$sprite/Corpse.show()
		$Corpse_Timer.start()

func destroy():
	if AI != 2: internal_timer = 5
	$Bite_Area/CollisionShape2D.disabled = true
	AI = 2
	velocity = Vector2(0, 0)