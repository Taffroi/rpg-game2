class_name EnemyStateIdle extends EnemyState

@export var anim_name : String = "idle"

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var after_idle_state : EnemyState

var _timer : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Qu'est-ce qui se passe quand on initie l'état de l'ennemi?
func init() -> void:
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	enemy.update_animation(anim_name)
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func exit() -> void:
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> EnemyState:
	return null
