extends Control

const BTN_LEVEL = preload("res://scene/btn_level.tscn")
@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/GridContainer

@export_dir var dir_path

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path):
	var dir = DirAccess.open(path) #levels
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			create_level_btn('%s/%s' % [dir.get_current_dir(), file_name],file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
func create_level_btn(level_path:String,lvl_name:String):
	var btn = BTN_LEVEL.instantiate()
	btn.text = lvl_name.trim_suffix('.tscn').replace('_',' ')
	btn.level_path = level_path
	grid_container.add_child(btn)
