class_name State_Idle extends State

@onready var walk: State = $"../Walk" # alias "walk" pour désigner State_Walk
@onready var attack: State = $"../Attack"

# Qu'est-ce qui se passe quand on initie cet état?
func init() -> void:
	pass

# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func enter() -> void:
	player.update_animation("idle")
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func exit() -> void:
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta : float) -> State:
	if MovementController.move_dir != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> State:
	return null
	
# Qu'est-ce qui se passe avec les touches dans cet état?
func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
