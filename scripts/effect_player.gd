class_name EffectPlayer extends Node2D

@export var particles: Array[CPUParticles2D] = []
@export var audios: Array[AudioStreamPlayer2D] = []

func stop():
    for particle in particles:
        particle.emitting = false
    for audio in audios:
        audio.stop()

func play():
    for particle in particles:
        particle.emitting = true
    for audio in audios:
        audio.stop()
