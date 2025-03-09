class_name FiniteStateMachine extends Node

var states: Array[State]
var current_state: State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	states = []
	for child in get_children():
		if child is State:
			states.append(child)
	
	if states.size() > 0:
		transition_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		print("Failed to initialize FSM")

func _process(delta: float) -> void:
	transition_state(current_state.process(delta))

func _physics_process(delta: float) -> void:
	transition_state(current_state.physics_process(delta))

func _unhandled_input(event: InputEvent) -> void:
	transition_state(current_state.handle_input(event))

func transition_state(next_state: State) -> void:
	if next_state == null || next_state == current_state:
		return
	
	if current_state != null:
		current_state.exit()
	
	current_state = next_state
	current_state.enter()
