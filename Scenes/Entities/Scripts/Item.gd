extends "res://Scenes/Entities/Scripts/Entity.gd"

const GRAVITY = 200
const ATTRACTION = 4000000

var remaining_bounce = 2

func _ready():
	velocity.y = -200
	#velocity.x = -1 * (global_position.x)

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if global_position.y >= 576:
		if remaining_bounce > 0:
			remaining_bounce -= 1
			velocity.y = -400 * (0.5 + 0.5 * remaining_bounce)
		else:
			destroy()
	if (global_position.x - 512)*sign(velocity.x) > 512:
		velocity.x *= -1
	
	var to_player = GLOBAL_SCRIPTS.player_pos - global_position
	
	#print(to_player)
	
	if GLOBAL_SCRIPTS.length(to_player) < 200:
		var acceleration = ATTRACTION * to_player/(pow(GLOBAL_SCRIPTS.length(to_player),3))
		#print(str(GLOBAL_SCRIPTS.length(acceleration)))
		velocity += delta * acceleration
		if GLOBAL_SCRIPTS.length(to_player) < 50:
			collect_benefit()
			destroy()

func collect_benefit():
	#Modify in child node depending on item type
	pass

func _on_Item_area_entered(area):
	#print(area)
	if area.is_in_group("Player"):
		collect_benefit()
		destroy()
