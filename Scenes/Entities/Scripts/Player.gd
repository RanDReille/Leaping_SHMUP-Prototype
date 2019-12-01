extends "res://Scenes/Entities/Scripts/Entity.gd"

const GRAVITY = 3200
const JUMP_VELOCITY = -600
const MAX_SPEED = 400
const ACCELERATION = 2400
const DECCELERATION = 1600

onready var gun = $Gun

var life = 3
var dead = false

signal life_change

func _ready():
	velocity.y = -600

func _physics_process(delta):
	
	#CONTROL
	var horizontal_input = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if horizontal_input == 0:
		velocity.x = GLOBAL_SCRIPTS.approach(velocity.x, 0, delta * DECCELERATION)
	else:
		velocity.x += delta * horizontal_input * ACCELERATION
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	
	velocity.y += delta * GRAVITY
	if (Input.is_action_just_pressed("ui_up") || global_position.y >= 576) && !dead:
		velocity.y = JUMP_VELOCITY
		#$Particles_Jet.set_one_shot(false)
		#$Particles_Jet.set_emitting(true)
		#$Particles_Jet.set_one_shot(true)
		GLOBAL_SCRIPTS.particle("Player_Jet", $Particles_Normal.global_position)
		$AnimationPlayer.current_animation = "[stop]"
		$AnimationPlayer.current_animation = "Jump"
		$AnimationPlayer.play()
		$Gun/AudioStreamPlayer.play()
		match GLOBAL_SCRIPTS.player_power:	
			0:
				GLOBAL_SCRIPTS.shoot("Player", gun.global_position, 800, 0)
			1:
				GLOBAL_SCRIPTS.shoot("Player_Big", gun.global_position, 800, 0)
			2:
				GLOBAL_SCRIPTS.shoot("Player_Big", gun.global_position, 800, 0)
				GLOBAL_SCRIPTS.shoot("Player", gun.global_position, 800, -PI/12)
				GLOBAL_SCRIPTS.shoot("Player", gun.global_position, 800, PI/12)
			3:
				GLOBAL_SCRIPTS.shoot("Player_Big", gun.global_position, 800, 0)
				GLOBAL_SCRIPTS.shoot("Player_Big", gun.global_position, 800, -PI/12)
				GLOBAL_SCRIPTS.shoot("Player_Big", gun.global_position, 800, PI/12)
	
	#POSITION LIMIT
	#print(str(dead))
	if !dead:
		global_position = Vector2(clamp(global_position.x, 0, 1024), clamp(global_position.y, 0, 576))
	#else:
		#print(str(global_position))
		#global_position = Vector2(-64, 288)
		#velocity = Vector2(0, 0)
	#POSITION REPORT TO GLOBAL_SCRIPT
	GLOBAL_SCRIPTS.player_pos = global_position
	
	#if Input.is_action_just_pressed("ui_down"):
		#GLOBAL_SCRIPTS.external_audio("laser")
	#cheat()

func _on_Player_area_entered(area):
	if area.is_in_group("Bullet_Enemy"):
		#HP -= area.dmg
		if invincible_time <= 0:
			if GLOBAL_SCRIPTS.player_power > 1:
				var item_power = GLOBAL_SCRIPTS.drop("Power", global_position)
				item_power.to_collect = 0.5
				GLOBAL_SCRIPTS.player_power -= 2
			else:
				dead()
			invincible_time = 5
		area.queue_free()

func dead():
	life -= 1
	if GLOBAL_SCRIPTS.player_power > 0:
		GLOBAL_SCRIPTS.drop("Power", global_position)
	GLOBAL_SCRIPTS.player_power = 0
	dead = true
	velocity = Vector2(0, 0)
	emit_signal("life_change", life)
	GLOBAL_SCRIPTS.particle("Player_Death", $Particles_Normal.global_position)
	GLOBAL_SCRIPTS.external_audio("player_death", -15)
	global_position = Vector2(-64, 288)
	$Death_Timer.start()

func cheat():
	if Input.is_action_just_pressed("ui_cancel"):
		dead()

func stop_anim():
	$AnimationPlayer.current_animation = "[stop]"

func _on_Death_Timer_timeout():
	dead = false
