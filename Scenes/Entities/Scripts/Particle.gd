extends "res://Scenes/Entities/Scripts/Entity.gd"

export (bool) var silent = false

func _ready():
	if !silent:
		$AudioStreamPlayer.play()
	pass

func _on_lifespan_timeout():
	destroy()
