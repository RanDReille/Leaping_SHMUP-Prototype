extends Node2D

func _ready():
	GLOBAL_SCRIPTS.player_power = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_arrow"):
		get_tree().change_scene("res://Scenes/Worlds/World_0.tscn")