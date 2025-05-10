extends Node

const scene_game = preload("res://scenes/game.tscn")
const scene_shore = preload("res://scenes/shore.tscn")
const scene_observatory = preload("res://scenes/observatory.tscn")
const scene_loft = preload("res://scenes/loft.tscn")
const scene_underground = preload("res://scenes/underground_library.tscn")

signal on_trigger_player_spawn

var spawn_door_tag
var town_fog_cleared := false

func go_to_level(level_tag, destination_tag):
	var scene_to_load

	match level_tag:
		"game":
			scene_to_load = scene_game
		"observatory":
			scene_to_load = scene_observatory
		"shore":
			scene_to_load = scene_shore
		"loft":
			scene_to_load = scene_loft
		"underground_library":
			scene_to_load = scene_underground

	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		call_deferred("_change_scene_deferred", scene_to_load)

func _change_scene_deferred(scene_to_load):
	get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
