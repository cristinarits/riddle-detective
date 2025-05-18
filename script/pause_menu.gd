extends Control

@onready var resume_button: Button = $Panel/VBoxContainer/Button
@onready var options_button: Button = $Panel/VBoxContainer/Button2
@onready var back_to_menu_button: Button = $Panel/VBoxContainer/Button3
@onready var exit_button: Button = $Panel/VBoxContainer/Button4

@onready var options_panel: Panel = $Options
@onready var main_panel: Panel = $Panel
@onready var back_button: Button = $Options/back

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

	resume_button.pressed.connect(_on_resume_pressed)
	options_button.pressed.connect(_on_options_pressed)
	back_to_menu_button.pressed.connect(_on_back_to_menu_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	back_button.pressed.connect(_on_back_from_options_pressed)

	options_panel.visible = false
	main_panel.visible = true

func _on_resume_pressed():
	visible = false
	get_tree().paused = false

func _on_options_pressed():
	main_panel.visible = false
	options_panel.visible = true

func _on_back_from_options_pressed():
	options_panel.visible = false
	main_panel.visible = true

func _on_back_to_menu_pressed():
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_exit_pressed():
	get_tree().paused = false
	visible = false
	get_tree().quit()
