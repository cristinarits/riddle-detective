extends CharacterBody2D

const SPEED = 30

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

var current_state = IDLE
var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

func _ready():
	randomize()
	start_pos = position

func _process(delta):
	# Animation handling
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif current_state == MOVE and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_w")
		elif dir.x == 1:
			$AnimatedSprite2D.play("walk_e")
		elif dir.y == -1:
			$AnimatedSprite2D.play("walk_n")
		elif dir.y == 1:
			$AnimatedSprite2D.play("walk_s")

	# Movement logic
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)

	# ✅ Chat interaction using group and distance check
	if Input.is_action_just_pressed("chat"):
		var player = get_tree().get_first_node_in_group("player")
		if player and position.distance_to(player.position) < 32: # Adjust the distance as needed
			print("chatting with npc")
			$Dialogue.start()
			is_roaming = false
			is_chatting = true
			$AnimatedSprite2D.play("idle")

func move(delta):
	if !is_chatting:
		position += dir * SPEED * delta

func choose(array):
	array.shuffle()
	return array.front()

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])

func _on_dialogue_dialogue_finished() -> void:
	is_chatting = false
	is_roaming = true
