extends CanvasLayer

onready var flagEnd = false

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		if get_tree().current_scene != get_node("/root/Menu"):
			if flagEnd == false:
				$Background.visible = !$Background.visible
				get_tree().paused = !get_tree().paused
			
func endGame():
	$Background.visible = true
	get_tree().paused = true
	flagEnd = true
