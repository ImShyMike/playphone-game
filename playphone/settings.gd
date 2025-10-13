extends Control


func _on_h_slider_value_changed(value: float) -> void:
	# Convert from linear slider range (0-100) to decibel range (-40 to 0)
	var db = lerp(-40.0, 0.0, value / 100.0)
	AudioServer.set_bus_volume_db(0, db)
	
func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
