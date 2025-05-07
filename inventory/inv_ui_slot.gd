extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display

func update(slot: InvSlot):
	if !slot.item or slot.item.texture == null:
		item_visual.visible = false
	else:
		item_visual.texture = slot.item.texture
		item_visual.visible = true
