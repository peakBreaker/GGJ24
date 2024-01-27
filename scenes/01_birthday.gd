extends Node3D

@onready var anim_sprite = $Game/AnimatedSprite3D
@onready var sound_player = $Game/sounds

signal on_win
signal on_lose

var can_intervene = true

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite.play("waiting")
	$Game/shake_speed.play("shake_speed")
	# Do some action
	await get_tree().create_timer(10.0).timeout
	# Do something afterwards
	anim_sprite.play("inhale")
	await get_tree().create_timer(10.0).timeout
	$Game/Instruction.queue_free()
	can_intervene = false
	anim_sprite.play("waiting")
	sound_player.stream = preload("res://assets/sounds/candle_blowout.mp3")
	sound_player.play()
	
func _input(event):
	# handle the space button here
	if event.is_action_pressed("the_button"):
		on_lose.emit()
		print("SPACE was pressed")
		sound_player.stream = preload("res://assets/sounds/audio_crying.mp3")
		sound_player.play()
		$background_sounds.stop()
			
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass