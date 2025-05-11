extends Control

@onready var notes_list = $Panel/VBoxContainer/HBoxContainer/NotesList
@onready var title_label = $Panel/VBoxContainer/HBoxContainer/NoteContent/TitleLabel
@onready var content_label = $Panel/VBoxContainer/HBoxContainer/NoteContent/ContentLabel

func _ready():
	visible = false
	update_journal()
	$Panel/VBoxContainer/CloseButton.pressed.connect(hide)

func update_journal():
	notes_list.clear()
	var notes = JournalManager.get_notes()
	
	if notes.is_empty():
		title_label.text = "Journal is empty"
		content_label.text = "Talk to characters to gather clues"
		return
	
	for i in range(notes.size()):
		notes_list.add_item(notes[i]["title"])
	
	if notes_list.item_count > 0:
		notes_list.select(0)
		_on_note_selected(0)

func _on_note_selected(index: int):
	var note = JournalManager.get_notes()[index]
	title_label.text = note["title"]
	content_label.text = note["content"]

func open():
	update_journal()
	visible = true
	notes_list.grab_focus()

func _unhandled_input(event):
	if event.is_action_pressed("journal"):
		if visible:
			hide()
		else:
			open()
		get_viewport().set_input_as_handled()
