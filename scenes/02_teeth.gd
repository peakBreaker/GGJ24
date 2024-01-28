extends Node3D

signal on_win
signal on_lose

var game_over = false

@onready var boy_animation: AnimatedSprite3D = $Game/boy_animated
@onready var hand_animation: AnimationTree = $Game/hand_animation_tree
@onready var hand_sprite: Sprite3D = $Game/hand_teeth
@onready var boy_audio = $Game/boy_audio
@onready var instruct = $Game/Instruct

func _ready():
    boy_animation.play("talking")
    hand_sprite.hide()

    await get_tree().create_timer(10).timeout
    game_over = true
    on_win.emit()


func _input(event):
    if event.is_action_pressed("the_button") and !game_over:
        game_over = true
        hand_sprite.show()
        boy_animation.play("shook")
        hand_animation.active = true
        boy_audio.stop()
        instruct.hide()

        await get_tree().create_timer(5).timeout
        on_lose.emit()
