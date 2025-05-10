extends Node

var all_notes = []
var journal_ui_instance = null

func _ready():
	load_notes()
	print("JournalManager done Updated notes: ", all_notes.size())

func add_note(title: String, content: String):
<<<<<<< Updated upstream
	# Проверка на дубликаты
	for note in all_notes:
		if note["title"] == title and note["content"] == content:
			return
	
	var new_note = {
		"title": title,
		"content": content,
		"time": Time.get_time_string_from_system()
	}
	all_notes.append(new_note)
	save_notes()
	print("Added note: ", title)
	
	# Немедленно обновляем UI если журнал открыт
	if journal_ui_instance and journal_ui_instance.visible:
		journal_ui_instance.update_notes_display()

func toggle_journal():
	if not journal_ui_instance:
		journal_ui_instance = preload("res://UI/journal_ui.tscn").instantiate()
		get_tree().root.add_child(journal_ui_instance)
	
	if journal_ui_instance.visible:
		journal_ui_instance.close_journal()
	else:
		journal_ui_instance.open_journal()
		journal_ui_instance.update_notes_display()  # Важно: обновляем при каждом открытии

func get_notes():
	return all_notes
func save_notes():
	var file = FileAccess.open("user://journal.dat", FileAccess.WRITE)
	file.store_var(all_notes)
	print("Notes saved")

func clear_notes():
	all_notes.clear()
func load_notes():
	if FileAccess.file_exists("user://journal.dat"):
		var file = FileAccess.open("user://journal.dat", FileAccess.READ)
		all_notes = file.get_var()
		print("Notes: ", all_notes.size())
=======
	# Проверяем дубликаты
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

# Сохранение/загрузка
func save_notes():
	var save_file = FileAccess.open("user://journal.save", FileAccess.WRITE)
	save_file.store_var(all_notes)

func load_notes():
	if FileAccess.file_exists("user://journal.save"):
		var save_file = FileAccess.open("user://journal.save", FileAccess.READ)
		all_notes = save_file.get_var()

func _ready():
	load_notes()
>>>>>>> Stashed changes
