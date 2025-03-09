extends State

@onready var ninja: Ninja = $"../.."
@onready var idle_state: State = $"../Idle"
@onready var attack_state: State = $"../Attack"
var SPEED: float = 80

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(delta: float) -> State:
	return null

func physics_process(delta: float) -> State:
	ninja.update_animation("walk")
	ninja.velocity = ninja.direction * SPEED
	if ninja.velocity == Vector2.ZERO:
		return idle_state
	return null

func handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null
