class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound = AudioStream
@export_range(1,20,0.5) var deceleration : float = 5.0
@export_range(1,8,0.5) var dash_speed : float = 3.0 # variable slider min 1 max 20 incrémentation 0.5

@onready var walk: State = $"../Walk" # alias "walk" pour désigner State_Walk
@onready var idle: State = $"../Idle"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../PlayerSprite/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Node/AudioStreamPlayer2D"
@onready var hurtbox: Hurtbox = %AttackHurtbox

# Qu'est-ce qui se passe quand on initie cet état?
func init() -> void:
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func enter() -> void:
	player.velocity *= dash_speed
	player.update_animation("attack")
	attack_anim.play("attack_"+player.anim_direction())
	animation_player.animation_finished.connect(end_attack)
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()
	
	attacking = true
	
	await get_tree().create_timer(0.075).timeout #crée un timer temporaire de 0.075 et attends qu'il se finisse
	hurtbox.monitoring = true	
	
	pass
	
# Qu'est-ce qui se passe quand le joueur entre dans un nouvel état?
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	hurtbox.monitoring = false
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta : float) -> State:
	player.velocity -= player.velocity * deceleration * _delta
	
	if attacking == false:
		if MovementController.move_dir == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> State:
	return null
	
# Qu'est-ce qui se passe avec les touches dans cet état?
func handle_input(_event : InputEvent) -> State:
	return null

func end_attack(_newAnimName : String) -> void:
	attacking = false
	pass
