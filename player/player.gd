extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_hitbox: CollisionShape2D =$AttackHitbox/CollisionShape2D
@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var GRAVITY := 1200.0

var attack_type: String
var current_attack: bool
#This is the ready function that is initalized at the start.
func _ready() -> void:
	Global.playerBody = self
	current_attack = false
	
func handlePlayerAnimation(direction: float)-> void :
	if direction != 0:
		sprite.flip_h = direction <0

	if not is_on_floor() and !current_attack:
		if velocity.y < 0:
			sprite.play("JumpUp")
		else:
			sprite.play("JumpDown")
		return 

	if direction == 0 and !current_attack:
		sprite.play("Idle")
	else:
		sprite.play("Walk")
		
func handle_attack_animation(attack_type: String):
	pass

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
	
	if !current_attack and Input.is_action_just_pressed("attack"):
		current_attack = true
		attack_type = 'single'
		handle_attack_animation(attack_type)
		
	handlePlayerAnimation(direction)
	move_and_slide()
