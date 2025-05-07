extends Area2D
class_name SealedLetter
@export var interact_name: String = "Read Letter"
@export var is_interactable: bool = true

var interact: Callable = func():
	print("You picked up the sealed letter.")
	queue_free()  # Example: remove the item from the world
