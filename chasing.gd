extends State

@export var chase_speed : float = 50.0
var target : CharacterBody2D

# It will just chase the player for now
func process_state(delta):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
