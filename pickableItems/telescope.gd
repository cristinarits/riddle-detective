extends Area2D
class_name Telescope

@export var interact_name: String = "Telescope"
@export var is_interactable: bool = true

@export var item: InvItem
@export var item_id: String = "telescope_001"

func _ready():
	if Global.is_item_collected(item_id):
		queue_free()

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)
		Global.mark_item_collected(item_id)
		print("telescope")

		var note_scene = preload("res://UI/note_ui.tscn")
		var note = note_scene.instantiate()
		get_tree().root.add_child(note)
		note.open("Found Item", "Aurelia’s Crown — charted by hand, by the one who would not forget the stars.")

		queue_free()
	else:
		print("Player not found!")
