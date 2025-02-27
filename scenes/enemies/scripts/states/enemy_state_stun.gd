class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 800
@export var decelerate : float = 10
@export var player_knockback_influence : float = 3

@export_category("AI")
@export var next_state : EnemyState

var _damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Qu'est-ce qui se passe quand on initie l'état de l'ennemi?
func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func enter() -> void:
	enemy.invulnerable = true
	_animation_finished = false
	
	_direction = enemy.global_position.direction_to(_damage_position) # trouve la direction du slime par rapport au joueur
	
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed + (enemy.player.velocity*player_knockback_influence)
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished) # dès que l'anim est finie, fais la fonction _on_animation_finished
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta: float) -> EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate * _delta
	return null

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> EnemyState:
	return null
	
func _on_enemy_damaged(hurtbox : Hurtbox) -> void :
	_damage_position = hurtbox.global_position # trouve la position de la hurtbox du truc qui l'attaque pour ensuite déduire la direction
	state_machine.change_state(self)
	
func _on_animation_finished(_a : String) -> void :
	_animation_finished = true
