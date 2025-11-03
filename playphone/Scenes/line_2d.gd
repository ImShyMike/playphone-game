extends Line2D

@export var maxPoints: int = 40
@export var enabled: bool = true
var currentMaxPoints: float = 0

func _ready() -> void:
	top_level = true

func _process(_delta: float) -> void:
	var target = maxPoints if enabled else 0
	currentMaxPoints = move_toward(currentMaxPoints, target, 1)

	add_point(get_parent().global_position)

	while get_point_count() > currentMaxPoints:
		remove_point(0)
