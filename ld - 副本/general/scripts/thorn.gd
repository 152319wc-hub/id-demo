extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# 通过节点路径直接获取 Die 状态，而非 body.die
		var die_state := body.get_node("States/Die") as PlayerState
		if die_state:
			body.change_state(die_state)
