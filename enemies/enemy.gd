extends CharacterBody2D
class_name enemySlime	

const speed = 100.0
var slime_chase = false
const GRAVITY := 1200.0

@export var health = 3
@export var health_max = 3
@export var health_min = 0

var dead : bool = false
var takingDamage : bool = false
@export var takingDamageDealt = 1
@export var dealingDamge = 1	

var dir:Vector2 = Vector2.ZERO
@export var knockback_force = 200
var is_roaming: bool = false	

func _process(delta: float): 
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.x += 0
	move(delta)
	move_and_slide()

func move(delta):
#	If not dead
	if !dead:
		if !slime_chase:
			velocity += dir * speed * delta
		is_roaming = true
	elif dead:
		velocity.x = 0 

func _on_direction_timer_timeout():
#	This is the direction timer which is shuffled in the choose function
	$DirectionTimer.wait_time = choose([1.5, 2.0, 2.5])
	if !slime_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0

#This will be the shuffle function.
func choose(array):
	array.shuffle()
	return array.front()
