# Our state machine class will extend CharacterBody2D so that
# We can use it on our root scene element for enemies.
class_name CharacterStateMachine extends CharacterBody2D
# This class manages a state machine and does character body things

@export var initial_state : State
@onready var current_state : State = initial_state
# Storage of all states in machine
var all_states : Array[State]
	
func _input(event):
	current_state.process_input(event)
	
func _ready():
	# Search for a chile node named "States" and initialize all states
	for child in $States.get_children():
		if (child is State):
			all_states.append(child)
			child.change_state.connect(on_change_state)

			child.body = self
			child.initialize()
		# if the children in "states" are not states throw a warning
		else:
			push_warning("Child " + child.name + " is not a state for " + self.name)
			
	post_ready_setup()
	
# An optional function for class specific setup after Ready
func post_ready_setup():
	pass
	
func _physics_process(delta: float):
	current_state.process_state(delta)
# Usually connected to a state change signal.
## Exits old state and initalizes new one            
func on_change_state(next_state : State):
	current_state.on_exit_state()
	current_state = next_state
	current_state.on_enter_state()
