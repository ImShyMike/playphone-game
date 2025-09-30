extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1500
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0, 1.0) var acceleration = 0.25

var was_on_floor = false

func _physics_process(delta):
	velocity.y += gravity * delta

	var dir := 0
	if Input.is_key_pressed(KEY_LEFT):
		dir -= 1
	if Input.is_key_pressed(KEY_RIGHT):
		dir += 1

	if dir != 0:
		velocity.x = lerp(velocity.x, float(dir) * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)


	if Input.is_key_pressed(KEY_UP) and is_on_floor():
		velocity.y = jump_speed


	move_and_slide()

	# Check for collisions after movement
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "kill":
			_restart_scene()
			
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "win":
			_win_game()
	
	was_on_floor = is_on_floor()



func _restart_scene():
	get_tree().call_deferred("change_scene_to_file", "res://node_2d.tscn")

func _win_game():
	get_tree().call_deferred("change_scene_to_file", "res://win.tscn")
