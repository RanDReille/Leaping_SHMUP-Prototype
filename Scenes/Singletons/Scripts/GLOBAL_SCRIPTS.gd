extends Node

var player_pos = Vector2(0, 0)
var player_power = 0
var scene_directory

func _ready():
	pass

func _physics_process(delta):
	#print("Enemies: " + str(get_tree().get_nodes_in_group("Enemy").size()))
	#print("Bullet_Player:" + str(get_tree().get_nodes_in_group("Bullet_Player").size()))
	pass

func shoot(bullet, origin, speed, direction, parent = get_tree().get_root().get_node("World")):
	var bullet_object = PRELOADED_RESOURCES.BULLET[bullet].instance()
	parent.add_child(bullet_object)
	bullet_object.global_position = origin
	bullet_object.speed = speed
	bullet_object.direction = direction
	return bullet_object

func shoot_aim_player(bullet, origin, speed, parent = get_tree().get_root().get_node("World")):
	var to_player = player_pos - origin
	var bullet_object = shoot(bullet, origin, speed, atan2(to_player.y, to_player.x), parent)
	return bullet_object

func spawn(enemy, origin, parent = get_tree().get_root().get_node("World")):
	var enemy_object = PRELOADED_RESOURCES.ENEMY[enemy].instance()
	parent.add_child(enemy_object)
	enemy_object.global_position = origin
	if enemy_object.is_in_group("Boss"):
		#print("MEOWW!!!")
		enemy_object.connect("boss_spawn", get_tree().get_root().get_node("World/ui_layer/UI"), "_on_Boss_Spawn")
		enemy_object.connect("boss_HP", get_tree().get_root().get_node("World/ui_layer/UI"), "_on_Boss_HP_Change")
		#get_tree().get_root().get_node("World").connect_to_UI(enemy_object, "boss_spawn", "_on_Boss_Spawn")
		#get_tree().get_root().get_node("World").connect_to_UI(enemy_object, "boss_HP", "_on_Boss_HP_Change")
		enemy_object.emit_signal("boss_spawn", enemy_object.boss_name, enemy_object.HP)
	return enemy_object

func particle(particle, origin):
	var particle_object = PRELOADED_RESOURCES.PARTICLES[particle].instance()
	get_tree().get_root().get_node("World").add_child(particle_object)
	particle_object.global_position = origin
	return particle_object

func drop(item, origin):
	var item_object = PRELOADED_RESOURCES.ITEM[item].instance()
	get_tree().get_root().get_node("World").add_child(item_object)
	item_object.global_position = origin
	return item_object

func external_audio(audio, volume_db = -20, life = 1):
	var audio_object = PRELOADED_RESOURCES.ITEM["Audio"].instance()
	get_tree().get_root().get_node("World").add_child(audio_object)
	audio_object.stream = PRELOADED_RESOURCES.AUDIO[audio]
	audio_object.volume_db = volume_db
	audio_object.play()
	audio_object.get_node("Timer").wait_time = life

func scene_change_in(seconds, scene_name):
	scene_directory = "res://Scenes/Worlds/" + scene_name
	$Scene_Change_Timer.wait_time = seconds
	$Scene_Change_Timer.start()

func _on_Scene_Change_Timer_timeout():
	get_tree().change_scene(scene_directory)

## MATH FUNCTIONS ##

func approach(from, to, rate):
	if abs(to-from) < rate:
		return to
	else:
		return from + sign(to-from) * rate

func rotation_approach(from, to, rate):
	while abs(to-from) > PI:
		from += sign(to-from) * 2*PI
	return approach(from, to, rate)

func length(vector2):
	return sqrt(pow(vector2.x, 2) + pow(vector2.y, 2))

func normalize(vector2):
	return vector2/length(vector2)

func choose(array):
	var length = len(array)
	return array[randi()%length]
