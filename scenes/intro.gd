extends Control

@onready var label = $Label
var full_text := ""
var current_index := 0
var typing_speed := 0.05 # seconds between characters

func _ready():
	full_text = label.text        # Get the text already set in the Label node
	label.text = ""               # Clear it to start from blank
	current_index = 0
	typing_loop()                 # Start the gradual reveal

func typing_loop() -> void:
	while current_index < full_text.length():
		label.text += full_text[current_index]
		current_index += 1
		await get_tree().create_timer(typing_speed).timeout

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
