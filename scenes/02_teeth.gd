extends Node

signal on_win
signal on_lose

func _input(event):
    if event.is_action_pressed("the_button"):
        on_lose.emit()
