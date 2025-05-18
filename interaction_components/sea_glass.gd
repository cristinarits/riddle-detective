extends Area2D
class_name SeaGlass
@export var interact_name: String = "Sea Glass"
@export var is_interactable: bool = true

@export var item: InvItem

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)
		print("you picked up sea glass")

		var note_scene = preload("res://UI/note_ui.tscn")
		print("Note scene loaded: ", note_scene != null)
		var note = note_scene.instantiate()
		get_tree().root.add_child(note)
		note.open("Found Item", "Sea-glass scratched with a compass rose")
		
		queue_free()
	else:
		print("Player not found!")
