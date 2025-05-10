extends Area2D
class_name FlatStone

@export var interact_name: String = "Flat Stone"
@export var is_interactable: bool = true
@export var item: InvItem

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)
		print("flat stone picked up")
		
		var note_scene = preload("res://UI/note_ui.tscn")
		print("Note scene loaded: ", note_scene != null)
		var note = note_scene.instantiate()
		get_tree().root.add_child(note)
		note.open("", "Rel was here. She sang to the tide.")
		
		queue_free()
	else:
		print("Player not found!")
