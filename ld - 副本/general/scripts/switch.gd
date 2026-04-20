extends Area2D
class_name Switch


signal activated

var _is_activated: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_activate()
	
	
	
func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		_activate()


func _activate() -> void:
	_is_activated = true
	activated.emit()          
	$Sprite2D.modulate = Color.GREEN  
