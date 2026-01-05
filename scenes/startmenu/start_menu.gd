extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	#await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://scenes/world/TestLevel.tscn")
	#LevelTransition.fade_from_black()

func _on_quit_game_pressed() -> void:
	get_tree().quit()
