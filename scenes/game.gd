extends Node

func _ready():
	var door_list = get_tree().get_nodes_in_group("doors")
	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		print("❌ Player not found!")
		return

	for door in door_list:
		if door.destination_door_tag == NavigationManager.spawn_door_tag:
			player.global_position = door.spawn.global_position
			print("✅ Spawned player at door:", door.destination_door_tag)
			break
