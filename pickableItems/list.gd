extends Area2D
class_name List
@export var interact_name: String = "Her Rules"
@export var is_interactable: bool = true

@export var item: InvItem

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)

		var note_scene = preload("res://UI/note_ui.tscn")
		print("Note scene loaded: ", note_scene != null)
		var note = note_scene.instantiate()
		get_tree().root.add_child(note)
		note.open("Found clue:", '"Always document your experiments. Don’t trust time magic. No more blood spells. —Thorne."')
		
		queue_free()
	else:
		print("Player not found!")
