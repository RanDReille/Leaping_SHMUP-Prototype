extends AudioStreamPlayer

func _ready():
	pass

func _on_Timer_timeout():
	#print("Meowwww!!")
	queue_free()
