extends Particles2D

func _ready():
	if get_one_shot():
		set_emitting(true)

func _on_lifetime_timeout():
	queue_free()