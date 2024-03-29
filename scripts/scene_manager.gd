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
	preload("res://scenes/03_clown.tscn"),
	preload("res://scenes/02_teeth.tscn"),
	preload("res://scenes/05_pond.tscn"),
	preload("res://scenes/08_jfk.tscn"),
	preload("res://scenes/07_basement.tscn"),
	preload("res://scenes/09_credits.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var vol_tween
func loadScene(scene_idx: int):
	var scene = scenes[scene_idx]
	if(active_scene_instance):
		active_scene_instance.queue_free()

	$staticsound.stop()
	var staticsound = preload("res://assets/sounds/staticsound.wav")
	staticsound.set_loop_mode(staticsound.LOOP_FORWARD)
	staticsound.set_loop_begin(0)
	staticsound.set_loop_end(48000)
	$staticsound.stream = staticsound
	$staticsound.play()
	#print($staticsound.volume_db)
	if vol_tween:
		vol_tween.kill()
	vol_tween = get_tree().create_tween()
	$staticsound.volume_db = -14
	vol_tween.tween_property($staticsound, "volume_db", 5, 14)
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
