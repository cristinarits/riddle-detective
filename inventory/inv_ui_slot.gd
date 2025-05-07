extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display

func update(item: InvItem):
	if !item or item.texture == null:
		item_visual.visible = false
	else:
		item_visual.texture = item.texture
		item_visual.visible = true
