extends Node3D

@onready var anim_sprite = $Game/AnimatedSprite3D
@onready var sound_player = $Game/sounds

signal on_win
signal on_lose

var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite.play("waiting")
	$Game/shake_speed.play("shake_speed")
	# Do some action
	await get_tree().create_timer(12.0).timeout
	if not game_over:
		anim_sprite.play("inhale")
	await get_tree().create_timer(6.0).timeout
	$Game/Instruction.queue_free()
	if not game_over:
		# Do something afterwards
		anim_sprite.play("blowing")
	await get_tree().create_timer(2.0).timeout
	if not game_over:
		on_win.emit()
		game_over = true
		anim_sprite.play("waiting")
		sound_player.stream = preload("res://assets/sounds/candle_blowout.mp3")
		sound_player.play()

func _input(event):
	# handle the space button here
	if event.is_action_pressed("the_button"):
		$Game/Instruction.queue_free()
		game_over = true
		$background_sounds.stop()

		await get_tree().create_timer(2.0).timeout
		on_lose.emit()
		anim_sprite.play("crying")
		sound_player.stream = preload("res://assets/sounds/audio_crying.mp3")
		sound_player.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
