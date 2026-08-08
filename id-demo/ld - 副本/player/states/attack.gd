extends PlayerState
class_name PlayerStateAttack

@export var bullet_scene: PackedScene
@export var bullet_speed: float = 550.0

func enter() -> void:
	shoot_bullet()

func physics_process(_delta: float) -> PlayerState:
	
	if not player.is_on_floor():
		return fall
	elif abs(player.velocity.x) > 10.0:
		return run
	else:
		return idle


func shoot_bullet() -> void:
	if not bullet_scene:
		push_warning("PlayerStateAttack: bullet_scene 未赋值，请在编辑器中拖拽子弹场景！")
		return

	var mouse_pos: Vector2 = player.get_global_mouse_position()
	var shoot_dir: Vector2 = (mouse_pos - player.global_position).normalized()

	
	if shoot_dir == Vector2.ZERO:
		shoot_dir = Vector2.RIGHT

	var bullet: Bullet = bullet_scene.instantiate() as Bullet
	if bullet == null:
		push_error("PlayerStateAttack: bullet_scene 根节点不是 Bullet 类型！")
		return

	
	bullet.global_position = player.global_position
	player.get_parent().add_child(bullet)

	bullet.set_direction(shoot_dir, bullet_speed)
