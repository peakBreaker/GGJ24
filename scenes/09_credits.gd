extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/credits1.show()
	$Control/credits2.hide()
	await get_tree().create_timer(7.0).timeout
	$Control/credits1.hide()
	$Control/credits2.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
