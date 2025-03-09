class_name Slime extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hurt_state: State = $FiniteStateMachine/Hurt
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
var direction: Vector2 = Vector2.ZERO
var facing_direction: Vector2 = Vector2.DOWN
var health: int = 30
@onready var ninja: Ninja = $"../Ninja"

func _physics_process(delta: float) -> void:
	move_and_slide()

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
	health -= damage
	if health <= 0:
		ninja.slime_kill_count += 1
		print(ninja.slime_kill_count)
		$Sprite2D/HitBox/HitBoxCollision.disabled = true
		$Sprite2D/HitSource/HitSourceCollision.disabled = true
		animation_player.play("smoke")
		await animation_player.animation_finished
		queue_free()
		return
	fsm.transition_state(hurt_state)
