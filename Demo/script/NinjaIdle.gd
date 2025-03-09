extends State

@onready var ninja: Ninja = $"../.."
@onready var walk_state: State = $"../Walk"
@onready var attack_state: State = $"../Attack"

func enter() -> void:
	ninja.update_animation("idle")

func exit() -> void:
	pass

func process(delta: float) -> State:
	return null

func physics_process(delta: float) -> State:
	ninja.velocity = Vector2.ZERO
	if ninja.direction != Vector2.ZERO:
		return walk_state
	return null

func handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null
