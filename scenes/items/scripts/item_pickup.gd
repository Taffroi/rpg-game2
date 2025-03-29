@tool

class_name ItemPickup extends CharacterBody2D

@export var item_data : ItemData : set = _set_item_data

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint(): # Vérifie si on est dans l'éditeur
		return
	area_2d.body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide( velocity * delta )
	if collision_info:
		velocity = velocity.bounce( collision_info.get_normal() ) # prends la direction du mur de la collision (get normal) et donne une vélocité opposée (.bounce)
	velocity -= velocity * delta * 4.5
	
func _on_body_entered(b) -> void:
	if b is Player: # si l'entité qui rentre dans la zone est un joueur
		if item_data: # vérifie qu'il y a bien un item rattaché au drop
			if GlobalPlayerManager.INVENTORY_DATA.add_item(item_data) == true:
				item_picked_up()
	pass
	
func item_picked_up() -> void:
	area_2d.body_entered.disconnect(_on_body_entered) # Enlève la détection pour ne pas le récup une 2ème fois
	audio_stream_player_2d.play()
	visible = false
	await audio_stream_player_2d.finished
	queue_free() # Attend que l'audio se finit pour supprimer le drop
	pass

func _set_item_data(item : ItemData) -> void:
	item_data = item
	_update_texture()
	pass
	
func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
