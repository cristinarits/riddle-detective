extends Control

<<<<<<< Updated upstream
@onready var notes_container = $Panel/VBoxContainer/NotesContainer/VBoxContainer

func _ready():
	visible = false
	print("JournalUI done")

func open_journal():
	visible = true
	update_notes_display()
	print("Journal opened: ", notes_container.get_child_count())

func close_journal():
	visible = false

func update_notes_display():
	for child in notes_container.get_children():
		child.queue_free()
	
	for i in range(JournalManager.all_notes.size()-1, -1, -1):
		var note = JournalManager.all_notes[i]
		var note_panel = create_note_panel(note)
		notes_container.add_child(note_panel)

func create_note_panel(note):
	var panel = PanelContainer.new()
	panel.custom_minimum_size = Vector2(300, 100)
	
	var vbox = VBoxContainer.new()
	vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	var title = Label.new()
	title.text = note["title"]
	title.add_theme_font_size_override("font_size", 20)
	
	var content = Label.new()
	content.text = note["content"]
	content.autowrap_mode = TextServer.AUTOWRAP_WORD
	
	var time = Label.new()
	time.text = note["time"]
	time.add_theme_color_override("font_color", Color("888888"))
	
	vbox.add_child(title)
	vbox.add_child(content)
	vbox.add_child(time)
	panel.add_child(vbox)
	
	return panel
=======
@onready var notes_list = $Panel/VBoxContainer/HBoxContainer/NotesList
@onready var title_label = $Panel/VBoxContainer/HBoxContainer/NoteContent/TitleLabel
@onready var content_label = $Panel/VBoxContainer/HBoxContainer/NoteContent/ContentLabel

func _ready():
	visible = false
	update_journal()
	
	# Подключаем сигналы
	notes_list.item_selected.connect(_on_note_selected)
	$Panel/VBoxContainer/CloseButton.pressed.connect(hide)

func update_journal():
	notes_list.clear()
	var notes = JournalManager.get_notes()
	
	if notes.is_empty():
		title_label.text = "Journal is empty"
		content_label.text = "Interact with characters to gather information"
		return
	
	for note in notes:
		notes_list.add_item(note["title"])

func _on_note_selected(index: int):
	var note = JournalManager.get_notes()[index]
	title_label.text = note["title"]
	content_label.text = note["content"]

func open():
	update_journal()
	visible = true
	notes_list.grab_focus()
	if notes_list.item_count > 0:
		notes_list.select(0)
		_on_note_selected(0)

func _unhandled_input(event):
	if event.is_action_pressed("journal"):
		if visible:
			hide()
		else:
			open()
		get_viewport().set_input_as_handled()
>>>>>>> Stashed changes
