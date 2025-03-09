extends State

@onready var ninja: Ninja = $"../.."
@onready var idle_state: State = $"../Idle"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var sword_swoosh_sfx: AudioStream = preload("res://asset/sfx/SwordSwoosh.wav")
var attacking: bool

func enter() -> void:
	ninja.update_animation("attack")
	attacking = true
	audio_stream_player_2d.stream = sword_swoosh_sfx
	audio_stream_player_2d.volume_db = 0
	audio_stream_player_2d.play()
	await ninja.animation_player.animation_finished
	attacking = false

func exit() -> void:
	pass

func process(delta: float) -> State:
	if attacking == false:
		return idle_state
	return null

func physics_process(delta: float) -> State:
	ninja.velocity = Vector2.ZERO
	return null

func handle_input(event: InputEvent) -> State:
	return null
