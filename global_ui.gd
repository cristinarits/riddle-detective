extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu

func _ready():
	print("pause_menu is:", pause_menu)
	if pause_menu == null:
		push_error("not found")

func toggle_pause():
	if pause_menu == null:
		push_error("null")
		return

	pause_menu.visible = !pause_menu.visible
	get_tree().paused = pause_menu.visible

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
