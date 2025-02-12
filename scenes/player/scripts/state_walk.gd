class_name State_Walk extends State

@onready var idle: State = $"../Idle" # alias "idle" pour désigner State_Walk
@onready var attack: State = $"../Attack"
@onready var movement_controller: MovementController = $"../../MovementController"

@export var move_speed : float = 500.0
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func enter() -> void:
	player.update_animation("walk")
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func exit() -> void:
	player.animation_player.speed_scale = 1
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta : float) -> State:
	if MovementController.move_dir == Vector2.ZERO:
		return idle
	player.animation_player.speed_scale = animation_speed()
	player.velocity = movement_controller.move_dir * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	return null
	

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> State:
	return null
	
# Qu'est-ce qui se passe avec les touches dans cet état?
func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
	
func animation_speed() -> float:
	var animation_speed = abs(movement_controller.move_dir)
	if abs(movement_controller.move_dir.x) > abs(movement_controller.move_dir.y):
		return animation_speed.x
	else:
		return animation_speed.y
