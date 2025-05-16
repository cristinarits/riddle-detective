extends CanvasLayer

@onready var move_hint: Label = $WASD
@onready var interact_hint: Label = $Interact

var move_hint_shown := true
var interact_hint_shown := true

func _ready():
	move_hint.visible = true
	interact_hint.visible = true

	var player = get_tree().get_first_node_in_group("player")
	if player:
		var interact_component = player.get_node_or_null("InteractingComponent")
		if interact_component and interact_component.has_signal("interacted"):
			interact_component.interacted.connect(_on_player_interacted)

	var mira = get_tree().get_first_node_in_group("mira")
	if mira and mira.has_signal("chatted_with_player"):
		mira.chatted_with_player.connect(_on_player_interacted)
	else:
		print("❌ Mira not found or signal missing")

func _process(_delta):
	if move_hint_shown and (
		Input.is_action_pressed("ui_up") or
		Input.is_action_pressed("ui_down") or
		Input.is_action_pressed("ui_left") or
		Input.is_action_pressed("ui_right")
	):
		move_hint.visible = false
		move_hint_shown = false

func _on_player_interacted():
	if interact_hint_shown:
		interact_hint.visible = false
		interact_hint_shown = false
