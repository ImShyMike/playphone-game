extends CharacterBody2D

@export var maxHorisontalSpeed = 300
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var hasDash = 1
@export var extraJumps = 20;
@export var boost_strength: float = 700.0 

func death():
	var spawn = get_parent().get_child(2).get_child(0).get_node("SpawnPoint")
	if spawn:
		global_position = spawn.global_position
func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Jumpand (is_on_floor() or extraJumps > 0)
	if Input.is_action_just_pressed("up") and (is_on_floor() or extraJumps > 0):
		velocity.y = JUMP_VELOCITY
		if extraJumps > 0:
			extraJumps -= 1

	#horizontal movement
	var direction := Input.get_axis("left", "right") 
	
	if direction != 0:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0 
		if not $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play("walk") 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.stop()  
	
		
	
	
	
	
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	
	velocity.y = -boost_strength


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	velocity.y = -boost_strength


func _on_hurtbox_body_entered(body: Node2D) -> void:
	death()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	death()
