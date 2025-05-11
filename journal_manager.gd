extends Node

var all_notes = []

func add_note(title: String, content: String):
	if not is_note_exists(title, content):
		var new_note = {
			"title": title,
			"content": content,
			"timestamp": Time.get_datetime_string_from_system()
		}
		all_notes.append(new_note)
		save_notes()

func get_notes():
	return all_notes.duplicate()

func is_note_exists(title: String, content: String) -> bool:
	for note in all_notes:
		if note["title"] == title and note["content"] == content:
			return true
	return false

func clear_notes():
	all_notes.clear()
	save_notes()

func save_notes():
	var save_file = FileAccess.open("user://journal.save", FileAccess.WRITE)
	save_file.store_var(all_notes)

func load_notes():
	if FileAccess.file_exists("user://journal.save"):
		var save_file = FileAccess.open("user://journal.save", FileAccess.READ)
		all_notes = save_file.get_var()

func _ready():
	load_notes()
