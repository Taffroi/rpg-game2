class_name State_Stun extends State

@export var anim_name : String = "stun"
@export var knockback_speed : float = 800
@export var decelerate : float = 10
@export var invulnerable_duration : float = 1

var hurtbox : Hurtbox
var direction : Vector2

var next_state : State = null

@onready var idle: State = $"../Idle" # alias "idle" pour désigner State_Walk
@onready var attack: State = $"../Attack"
@onready var movement_controller: MovementController = $"../../MovementController"
@onready var effect_animation_player: AnimationPlayer = $"../../EffectAnimationPlayer"

# Qu'est-ce qui se passe quand on initie cet état?
func init() -> void:
	player.player_damaged.connect(_player_damaged)
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func enter() -> void:
	direction = player.global_position.direction_to(hurtbox.global_position) # trouve la direction du joueur par rapport à l'attaque
	
	player.velocity = direction * -knockback_speed
	player.set_direction()
	
	player.update_animation("stun")
	player.animation_player.animation_finished.connect(_animation_finished)
	
	player.make_invulnerable(invulnerable_duration)
	effect_animation_player.play("damaged")
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta : float) -> State:
	player.velocity -= player.velocity * decelerate * _delta
	return next_state
	

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> State:
	return null
	
# Qu'est-ce qui se passe avec les touches dans cet état?
func handle_input(_event : InputEvent) -> State:
	return null
	
func _animation_finished(_a : String) -> void:
	next_state = idle
	pass
	
func _player_damaged(_hurt_box: Hurtbox) -> void:
	hurtbox = _hurt_box
	player_state_machine.change_state(self)
	pass
