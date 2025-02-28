class_name State extends Node

# Crée une variable player globale entre tous les nodes, de type Player (la node)
static var player: Player
static var player_state_machine: PlayerStateMachine

# Qu'est-ce qui se passe quand on initie cet état?
func init() -> void:
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func enter() -> void:
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func exit() -> void:
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta : float) -> State:
	return null

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> State:
	return null
	
# Qu'est-ce qui se passe avec les touches dans cet état?
func handle_input(_event : InputEvent) -> State:
	return null
