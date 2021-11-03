extends TextureRect

var font

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	font = DynamicFont.new()
	font.font_data = load("res://JUSTICEOUT.TTF")
	font.size = 100

func _draw():
	draw_string(font, Vector2(180, 540), 'PRESS ESC FOR CONTINUE')
	update()
