extends KinematicBody2D

export (int) var speed = 100

onready var path_follow = get_parent()
onready var globalgd = get_node("/root/Global")
onready var dieTankPath = get_node("/root/Scene")

const bulletPath = preload("res://Scenes/Bullet.tscn")

var move_direction = 0
var time = 0
var HP = 3
var velocity = Vector2()

func _ready():
	add_to_group("mob")

func _process(delta):
	if(HP <= 0):
		globalgd.killCount += 1
		dieTankPath.die(get_global_position(), self, false)

func _physics_process(delta):
	#MovementLoop(delta)
	time += delta
	if time > 1:
		shoot()
		$ShootAudio.play(0)
		time = 0
	look_at(globalgd.lookAtTank)
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_collide(velocity * delta)
	if time > 0.4:
		$ShootAudio.stop()

#func MovementLoop(delta):
#	var prepos = path_follow.get_global_position()
#	path_follow.set_offset(path_follow.get_offset() + 100 * delta)
#	var pos = path_follow.get_global_position()
#	move_direction = (pos.angle_to_point(prepos) / 3.14) * 180
#	rotation_degrees = move_direction
#	$TowerTank.look_at(globalgd.lookAtTank)
	
func shoot():
	var bullet = bulletPath.instance()
	globalgd.scenePath.add_child(bullet)
	$TowerTank/Shoot.emitting = true
	bullet.transform = $TowerTank/FireSpawn.global_transform
