extends Label
@onready var player: Player = $".."
@onready var movement_controller: MovementController = $"../MovementController"
@onready var walk: State_Walk = $"../StateMachine/Walk"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "move_dir ="+str(movement_controller.move_dir)+"\nmove_input ="+str(movement_controller.move_input)+"\nspeed ="+str(player.get_player_current_speed())+"\nanimation_speed ="+str(player.animation_player.speed_scale)+"\nmax_joystick (marche pas)="+str(abs(Input.get_action_strength("joystick_pressure")))
	
	pass
