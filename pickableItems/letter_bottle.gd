extends Area2D
class_name LetterBottle
@export var interact_name: String = "Sea Glass"
@export var is_interactable: bool = true

@export var item: InvItem

var interact: Callable = func():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.collect(item)
		print("You picked up the sealed letter.")
		queue_free()
	else:
		print(" Player not found!")
