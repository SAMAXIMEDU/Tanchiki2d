extends KinematicBody2D

export var speed = 750


func _physics_process(delta):
	position += transform.x * speed * delta

func bullet_gone():
	queue_free()
