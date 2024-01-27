extends Node3D

var active_scene := 1

var scenes = [
	preload("res://scenes/sm_cake_scene_combined.tscn"),
	preload("res://scenes/01_birthday.tscn"),
	preload("res://scenes/02_teeth.tscn"),
	preload("res://scenes/03_lake.tscn"),
	preload("res://scenes/04_nine_eleven.tscn"),
	preload("res://scenes/05_pond.tscn"),
	preload("res://scenes/06_well.tscn"),
	preload("res://scenes/07_basement.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func loadScene(scene_idx: int):
	var scene = scenes[scene_idx]
	var instance = scene.instantiate()
	instance.connect('on_win', show_win_screen)
	instance.connect('on_lose', show_lose_screen)
	add_child(instance)
	if scene_idx > 0:
		pass
		# scenes[scene_idx - 1].queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_play_button_pressed():
	active_scene += 1
	loadScene(active_scene)
	$Control.hide()

func show_win_screen():
	print('won')

func show_lose_screen():
	print('lost')
