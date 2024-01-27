extends Node3D

@onready var camera: Camera3D = %camera_mus

func _ready():
	print(camera.name)
