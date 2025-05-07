extends Area2D

@export var prompt_label_path: NodePath  # Optional: path to the prompt label node
@onready var prompt_label = get_node_or_null(prompt_label_path)

var player_inside = false
var has_been_read = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	if prompt_label:
		prompt_label.visible = false

func _process(delta):
	if player_inside and not has_been_read and Input.is_action_just_pressed("ui_accept"):
		read_letter()

func _on_body_entered(body):
	if body.name == "player":  # or use `body is Player`
		player_inside = true
		if prompt_label:
			prompt_label.visible = true

func _on_body_exited(body):
	if body.name == "player":
		player_inside = false
		if prompt_label:
			prompt_label.visible = false

func read_letter():
	has_been_read = true
	print("You read the letter...")
	# TODO: Replace with your dialogue UI or journal update logic
	if prompt_label:
		prompt_label.visible = false
