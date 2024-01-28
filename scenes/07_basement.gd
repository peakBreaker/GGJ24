extends Node3D

@onready var anim_sprite = $Game/AnimatedSprite3D
@onready var sound_player = $Game/sounds

signal on_win
signal on_lose

var game_over = false

func _ready():
	anim_sprite.play("tied")
	await get_tree().create_timer(13.0).timeout
	if not game_over:
		game_over = true
		$Game/Instruct.queue_free()		
		await get_tree().create_timer(2.0).timeout	
		var env = $WorldEnvironment.get_environment()
		env.set_adjustment_saturation(0.0)
		env.set_adjustment_contrast(2.5)
		$scene_cellar/AnimationTree.active = false
		on_lose.emit()

func _input(event):
	if event.is_action_pressed("the_button") and not game_over:
		$scene_cellar/background_sounds.stop()
		game_over = true
		await get_tree().create_timer(2.0).timeout
		$Game/Instruct.queue_free()
		$scene_cellar/RootNode/cellar/cam_cellar/AnimationPlayer.play("waffle_in")
		await get_tree().create_timer(5.0).timeout
		on_win.emit()		
		#on_lose.emit()
