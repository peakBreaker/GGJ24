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
	await get_tree().create_timer(5.0).timeout
	if not game_over:
		$Game/Instruct.queue_free()
	await get_tree().create_timer(5.0).timeout
	if not game_over:
		game_over = true
		# TODO: ADD SHOOT sound here
		jfk_anim_sprite.play("dead")
		wife_anim_sprite.play("shock")
		#$WorldEnvironment.environment
		await get_tree().create_timer(2.0).timeout
		var env = $WorldEnvironment.get_environment()
		$scene_president/AnimationTree.active = false
		$Game/AnimatedSprite3D/AnimationPlayer.stop()
		env.set_adjustment_saturation(0.0)
		on_lose.emit()

func _input(event):
	if event.is_action_pressed("the_button"):
		game_over = true
		on_win.emit()
		$Control/Sprite2D.show()
		# make hand appear
