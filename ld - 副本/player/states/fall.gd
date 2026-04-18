extends PlayerState
class_name PlayerStateFall

@export var fall_gravity_mulitplier : float = 1.165
@export var coyote_time : float = 0.125
@export var jump_buffer_time : float = 0.2

var coyote_timer : float = 0
var buffer_timer : float = 0


func init() -> void:
	pass


func enter() -> void:
	player.gravity_mulitplier = fall_gravity_mulitplier
	# 从跳跃状态直接进入 fall（上升段松手），或从空中攻击结束进入 fall
	# 这两种情况都不给 coyote time（玩家是主动跳起来的，不是走边缘掉下去的）
	if player.previous_state == jump or player.previous_state == attack:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	
func exit() -> void :
	player.gravity_mulitplier = 1
	pass
	
func handle_input(_event : InputEvent) -> PlayerState :
	if _event.is_action_pressed("jump") :
		if coyote_timer > 0 : 
			return jump
		else :
			buffer_timer = jump_buffer_time
	if _event.is_action_pressed("attack") :
		return attack
	return next_state 
	
func process(_delta: float ) -> PlayerState :
	coyote_timer -= _delta
	buffer_timer -= _delta
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		if buffer_timer >0 :
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed 
	return next_state
