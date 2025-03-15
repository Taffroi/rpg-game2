class_name Player extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal player_damaged(hurtbox : Hurtbox)

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
# 8 directions => const DIR_4 = [ Vector2.RIGHT, Vector2(1,1), Vector2.DOWN, Vector2(-1,1), Vector2.LEFT, Vector2(1,-1), Vector2.UP, Vector2(-1,-1) ]

var invulnerable : bool = false
var hp : int = 6
var max_hp : int = 6

var player_current_speed : float = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $PlayerSprite
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var movement_controller: MovementController = $MovementController
@onready var walk: State_Walk = $StateMachine/Walk
@onready var hitbox: Hitbox = $Hitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalPlayerManager.player = self
	state_machine.init(self) # appelle la fonction Initialize sur lui-même (c le Player)
	hitbox.damaged.connect(_take_damage)
	update_hp(99)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
func set_direction() -> bool:
	if movement_controller.move_dir == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((movement_controller.move_dir + cardinal_direction * 0.1).angle() / TAU * DIR_4.size())) # variable qui convertit n'importe quel angle possible aux 4 angles de la liste DIR_4, se base sur la direction pressée + * 0.1 de la nouvelle direction 
	var new_dir = DIR_4[direction_id] # choisit la direction trouvée au dessus dans la liste DIR_4
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite_2d.scale.x = -abs(sprite_2d.scale.x) if cardinal_direction == Vector2.LEFT else abs(sprite_2d.scale.x)
	return true
	
func get_player_current_speed() -> float:
	if abs(movement_controller.move_dir.x) > abs(movement_controller.move_dir.y):
		return abs(snapped(velocity.x,0.01))
	else:
		return abs(snapped(velocity.y,0.01))
	
	
	
func update_animation(state: String) -> void:
	animation_player.play(state+"_"+anim_direction())
	pass
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func _take_damage(hurtbox: Hurtbox) -> void:
	if invulnerable == true:
		return
	update_hp(-hurtbox.damage)
	if hp > 0:
		player_damaged.emit(hurtbox)
	else:
		player_damaged.emit(hurtbox)
		update_hp(99)
		#pour le laisser en vie en attendant qu'on test
	pass
	
func update_hp(delta:int) -> void:
	hp = clampi(hp + delta, 0, max_hp) # calcule les HP en limitant le max
	PlayerHud.update_hp(hp, max_hp)
	pass
	
func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hitbox.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hitbox.monitoring = true
	pass
