extends Node3D

@onready var anim_sprite = $Game/AnimatedSprite3D
@onready var sound_player = $Game/sounds
@onready var anim_candle = $Game/candle

signal on_win
signal on_lose

var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_candle.play("default")
	anim_sprite.play("waiting")
	$Game/shake_speed.play("shake_speed")
	# Do some action
	await get_tree().create_timer(12.0).timeout
	if not game_over:
		anim_sprite.play("inhale")
	await get_tree().create_timer(6.0).timeout
	
	if not game_over:
		$Game/Instruction.queue_free()
		# Do something afterwards
		game_over = true		
		sound_player.stream = preload("res://assets/sounds/BlowoutMP3.mp3")
		await get_tree().create_timer(0.2).timeout		
		anim_sprite.play("blowing")
		await get_tree().create_timer(0.2).timeout
		anim_candle.queue_free()
		await get_tree().create_timer(0.5).timeout
		on_win.emit()
		anim_sprite.play("waiting")
		sound_player.play()

func _input(event):
	# handle the space button here
	if event.is_action_pressed("the_button") and not game_over:
		$Game/Instruction.queue_free()
		game_over = true
		$background_sounds.stop()
		await get_tree().create_timer(2.0).timeout
		sound_player.stream = preload("res://assets/sounds/BlowoutMP3.mp3")
		sound_player.play()
		await get_tree().create_timer(1.0).timeout		
		anim_candle.queue_free()
		await get_tree().create_timer(2.0).timeout
		on_lose.emit()
		anim_sprite.play("crying")
		sound_player.stream = preload("res://assets/sounds/audio_crying.mp3")
		sound_player.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
