extends Area2D

export (float) var HP = 1
export (bool) var immortal = false

export (Vector2) var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)
var invincible_time = 0.0

func _ready():
	pass

func _physics_process(delta):
	global_position += delta * velocity
	velocity += delta * acceleration
	if HP <= 0 && !immortal:
		destroy()
	
	if max(abs((global_position.x-512)*(9/16)), abs((global_position.y-288))) > 576:
		#print_debug("Meow!")
		queue_free()
		
	if invincible_time > 0:
		invincible_time -= delta
		$sprite.modulate = Color(1.0,1.0,1.0,0.25+0.75*(int(floor(invincible_time*32))%2))
	elif invincible_time <= 0:
		invincible_time = 0
		$sprite.modulate = Color(1.0,1.0,1.0,1.0)

func destroy():
	destroy_ext()
	queue_free()

func destroy_ext():
	pass
