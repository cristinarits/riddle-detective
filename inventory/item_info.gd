extends Control

@onready var name_label = $VBoxContainer/NameLabel
@onready var description_label = $VBoxContainer/DescriptionLabel

func _ready():
	print("ItemInfo _ready called")
	Global.item_selected.connect(show_item)

func show_item(item: InvItem):
	name_label.text = item.name
	description_label.text = get_item_description(item.name)

func get_item_description(name: String) -> String:
	match name:
		"Flat Stone": return "Rel was here. She sang to the tide."
		"Owl": return "To Thorne, who fixed what no one else could."
		_: return "No details available."
