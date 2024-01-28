extends Node3D

@onready var anim_sprite = $Game/AnimatedSprite3D
@onready var sound_player = $Game/sounds

signal on_win
signal on_lose

var game_over = false

func _ready():
	anim_sprite.play("waiting")
	$Game/Instruct/shake_speed.play("shake_speed")
	# Do some action
	await get_tree().create_timer(15.0).timeout
	if not game_over:
		on_win.emit()
		$Game/Instruct.queue_free()
		game_over = true

func _input(event):
	if event.is_action_pressed("the_button") and not game_over:
		$Game/Instruct.queue_free()
		game_over = true
		await get_tree().create_timer(2.0).timeout
		anim_sprite.play("falling")
		anim_sprite.position.x += 1.2
		await get_tree().create_timer(.7).timeout
		# play splash sound here
				
		await get_tree().create_timer(1).timeout
		anim_sprite.queue_free()
		await get_tree().create_timer(1.0).timeout
		on_lose.emit()

