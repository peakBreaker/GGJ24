extends Node3D

signal on_win
signal on_lose

func _input(event):
    print(event)
    if event.is_action_pressed("the_button"):
        on_win.emit()
