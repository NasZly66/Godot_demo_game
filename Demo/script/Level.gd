
extends Node

@onready var ninja: Ninja = $"../Ninja"

@export var number_kill = 0
@export_file var file_path

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ninja == null:
		print("no ninja")
		return 
	if ninja.slime_kill_count == number_kill:
		if file_path == null:
			return
		get_tree().change_scene_to_file(file_path)
