extends Control

func _ready():
	pass

func _physics_process(delta):
	$Power.value = GLOBAL_SCRIPTS.player_power
	if Input.is_action_just_pressed("ui_cancel"):
		var is_paused = get_tree().paused
		get_tree().paused = !is_paused
		if is_paused:
			$Pause_Rect.hide()
		else:
			$Pause_Rect.show()

func _on_Player_life_change(life_val):
	$Life.value = life_val

func _on_Boss_Spawn(boss_name, boss_HP):
	$Boss_HP.show()
	$Boss_HP.max_value = boss_HP
	$Boss_HP.value = boss_HP
	$Boss_HP/Label.text = boss_name

func _on_Boss_HP_Change(HP):
	$Boss_HP.value = HP
	if HP <= 0:
		$Boss_HP.hide()