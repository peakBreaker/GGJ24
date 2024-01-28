extends Node3D

@onready var jfk_anim_sprite = $Game/AnimatedSprite3D
@onready var wife_anim_sprite = $Game/wife_AnimatedSprite3D
@onready var sound_player = $Game/sounds

signal on_win
signal on_lose

var game_over = false

func _ready():
	jfk_anim_sprite.play("waving")
	wife_anim_sprite.play("waving")
	$Game/Instruct/shake_speed.play("shake_speed")
	# Do some action
	await get_tree().create_timer(15.0).timeout
	if not game_over:
		on_win.emit()
		$Game/Instruct.queue_free()
		game_over = true

func _input(event):
	if event.is_action_pressed("the_button"):
		on_lose.emit()
