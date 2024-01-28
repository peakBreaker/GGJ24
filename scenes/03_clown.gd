extends Node3D

@onready var anim_sprite = $Game/AnimatedSprite3D
@onready var sound_player = $Game/sounds

signal on_win
signal on_lose

var game_over = false

func _ready():
	anim_sprite.play("juggling")
	$Game/shake_speed.play("shake_speed")
	# Do some action
	await get_tree().create_timer(18.0).timeout
	if not game_over:
		on_win.emit()
		$Game/Instruction.queue_free()
		game_over = true

func _input(event):
	if event.is_action_pressed("the_button") and not game_over:
		game_over = true
		$Game/Instruction.queue_free()
		await get_tree().create_timer(2.0).timeout
		sound_player.stream = preload("res://assets/sounds/YOUSUCKMp3.mp3")
		sound_player.play()
		# TODO: add the you such sound here
		await get_tree().create_timer(4.0).timeout
		anim_sprite.play("sad")
		sound_player.stream = preload("res://assets/sounds/audio_crying.mp3")
		sound_player.play()
		await get_tree().create_timer(2.0).timeout
		on_lose.emit()
