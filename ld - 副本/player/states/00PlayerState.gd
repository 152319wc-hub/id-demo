extends Node
class_name PlayerState

var player : Player
var next_state : PlayerState

#region /// state references
# reference to all other states
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall
@onready var attack: PlayerStateAttack = %Attack
@onready var die: PlayerStateDie = %Die



#endregion

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
	return next_state 
	
func process(_delta: float ) -> PlayerState:
	#print(_delta)
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	return next_state
