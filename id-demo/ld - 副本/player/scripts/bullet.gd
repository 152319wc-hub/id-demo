extends Area2D
class_name Bullet

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# 碰撞信号绑定（碰墙就消失）
	body_entered.connect(_on_body_hit)

# 接收方向+速度
func set_direction(dir: Vector2, speed: float) -> void:
	velocity = dir.normalized() * speed
	rotation = dir.angle()

# 物理移动
func _physics_process(delta: float) -> void:
	global_position += velocity * delta

# 碰撞销毁
func _on_body_hit(_body: Node2D) -> void:
	queue_free()
