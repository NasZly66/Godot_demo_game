extends Control

@onready var health_bar: ProgressBar = $HealthBar

func _process(delta: float) -> void:
	var red: int = 255 * (1 - PlayerStatus.player_health / 100.0)
	var green: int = 255 * (PlayerStatus.player_health / 100.0)
	health_bar.value = PlayerStatus.player_health
	health_bar.get_theme_stylebox("fill").bg_color = Color8(red, green, 0.0)
