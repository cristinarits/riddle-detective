extends Area2D
class_name FlatStone

@export var interact_name: String = "Flat Stone"
@export var is_interactable: bool = true
@export var item: InvItem
@export var item_id: String = "flat_stone_001"

func _ready():
	if Global.is_item_collected(item_id):
		queue_free()

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)
		Global.mark_item_collected(item_id)
		print("flat stone picked up")
		
		var note_scene = preload("res://UI/note_ui.tscn")
		var note = note_scene.instantiate()
		get_tree().root.add_child(note)
		note.open("Found item", '"Rel was here. She sang to the tide."')
		
		queue_free()
	else:
		print("Player not found!")
