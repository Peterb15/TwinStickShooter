extends Area2D

var velocity: Vector2 = Vector2(0, 0)

# Function to set the velocity towards a specified direction
func location(forward: Vector2):
	velocity = forward

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = velocity

# Called when the teleport timer times out
func _on_teleport_time_timeout():
	print("TELEPORT")

	# Get the teleport node's position
	var teleport_position = position  # Assuming this node is the teleport node

	# Set the player's position to the teleport position
	var player = get_tree().root.get_node("Main/Player")
	if player:
		player.position = teleport_position

	queue_free()  # This 
