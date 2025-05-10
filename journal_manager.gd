extends Node

var all_notes = []

func add_note(title: String, content: String):
	var new_note = {
		"title": title,
		"content": content,
		"time": Time.get_time_string_from_system()
	}
	all_notes.append(new_note)

func get_notes():
	return all_notes

func clear_notes():
	all_notes.clear()
