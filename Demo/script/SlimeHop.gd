extends State

@onready var slime: Slime = $"../.."
@onready var idle_state: State = $"../Idle"

var MAX_STATE_CYCLE: int = 3
var MIN_STATE_CYCLE: int = 1
var HOP_SPEED: float = 15
var DIR: Array[Vector2] = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
var state_cycle: int

func enter() -> void:
	state_cycle = randi_range(MIN_STATE_CYCLE, MAX_STATE_CYCLE)
	slime.direction = DIR[randi_range(0, 3)]
	slime.velocity = slime.direction * HOP_SPEED
	while state_cycle != 0:
		slime.update_animation("hop")
		await slime.animation_player.animation_finished
		state_cycle = state_cycle - 1

func exit() -> void:
	pass

func process(delta: float) -> State:
	if state_cycle == 0:
		return idle_state
	return null

func physics_process(delta: float) -> State:
	return null

func handle_input(event: InputEvent) -> State:
	return null
