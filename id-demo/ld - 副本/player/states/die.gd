extends PlayerState
class_name PlayerStateDie

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.gravity = 0

	
	# player.collision_layer = 0
	# player.collision_mask = 0

	
	print("玩家死亡")



func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor() == false :
		player.gravity = 2000
	return self



func handle_input(_event: InputEvent) -> PlayerState:
	return self
