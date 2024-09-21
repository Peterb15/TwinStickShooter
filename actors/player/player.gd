extends CharacterBody2D

@export var projectile_scene: Resource
@export var teleport_scene: Resource
@export var lightning_scene: Resource
@export var move_speed: float = 200.0

# Toggle variable to switch between teleport and projectile
var use_teleport: bool = false
func _ready():
	lightning_scene = preload("res://actors/lightning/lightning.tscn")# Replace with the correct path

func _input(event):
	
	if (event is InputEventMouseButton):
		# Only shoot on left click pressed down
		if (event.button_index == 1 and event.is_pressed()):
			var new_projectile = projectile_scene.instantiate()
			get_parent().add_child(new_projectile)
			var projectile_forward = Vector2.from_angle(get_local_mouse_position().angle())
			new_projectile.fire(projectile_forward, 1000.0)
			new_projectile.position = $ProjectileRefPoint.global_position
		if (event.button_index == 2 and event.is_pressed()): #ADD A TIMER
			var new_teleport = teleport_scene.instantiate()
			get_parent().add_child(new_teleport)
			print("TELE")
			var teleport_forward = get_global_mouse_position()
			new_teleport.location(teleport_forward)
			new_teleport.position = $TeleportRefPoint.global_position
	elif event is InputEventKey:
		if event.keycode == KEY_Q and event.pressed:
			var new_lightning = lightning_scene.instantiate()  # Correct instantiation
			get_parent().add_child(new_lightning)
			print("Light")
		
		# Calculate the direction to fire the lightning
			var lightning_forward = (get_global_mouse_position() - $LightningRefPoint.global_position).normalized()
		
		# Call the fire method and set the position	
			new_lightning.fire(lightning_forward, 1000.0)
			new_lightning.position = $LightningRefPoint.global_position


func _physics_process(delta):
	
	#look_at(get_viewport().get_mouse_position())
	
	velocity = Input.get_vector("move_left", \
		"move_right", \
		"move_up", \
		"move_down") * move_speed
	move_and_slide()
	
	#math to sort oout dir and animation
	var angle = rad_to_deg(velocity.angle()) + 180
	if(velocity.length() < 10):
		$AnimationPlayer.play("idle_front")
	else:
		if(angle > 135 and angle < 225):
			$AnimationPlayer.play("walk_right")
		elif (angle > 225 and angle < 315):
			$AnimationPlayer.play("walk_front")
		elif (angle > 315 or angle < 45):
			$AnimationPlayer.play("walk_left")
		elif (angle > 45 and angle < 135):
			#$AnimationPlayer.play("walk_up")
			print("Fix walk up")

	
