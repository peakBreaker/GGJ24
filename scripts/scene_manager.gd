extends Node3D

var scenes = [
	preload("res://scenes/sm_cake_scene_combined.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func loadScene(scene_idx: int):
	var scene = scenes[scene_idx]
	var instance = scene.instantiate()
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	loadScene(0)
	$Control.hide()
