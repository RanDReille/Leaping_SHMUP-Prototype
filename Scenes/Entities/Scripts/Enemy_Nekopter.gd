extends "res://Scenes/Entities/Scripts/Enemy.gd"

const ACC = 800
const VELOCITYY_MAX = 128

var AI = 0
var hover_x = 896
var margin = pow(VELOCITYY_MAX,2)/(2*ACC)

func _ready():
	$sprite/AnimationPlayer.current_animation = "copter"
	$sprite/AnimationPlayer.play()

func _physics_process(delta):
	match AI:
		0:
			global_position.x = GLOBAL_SCRIPTS.approach(global_position.x, hover_x, delta * 128)
			if global_position.x <= hover_x:
				AI = 1
				$Timer.start()
				acceleration.y = ACC * (-1 + 2*float(sign(288 - global_position.y)>=0))
				#print(288-global_position.y)
		1:
			velocity.y = clamp(velocity.y, -VELOCITYY_MAX, VELOCITYY_MAX)
			if sign(acceleration.y)*(global_position.y - 288) + margin > 224:
				acceleration.y *= -1

func _on_Timer_timeout():
	if max(abs(global_position.x-512)*9/16, abs(global_position.y-288)) < 288:
		GLOBAL_SCRIPTS.shoot("Enemy_0", global_position, 600, PI)
		GLOBAL_SCRIPTS.external_audio("pew")

func destroy_ext():
	GLOBAL_SCRIPTS.particle("Single_Explosion", global_position)