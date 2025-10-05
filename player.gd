extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var extraJumps = 0;

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or extraJumps > 0):
		velocity.y = JUMP_VELOCITY
		if extraJumps > 0:
			extraJumps -= 1

	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right") 

	if direction != 0:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0 
		if not $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play("walk") 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.stop()  
		
	print(global_position.y)
	if global_position.y > 100:
		var spawn = get_parent().get_child(2).get_child(0).get_node("SpawnPoint")
		if spawn:
			global_position = spawn.global_position

	move_and_slide()
