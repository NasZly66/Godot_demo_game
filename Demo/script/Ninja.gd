class_name Ninja extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var ninja_get_hit_sfx: AudioStream = preload("res://asset/sfx/NinjaGetHit.wav")

var direction: Vector2 = Vector2.ZERO
var facing_direction: Vector2 = Vector2.DOWN
var slime_kill_count = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	PlayerStatus.player_global_position = global_position
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))

func update_facing_direction() -> void:
	if direction == Vector2.ZERO:
		return
	if direction.x != 0:
		facing_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.y != 0:
		facing_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN

func play_animation_with_direction(anim: String) -> void:
	if facing_direction.x != 0:
		sprite_2d.scale.x = -abs(sprite_2d.scale.x) if facing_direction == Vector2.RIGHT else abs(sprite_2d.scale.x)
		animation_player.play(anim + "_side")
	else:
		sprite_2d.scale.x = abs(sprite_2d.scale.x)
		if facing_direction == Vector2.DOWN:
			animation_player.play(anim + "_down")
		else:
			animation_player.play(anim + "_up")

func update_animation(anim: String) -> void:
	if animation_player == null:
		return
	update_facing_direction()
	play_animation_with_direction(anim)
	
func decrease_health(damage: int) -> void:
	PlayerStatus.player_health -= damage
	if PlayerStatus.player_health <= 0:
		get_tree().quit()
	audio_player.stream = ninja_get_hit_sfx
	audio_player.volume_db = -3
	audio_player.play()
	sprite_2d.material.set("shader_parameter/Hit", true)
	await get_tree().create_timer(0.05).timeout
	sprite_2d.material.set("shader_parameter/Hit", false)
