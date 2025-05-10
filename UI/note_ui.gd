extends Control

@onready var close_button = $Panel/CloseButton as Button

func _ready():
	visible = false
	close_button.pressed.connect(_on_close_button_pressed)
	set_process_unhandled_key_input(true)

func open(title: String, content: String):
	$Panel/TitleLabel.text = title
	$Panel/ContentLabel.text = content
	visible = true
	close_button.grab_focus()

func _on_close_button_pressed():
	queue_free()

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel") and visible:
		queue_free()

func _exit_tree():
	if get_tree().root.has_node("CurrentNote"):
		get_tree().root.remove_child(get_node("CurrentNote"))
