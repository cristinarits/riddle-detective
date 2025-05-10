extends CharacterBody2D

const SPEED = 30

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

var current_state = IDLE
var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

@export var note_title := "New note"
@export_multiline var note_content := "New clue and information"
@export var add_to_journal := true

func _ready():
	randomize()
	start_pos = position

	if Dialogic.has_signal("signal_event"):
		Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(signal_name: String):
	if signal_name == "inkteller_finished":
		_on_dialogue_dialogue_finished()

func _process(delta):
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif current_state == MOVE and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_w")
		elif dir.x == 1:
			$AnimatedSprite2D.play("walk_e")
		elif dir.y == -1:
			$AnimatedSprite2D.play("walk_n")
		elif dir.y == 1:
			$AnimatedSprite2D.play("walk_s")

	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)

	if Input.is_action_just_pressed("chat"):
		Dialogic.start("inkteller")

func move(delta):
	if !is_chatting:
		position += dir * SPEED * delta

func choose(array):
	array.shuffle()
	return array.front()

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])

func start_chat():
	$Dialogue.start()
	is_roaming = false
	is_chatting = true
	$AnimatedSprite2D.play("idle")

func _on_dialogue_dialogue_finished() -> void:
	is_chatting = false
	is_roaming = true
	show_note_after_chat()

func show_note_after_chat():
	if note_title.is_empty() or note_content.is_empty():
		return

	var note_scene = preload("res://UI/note_ui.tscn").instantiate()
	note_scene.name = "CurrentNote"
	get_tree().root.add_child(note_scene)

	await get_tree().process_frame
	note_scene.open(note_title, note_content)

	if add_to_journal and has_node("/root/JournalManager"):
		JournalManager.add_note(note_title, note_content)

	NavigationManager.town_fog_cleared = true
