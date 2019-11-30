extends "res://Scenes/Entities/Scripts/Enemy.gd"

export (String) var boss_name

signal boss_spawn
signal boss_HP

func _ready():
	invincible_time = 5.0

func hit_ext():
	emit_signal("boss_HP", HP)

func destroy_ext():
	emit_signal("boss_HP", HP)