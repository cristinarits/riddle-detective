extends Node2D

func _ready():
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_level_spawn(destination_tag: String):
	var doors = get_tree().get_nodes_in_group("doors")
	var target_door = null
	
	for door in doors:
		if door.door_tag == destination_tag:
			target_door = door
			break
	
	if target_door:
		var player = get_node("player")
		player.global_position = target_door.spawn.global_position
		NavigationManager.spawn_door_tag = null
	else:
		print("Door with CURRENT SCENE tag '%s' not found!" % destination_tag)
		for door in doors:
			print("Available door_tag: ", door.door_tag)
