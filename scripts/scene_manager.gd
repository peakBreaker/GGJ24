extends Node3D

var active_scene := 0
var active_scene_instance
@onready var lose_menu: Panel = %LoseMenu
@onready var win_menu: Panel = %WinMenu
@onready var start_menu: Panel = %StartMenu
@onready var winning_decorations: EffectPlayer = %winning_decorations
@onready var losing_decorations: EffectPlayer = %losing_decorations

var scenes = [
	preload("res://scenes/01_birthday.tscn"),
	#preload("res://scenes/02_teeth.tscn"),
	preload("res://scenes/03_clown.tscn"),
	#preload("res://scenes/04_nine_eleven.tscn"),
	preload("res://scenes/05_pond.tscn"),
	#preload("res://scenes/06_well.tscn"),
	preload("res://scenes/08_jfk.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func loadScene(scene_idx: int):
	var scene = scenes[scene_idx]
	if(active_scene_instance):
		active_scene_instance.queue_free()
	active_scene_instance = scene.instantiate()
	print('loading scene %s' % active_scene_instance.name)
	active_scene_instance.connect('on_win', show_win_screen)
	active_scene_instance.connect('on_lose', show_lose_screen)
	add_child(active_scene_instance)

func _on_play_button_pressed():
	loadScene(active_scene)
	active_scene += 1
	winning_decorations.stop()
	losing_decorations.stop()
	start_menu.hide()
	win_menu.hide()
	lose_menu.hide()

func show_win_screen():
	print('win')
	winning_decorations.play()
	win_menu.show()

func show_lose_screen():
	print('lost')
	losing_decorations.play()
	lose_menu.show()
