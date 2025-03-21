class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction : Vector2)
signal enemy_damaged(hurtbox : Hurtbox)
signal enemy_destroyed(hurtbox : Hurtbox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 3

var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN
var player : Player
var invulnerable : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Hitbox = $Hitbox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.init(self)
	player = GlobalPlayerManager.player
	hitbox.damaged.connect(_take_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func set_direction(_new_direction) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round(
		(direction + cardinal_direction * 0.1).angle()
		/ TAU * DIR_4.size()
		)) # variable qui convertit n'importe quel angle possible aux 4 angles de la liste DIR_4, se base sur la direction pressée + * 0.1 de la nouvelle direction 
	var new_dir = DIR_4[direction_id] # choisit la direction trouvée au dessus dans la liste DIR_4
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite_2d.scale.x = -abs(sprite_2d.scale.x) if cardinal_direction == Vector2.LEFT else abs(sprite_2d.scale.x)
	return true
	
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
		
func _take_damage(hurtbox : Hurtbox) -> void:
	if invulnerable == true:
		return
	hp -= hurtbox.damage
	if hp > 0:
		enemy_damaged.emit(hurtbox) # signal pour dire que l'ennemi a pris des dégâts
	else:
		enemy_destroyed.emit(hurtbox) # signal pour dire que l'ennemi est mort
