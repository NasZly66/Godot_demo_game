extends State

@onready var slime: Slime = $"../.."
@onready var idle_state: Node = $"../Idle"

var KNOCK_BACK_SPEED: int = 60
var DECELERATION: int = 100
var direction: Vector2

func enter() -> void:
	direction = Vector2(slime.global_position - PlayerStatus.player_global_position).normalized()
	slime.velocity = direction * KNOCK_BACK_SPEED
	slime.sprite_2d.material.set("shader_parameter/Hit", true)
	await get_tree().create_timer(0.05).timeout
	slime.sprite_2d.material.set("shader_parameter/Hit", false)

func exit() -> void:
	pass

func process(delta: float) -> State:
	return null

func physics_process(delta: float) -> State:
	slime.velocity -= direction * DECELERATION * delta
	if Vector2(slime.velocity - Vector2.ZERO).length() < 0.05:
		return idle_state
	return null

func handle_input(event: InputEvent) -> State:
	return null
