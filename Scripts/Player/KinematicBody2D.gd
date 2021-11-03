extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 2.6
export (int) var HP = 1

onready var soundPath = preload("res://Scenes/Sounds.tscn")
onready var globalgd = get_node("/root/Global")

const bulletPath = preload("res://Scenes/Bullet.tscn")
const velocityTemp = Vector2()

var velocity = Vector2()
var rotation_dir = 0
var timeToShoot = 1
var riding = false

func _process(delta):
	if (HP <= 0):
		get_parent().die(get_global_position(), self, true)
	timeToShoot += delta
	if Input.is_action_pressed("shoot"):
		if timeToShoot > 0.3:
			globalgd.soundType = 0
			owner.add_child(soundPath.instance())
			shoot()
			timeToShoot = 0
	$TowerTank.look_at((get_global_mouse_position()))
	
func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if (rotation_dir == 0 and velocity == velocityTemp):
		riding = false
	else:
		riding = true
	animationWheel(riding)

func _physics_process(delta):
	get_input()
	globalgd.lookAtTank = global_position
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
 
func animationWheel(riding):
	if(riding != $WheelAnimation/BR.playing):
		$WheelAnimation/BR.playing = riding
		$WheelAnimation/BL.playing = riding
		$WheelAnimation/FR.playing = riding
		$WheelAnimation/FL.playing = riding

func shoot():
	var bullet = bulletPath.instance()
	owner.add_child(bullet)
	$TowerTank/Shoot.emitting = true
	bullet.transform = $TowerTank/FireSpawn.global_transform
