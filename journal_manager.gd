extends Node

var notes = []

func add_note(title: String, content: String):
	for note in notes:
		if note["title"] == title and note["content"] == content:
			return
	
	var new_note = {
		"title": title,
		"content": content,
		"time": Time.get_datetime_string_from_system()
	}
	notes.append(new_note)
	save_notes()
	print("Note added: ", title) 

func get_notes():
	return notes.duplicate()

func save_notes():
	var file = FileAccess.open("user://journal.dat", FileAccess.WRITE)
	if file:
		file.store_var(notes)
	else:
		push_error("Failed to save journal")

func load_notes():
	if FileAccess.file_exists("user://journal.dat"):
		var file = FileAccess.open("user://journal.dat", FileAccess.READ)
		if file:
			notes = file.get_var()
			print("Loaded ", notes.size(), " notes")

func _ready():
	load_notes()
