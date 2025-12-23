extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var GRAVITY := 1200.0

var is_attacking:bool = false

#This is the ready function that is initalized at the start.
func _ready() -> void:
	Global.playerBody = self
	
func handlePlayerAnimation(direction: float)-> void :
	if direction != 0:
		sprite.flip_h = direction <0
#	Attack animation?
	if is_attacking == true:
		sprite.play()
		
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("JumpUp")
		else:
			sprite.play("JumpDown")
		return 

	if direction == 0:
		sprite.play("Idle")
	else:
		sprite.play("Walk")
	
	
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

	handlePlayerAnimation(direction)
	move_and_slide()


func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
