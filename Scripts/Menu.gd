extends Control

onready var globalgd = get_node("/root/Global")

var font

func _ready():
	randomize()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBoxContainer/StartButton.grab_focus()
	font = DynamicFont.new()
	font.font_data = load("res://JUSTICEOUT.TTF")
	font.size = 100

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/PlayScene.tscn")
	
func _on_QuitButton_pressed():
	get_tree().quit()

func _draw():
	if globalgd.end == true:
		draw_string(font, Vector2(750, 500), 'KILLS: ' + str(globalgd.killCount), Color(1, 0, 0))

