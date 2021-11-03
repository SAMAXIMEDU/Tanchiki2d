extends Node2D

onready var mobTankPath = preload("res://Scenes/Mob.tscn")
onready var dieTankPath = preload("res://Scenes/DieTank.tscn")
onready var soundPath = preload("res://Scenes/Sounds.tscn")
onready var globalgd = get_node("/root/Global")

export (int) var time = 0

var deltaTime = 0
var soundTime = 0
var pitchScale
var positionMob = Vector2()
var font

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	globalgd.scenePath = self
	randomize()
	font = DynamicFont.new()
	font.font_data = load("res://JUSTICEOUT.TTF")
	font.size = 50
	globalgd.killCount = 0

func _draw():
	draw_string(font, Vector2(150, 50), 'HP: ' + str($Player.HP))
	draw_string(font, Vector2(150, 150), 'Kills: ' + str(globalgd.killCount))
	draw_string(font, Vector2(900, 50), str(int(deltaTime)))

func _process(delta):
	time += delta
	if (time > 4):
		var mobTank = mobTankPath.instance()
		while true:
			positionMob = Vector2(randi() % 1300 + 310, randi() % 870 + 70)
			if positionMob.distance_to($Player.get_global_position()) > 650:
				break
		add_child(mobTank)
		mobTank.position = positionMob
		mobTank.visible = true
		time = 0
	deltaTime += delta
	update()

func _physics_process(delta):
	$Sprite.position = get_global_mouse_position()

func die(vector, body, end):
	var dieTank = dieTankPath.instance()
	add_child(dieTank)
	dieTank.position = vector
	dieTank.emitting = true
	body.queue_free()
	if (end == false):
		globalgd.soundType = 1
		add_child(soundPath.instance())
	if end == true:
		globalgd.end = true
		get_tree().change_scene("res://Scenes/Menu.tscn")


