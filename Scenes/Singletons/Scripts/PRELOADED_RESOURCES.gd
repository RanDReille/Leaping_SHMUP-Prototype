extends Node

onready var AUDIO = {
		"explode": preload("res://Audio/explode.wav"),
		"hit_0": preload("res://Audio/hit_0.wav"),
		"hit_1": preload("res://Audio/hit_1.wav"),
		"hit_2": preload("res://Audio/hit_2.wav"),
		"laser": preload("res://Audio/laser.wav"),
		"pew": preload("res://Audio/pew.wav"),
		"player_death": preload("res://Audio/player_death.wav"),
		"power-up": preload("res://Audio/power-up.wav")
	}

onready var BULLET = {
		"Player": preload("res://Scenes/Bullets/Bullet_Player.tscn"),
		"Player_Big": preload("res://Scenes/Bullets/Bullet_Player_Big.tscn"),
		"Enemy_0": preload("res://Scenes/Bullets/Bullet_Enemy_0.tscn")
	}

onready var ENEMY = {
		"Drone": preload("res://Scenes/Entities/Enemy_Drone.tscn"),
		"Big_Ship": preload("res://Scenes/Entities/Enemy_Big_Ship.tscn"),
		"Tank_Ship": preload("res://Scenes/Entities/Enemy_Tank_Ship.tscn"),
		"Nekopter": preload("res://Scenes/Entities/Enemy_Nekopter.tscn"),
		"Boss_Nekocharlotte": preload("res://Scenes/Entities/Enemy_Boss_Nekocharlotte.tscn")
	}

onready var ITEM = {
		"Power": preload("res://Scenes/Entities/Item_Power.tscn"),
		"Audio": preload("res://Scenes/Entities/External_Audio_Player.tscn")
	}

onready var PARTICLES = {
		"Player_Jet": preload("res://Scenes/Particles/Particles_Player_Jet.tscn"),
		"Player_Death": preload("res://Scenes/Particles/Particles_Player_Death.tscn"),
		"Player_Power": preload("res://Scenes/Particles/Particles_Player_Power.tscn"),
		"Single_Explosion": preload("res://Scenes/Entities/Particle_Single_Explosion.tscn")
	}

func _ready():
	pass
