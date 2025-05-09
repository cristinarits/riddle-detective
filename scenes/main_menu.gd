extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _ready():
	main_buttons.visible = true
	options.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")


func _on_settings_pressed() -> void:
	print("pressed")
	main_buttons.visible = false
	options.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_options_pressed() -> void:
	_ready()
