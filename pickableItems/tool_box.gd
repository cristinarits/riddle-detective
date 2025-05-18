extends Area2D
class_name ToolBox

@export var interact_name: String = "Tool Box"
@export var is_interactable: bool = true

@export var item: InvItem
@export var item_id: String = "toolbox_001"

func _ready():
	if Global.is_item_collected(item_id):
		queue_free()

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)

		Global.mark_item_collected(item_id)

		var note_scene = preload("res://UI/note_ui.tscn")
		print("Note scene loaded: ", note_scene != null)
		var note = note_scene.instantiate()
		get_tree().root.add_child(note)
		note.open("Found Item", 'The nameplate says "A. Thorne"')

		queue_free()
	else:
		print("Player not found!")
