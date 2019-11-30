extends Area2D

var speed = 0.0
var direction = 0.0
export (float) var dmg = 1.0
export (bool) var circular = false

func _ready():
	pass

func _physics_process(delta):
	var velocity = Vector2(speed * cos(direction), speed * sin(direction))
	global_position += delta * velocity
	if !circular:
		rotation = direction
	
	if max(abs(global_position.x-512)*9/16, abs(global_position.y-288)) > 576:
		queue_free()