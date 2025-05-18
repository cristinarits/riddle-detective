extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var details_panel: ColorRect = $DetailsPanel
@onready var item_name: Label = $DetailsPanel/ItemName
@onready var item_text: Label = $DetailsPanel/Message
@onready var item_button: Button = $ItemButton

var item: InvItem = null

func _ready():
	details_panel.visible = false

	item_button.mouse_entered.connect(_on_item_button_mouse_entered)
	item_button.mouse_exited.connect(_on_item_button_mouse_exited)

func update(slot: InvSlot):
	item = slot.item

	if item == null or item.texture == null:
		item_visual.visible = false
		details_panel.visible = false
		item_button.disabled = true
	else:
		item_visual.texture = item.texture
		item_visual.visible = true

		var target_size = Vector2(56, 56)
		var tex_size = item.texture.get_size()
		var scale_factor = target_size / tex_size
		item_visual.scale = scale_factor * 0.8

		item_visual.position = Vector2.ZERO

		item_name.text = item.name
		item_text.text = item.text if item.text != "" else "No description."
		item_button.disabled = false
		details_panel.visible = false

func _on_item_button_mouse_entered():
	if item:
		details_panel.visible = true

func _on_item_button_mouse_exited():
	details_panel.visible = false
