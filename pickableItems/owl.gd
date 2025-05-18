extends Area2D
class_name Owl

@export var interact_name: String = "Owl"
@export var is_interactable: bool = true

@export var item: InvItem
@export var item_id: String = "owl_001"

func _ready():
	if Global.is_item_collected(item_id):
		queue_free()

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)
		Global.mark_item_collected(item_id)
		print("owl")

		var note_scene = preload("res://UI/note_ui.tscn")
		var note = note_scene.instantiate()
		get_tree().root.add_child(note)
		note.open("Found Item", '"To Thorne, who fixed what no one else could."')

		queue_free()
	else:
		print("Player not found!")
