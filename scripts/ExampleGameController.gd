extends Node3D

@onready var anim_sprite = $AnimatedSprite3D
var can_intervene = true
# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite.play("waiting")
	$shake_speed.play("shake_speed")
	# Do some action
	await get_tree().create_timer(10.0).timeout
	# Do something afterwards
	anim_sprite.play("inhale")
	await get_tree().create_timer(10.0).timeout
	$Instruction.queue_free()
	can_intervene = false
	anim_sprite.play("waiting")

func _input(event):
	# handle the space button here
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			print("SPACE was pressed")
			anim_sprite.play("crying")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
