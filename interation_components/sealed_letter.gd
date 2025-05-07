extends Area2D
class_name SealedLetter
@export var interact_name: String = "(E)"
@export var is_interactable: bool = true

var interact: Callable = func():
	print("You picked up the sealed letter.")
	queue_free()
