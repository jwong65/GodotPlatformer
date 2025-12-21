extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var GRAVITY := 1200.0

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
#		This basically means falling faster every frame for gravity. Delta is time since last frame
		velocity.y += GRAVITY * delta
	else:
#		You are on the floor so you cannot be falling.
		velocity.y = 0

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	
	if direction != 0:
		sprite.flip_h = direction < 0  # True if moving left, false if right
		
	if is_on_floor():
		if direction == 0:
			if sprite.animation != "Idle":
				sprite.play("Idle")
		else:
			if sprite.animation != "Walk":
				sprite.play("Walk")


	move_and_slide()
