extends Node2D

var current_scene: Node = null


func set_scene(scene_path: String):
	if current_scene and current_scene.is_inside_tree():
		current_scene.queue_free()

	var new_scene = load(scene_path).instantiate()
	add_child(new_scene)
	current_scene = new_scene
	var spawn = new_scene.get_node("SpawnPoint")
	if spawn:
		get_parent().get_child(1).global_position = spawn.global_position
