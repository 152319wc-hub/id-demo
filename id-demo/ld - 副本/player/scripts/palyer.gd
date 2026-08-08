extends CharacterBody2D
class_name Player

@export var move_speed : float = 500



#region /// state references
var states: Array [ PlayerState ] 

var current_state : PlayerState:
	get : return states.front()

var previous_state : PlayerState:
	get : return states[1]
#endregion
#region /// standard variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 1280
var gravity_mulitplier : float = 1
#endregion



func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta * gravity_mulitplier
	move_and_slide()
	change_state(current_state.physics_process(delta))
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_states()
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_direction()
	change_state(current_state.process(delta))
	pass

func initialize_states() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState :
			states.append( c )
			c.player = self
		pass
	
	if states.size() == 0:
		return
	
	for state in states:
		state.init()
		
	change_state(current_state)
	current_state.enter()
	$Label.text = current_state.name
	pass
	
	
	
	
func change_state(new_state : PlayerState) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
		
		
	
	if current_state:
		current_state.exit()
		
		
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	$Label.text = current_state.name
	pass
	
	
	
func update_direction() -> void :
	#var prev_direction : Vector2 = direction
	
	var x_axis = Input.get_axis("left","rignt")
	var y_axis = Input.get_axis("down","up")
	direction =Vector2(x_axis,y_axis)
	
	pass
