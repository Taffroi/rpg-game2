class_name EnemyState extends Node

var enemy : Enemy
var state_machine : EnemyStateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Qu'est-ce qui se passe quand on initie l'état de l'ennemi?
func init() -> void:
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func enter() -> void:
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func exit() -> void:
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta : float) -> EnemyState:
	return null

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> EnemyState:
	return null
