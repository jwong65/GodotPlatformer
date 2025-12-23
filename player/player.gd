extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_hitbox: CollisionShape2D =$AttackHitbox/CollisionShape2D
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
		#	Attack animation
	if is_attacking:
		sprite.play("Attack")
		attack_hitbox.disabled = false
		return  # skip other animations while attacking

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
	# Attacking
	if Input.is_action_just_pressed("attack") and !is_attacking:
		is_attacking= true

	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	handlePlayerAnimation(direction)
	move_and_slide()


func _on_attack_hitbox_body_entered(body: Node2D) -> void:
#	The enemies should be in group->enemies (seen by going to the node and selecting a group)
	if body.is_in_group("enemies"):
		body.take_damage(1) 

#This is to disable the attacking hitbox after the animation is finished, also reseting the is_attacking variable
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "Attack":
		attack_hitbox.disabled = true
		is_attacking = false
		
#		This is to make sure the attack is only connecting on these frames. So the attack hitbox is disabled when not between 1 and 5
func _on_animated_sprite_2d_sprite_frames_changed(frame:int) -> void:
	if sprite.animation == "Attack":
		attack_hitbox.disabled = not(frame >=1 and frame<=5)
