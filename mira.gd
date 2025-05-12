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

@export var note_title := "New clue"
@export_multiline var note_content := "Lia is known by Mira, Direction: Academy of Aetheria"
@export var add_to_journal := true

func _ready():
	randomize()
	start_pos = position
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)

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
		var player = get_tree().get_first_node_in_group("player")
		if player and position.distance_to(player.position) < 32:
			start_chat()

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
	Dialogic.start("mia_baker")
	is_roaming = false
	is_chatting = true
	$AnimatedSprite2D.play("idle")

func _on_dialogic_timeline_ended():
	is_chatting = false
	is_roaming = true
	show_note_after_chat()

func show_note_after_chat():
	if note_title.is_empty() or note_content.is_empty():
		return
	
	if not ResourceLoader.exists("res://UI/note_ui.tscn"):
		push_error("NoteUI scene not found at path: res://UI/note_ui.tscn")
		return
		
	var note_scene = preload("res://UI/note_ui.tscn").instantiate()
	note_scene.name = "CurrentNote"
	
	get_tree().root.add_child(note_scene)
	
	await get_tree().process_frame
	
	if note_scene.has_method("open"):
		note_scene.open(note_title, note_content)
	else:
		push_error("NoteUI instance doesn't have open() method")
	
	if add_to_journal and has_node("/root/JournalManager"):
		JournalManager.add_note(note_title, note_content)
