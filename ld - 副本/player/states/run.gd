extends PlayerState
class_name PlayerStateRun


func init() -> void:
	#print ("init,",name)
	pass


func enter() -> void:
	#print ("enter,",name)
	pass
	
func exit() -> void :
	#print ("exit,",name)
	pass
	
func handle_input(_event : InputEvent) -> PlayerState :
	if _event.is_action_pressed("jump") :
		return jump
	if _event.is_action_pressed("attack") :
		return attack
	if _event.is_action_pressed("die"):
		return die
	return next_state 
	
func process(_delta: float ) -> PlayerState:
	if player.direction.x == 0 :
		return idle
	
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed 
	if player.is_on_floor() == false :
		return fall
	return next_state
