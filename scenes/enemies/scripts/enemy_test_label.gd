extends Label
@onready var enemy: Enemy = $".."
@onready var movement_controller: MovementController = $"../MovementController"
@onready var enemy_state_machine: EnemyStateMachine = $"../EnemyStateMachine"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "current_state ="+str(enemy_state_machine.current_state)
	
	pass
