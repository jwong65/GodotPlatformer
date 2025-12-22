extends CharacterBody2D

const speed = 100
#Direction
var dir: Vector2

var slime_chase: bool

func _ready():
	slime_chase = false
	$Timer.start()
	
func _physics_process(delta):
	if !slime_chase:
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
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !slime_chase:
#		So this will change the direction of the slime, between right, left and none.
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.ZERO])
		print(dir) 	
