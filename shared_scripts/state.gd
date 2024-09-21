# We will never create an instance of this class,
# but our state nodes will extend it
class_name State extends Node

signal change_state(new_state)

var main_sprite : Sprite2D
var body : CharacterStateMachine

# Called by body when the main scene object is first _ready
func initialize():
	pass

# Called by body when this state is entered
func on_enter_state():
	pass

# Called by body when this state is exited
func on_exit_state():
	pass

# Called by body during the _physics_process
## Use for main state logic
func process_state(delta):
	pass

# Called by body for handling user inputs
## Use for state specific input handling
func process_input(event : InputEvent):
	pass
