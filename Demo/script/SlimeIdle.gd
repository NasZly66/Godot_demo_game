extends State

@onready var slime: Slime = $"../.."
@onready var hop_state: State = $"../Hop"

var MAX_STATE_TIME: float = 2
var MIN_STATE_TIME: float = 1
var state_time: float
var timeout: bool

func enter() -> void:
	slime.velocity = Vector2.ZERO
	slime.update_animation("idle")
	timeout = false
	state_time = randf_range(MIN_STATE_TIME, MAX_STATE_TIME)
	await get_tree().create_timer(state_time).timeout
	timeout = true

func exit() -> void:
	pass

func process(delta: float) -> State:
	if timeout == true:
		return hop_state
	return null

func physics_process(delta: float) -> State:
	return null

func handle_input(event: InputEvent) -> State:
	return null
