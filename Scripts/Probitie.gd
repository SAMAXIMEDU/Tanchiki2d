extends Node

onready var type = get_node("/root/Global").soundType

var time = 0
var rand = null
var sound = [0.0, 4.0, 7.25]

func _ready():
	randomize()
	start(type)
	
func _process(delta):
	time += delta
	match type:
		0:
			if(time > 0.4):
				queue_free()
		1:
			match rand:
				0:
					if(time > 3.25):
						queue_free()
				1:
					if(time > 3.20):
						queue_free()
				2:
					if(time > 3):
						queue_free()

func start(type):
	match type:
		0:
			$ShootAudio.play(0)
		1:
			rand = randi() % 3
			$Probitie.play(sound[rand])
