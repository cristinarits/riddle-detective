extends Control

var is_dragging := false
var drag_offset := Vector2.ZERO

@onready var close_button = $Panel/CloseButton as Button
@onready var panel = $Panel as Panel

func _ready():
	visible = false
	close_button.pressed.connect(_on_close_button_pressed)
	set_process_unhandled_key_input(true)
	
	panel.gui_input.connect(_on_panel_gui_input)

func open(title: String, content: String):
	$Panel/TitleLabel.text = title
	$Panel/ContentLabel.text = content
	visible = true
	close_button.grab_focus()

func _on_panel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed
			drag_offset = get_global_mouse_position() - global_position
			get_viewport().set_input_as_handled()
	
	elif event is InputEventMouseMotion and is_dragging:
		global_position = get_global_mouse_position() - drag_offset
		get_viewport().set_input_as_handled()

func _on_close_button_pressed():
	queue_free()

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel") and visible:
		queue_free()

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		if get_parent():
			get_parent().remove_child(self)
