extends StaticBody2D
class_name Door

@export var switch_node: Switch

func _ready() -> void:
	if switch_node:
		switch_node.activated.connect(_on_switch_activated)

func _on_switch_activated() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
