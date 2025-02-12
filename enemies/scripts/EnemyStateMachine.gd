class_name EnemyStateMachine extends Node

var states : Array[EnemyState] # crée une liste d'états
var prev_state : EnemyState
var current_state : EnemyState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))
	pass

func init(_enemy : Enemy) -> void: # fonction pour initier les états du joueur
	states = []
	
	for c in get_children(): # pour chaques nodes enfants de PlayerStateMachine (c = une node)
		if c is EnemyState:
			states.append(c) # relie les nodes enfants à PlayerStateMachine
			
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()
	
	if states.size() > 0: # si la liste de states n'est pas vide
		change_state(states[0]) # applique le 1er état du joueur par défaut (normalement Idle)
		process_mode = Node.PROCESS_MODE_INHERIT # activer en fonction de si la node Player est activée

func change_state(new_state: EnemyState) -> void:
	if new_state == null || new_state == current_state: # si aucun nouvel état ou si nouvel état = l'actuel, rien faire
		return
		
	if current_state: 
		current_state.exit()
		
	prev_state = current_state # l'état actuel devient le précédent
	current_state = new_state # le nouveau état devient l'actuel
	current_state.enter() # démarre la fonction du nouvel état
