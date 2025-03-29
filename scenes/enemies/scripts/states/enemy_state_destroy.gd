class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://scenes/items/item_pickup.tscn")

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 800
@export var decelerate : float = 10
@export var player_knockback_influence : float = 3

@export_category("AI")
@export var next_state : EnemyState

@export_category("Item Drops")
@export var drops : Array[ DropData ]

var _damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Qu'est-ce qui se passe quand on initie l'état de l'ennemi?
func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func enter() -> void:
	enemy.invulnerable = true

	_direction = enemy.global_position.direction_to(_damage_position) # trouve la direction du slime par rapport au joueur
	
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed + (enemy.player.velocity*player_knockback_influence)
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished) # dès que l'anim est finie, fais la fonction _on_animation_finished
	
	disable_hurtbox()
	drop_items()
	pass
	
# Qu'est-ce qui se passe quand l'ennemi entre dans un nouvel état?
func exit() -> void:
	pass

# Qu'est-ce qui se passe lors de la mise à jour du processus dans cet état?
func process(_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate * _delta
	return null

# Qu'est-ce qui se passe lors de la mise à jour de la physique dans cet état?
func physics(_delta : float) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurtbox : Hurtbox) -> void :
	_damage_position = hurtbox.global_position # trouve la position de la hurtbox du truc qui l'attaque pour ensuite déduire la direction
	state_machine.change_state(self) # dis au state machine de prioriser l'état mort
	
func _on_animation_finished(_a : String) -> void :
	enemy.queue_free()
	
func disable_hurtbox() -> void:
	var hurtbox : Hurtbox = enemy.get_node_or_null("Hurtbox")
	if hurtbox :
		hurtbox.monitoring = false

func drop_items() -> void:
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[ i ] == null or drops[ i ].item == null:
			continue
		var drop_count : int = drops[ i ].get_drop_count()
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[ i ].item
			enemy.get_parent().call_deferred("add_child", drop) # add_child(drop) en mode safe = call_deferred, attend la fin du process de la frame
			drop.global_position = enemy.global_position + Vector2(randf()*16,randf()*16)
	pass
