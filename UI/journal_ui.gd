extends Control

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
