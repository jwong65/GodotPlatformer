extends CharacterBody2D

const speed = 100
@export var GRAVITY := 1200.0
@export var CHASE_RANGE := 100
@export var HEALTH := 3
#Direction
var dir: Vector2

var slime_chase: bool
var player: CharacterBody2D

func _ready():
	slime_chase = false
	$Timer.start()

func _physics_process(delta):
#	Gravity
	if !is_on_floor():
		velocity.y+=GRAVITY*delta
	else:
		velocity.y = 0

#	SO the slime will chase after the player if they're within the chase range. This should change to chase after being attacked.
	if Global.playerBody !=null:
		var distance = position.distance_to(Global.playerBody.position)
		slime_chase = distance <=CHASE_RANGE
	
#	Moves towards player
	if slime_chase:
		player=Global.playerBody
#		This will get the left right direction properly with sign giving us positive or negative
#		This is important because left is negative, not moving is 0 and right is positive.
		velocity.x = sign(player.position.x - position.x) * speed
		dir.x = sign(velocity.x)
	else:
		velocity.x = dir.x * speed
	handle_animation()
	move_and_slide()

func choose(array):
	array.shuffle()
	return array.front()
	
func handle_animation():
	var animatedSprite = $AnimatedSprite2D

#	So if velocity is 0 then we'll play idle
	if velocity.x == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("walk")
#		So if the direction is negative it will flip otherwise it won't.
		if dir.x == -1:
			animatedSprite.flip_h = false
		elif dir.x == 1:
			animatedSprite.flip_h = true
			

func _on_timer_timeout():
#	This timer will show that how often the directions will change and choosing the direction
	$Timer.wait_time = choose([1.0, 2.0])
	if !slime_chase:
#		So this will change the direction of the slime, between right, left and none.
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.ZERO])
