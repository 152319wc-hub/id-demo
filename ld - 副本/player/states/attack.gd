extends PlayerState
class_name PlayerStateAttack

@export var bullet_scene: PackedScene
@export var bullet_speed: float = 550.0

func enter() -> void:
	# 进入攻击状态时立刻发射子弹
	shoot_bullet()

func physics_process(_delta: float) -> PlayerState:
	# 攻击动作为瞬时（发射子弹后立刻根据当前物理状态切换回对应状态）
	# 注意：空中时只能返回 fall，绝对不能返回 jump
	# 返回 jump 会触发 jump.enter() 重新赋予跳跃速度，导致二次起跳 BUG
	if not player.is_on_floor():
		# 无论上升还是下降，统一进入 fall（保持当前 velocity.y，不重新起跳）
		return fall
	elif abs(player.velocity.x) > 10.0:
		return run
	else:
		return idle

## 发射子弹：方向为玩家位置 → 鼠标位置的单位向量
func shoot_bullet() -> void:
	if not bullet_scene:
		push_warning("PlayerStateAttack: bullet_scene 未赋值，请在编辑器中拖拽子弹场景！")
		return

	var mouse_pos: Vector2 = player.get_global_mouse_position()
	var shoot_dir: Vector2 = (mouse_pos - player.global_position).normalized()

	# 防止玩家和鼠标完全重合时方向为零向量
	if shoot_dir == Vector2.ZERO:
		shoot_dir = Vector2.RIGHT

	var bullet: Bullet = bullet_scene.instantiate() as Bullet
	if bullet == null:
		push_error("PlayerStateAttack: bullet_scene 根节点不是 Bullet 类型！")
		return

	# 挂载到玩家的父节点（World/关卡层），避免跟随玩家移动
	bullet.global_position = player.global_position
	player.get_parent().add_child(bullet)

	bullet.set_direction(shoot_dir, bullet_speed)
