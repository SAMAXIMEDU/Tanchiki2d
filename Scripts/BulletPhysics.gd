extends Area2D

onready var globalgd = get_node("/root/Global")

export var speed = 350

func _physics_process(delta):
	position += transform.x * speed * delta
	
func _on_Area2D_body_entered(body):
	if (body.is_in_group("tank")):
		queue_free()
		body.HP -= 1
	if (body.is_in_group("mob")):
		queue_free()
		body.HP -= 1


func _on_Area2D_body_exited(body):
	if (body.is_in_group("walls")):
		queue_free()
