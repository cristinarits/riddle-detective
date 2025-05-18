extends Control

@onready var text_edit = $Panel/TextEdit
@onready var close_button = $Panel/CloseButton

const SAVE_PATH = "user://notebook_save.txt"

func _ready():
	close_button.pressed.connect(_on_close_button_pressed)
	hide()
	load_notes()
	text_edit.text_changed.connect(save_notes)

func open():
	show()
	text_edit.grab_focus()
	get_tree().paused = false

func _on_close_button_pressed():
	hide()
	get_tree().paused = false

func save_notes():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(text_edit.text)
		file.close()

func load_notes():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			text_edit.text = file.get_as_text()
			file.close()
			
