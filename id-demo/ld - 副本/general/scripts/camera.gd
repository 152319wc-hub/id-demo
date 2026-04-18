extends Camera2D




func _ready() -> void:
	# 立即对齐到父节点位置，忽略平滑
	global_position = get_parent().global_position
