extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0

@onready var sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Track jumps
var jump_count = 0
const MAX_JUMPS = 2  # Allows one normal jump and one double jump

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Reset jump count when the character is on the floor
		jump_count = 0

	# Handle jumping
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1  # Increment the jump count

	# Get input direction
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip sprite
	if direction > 0: 
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	elif not is_on_floor() and jump_count == 2:
		sprite.play("doublejump")
	else:
		sprite.play("jump")
	
	# Handle horizontal movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Apply movement
	move_and_slide()
