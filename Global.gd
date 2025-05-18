extends Node

var has_moved := false
var has_interacted := false

var picked_up_items: = {}

func mark_item_collected(id: String):
	picked_up_items[id] = true

func is_item_collected(id: String) -> bool:
	return picked_up_items.get(id, false)
