@tool # fait marcher le code dans l'éditeur
class_name LevelTransition extends Area2D

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_file("*.tscn") var level # paramètre de fichier
@export var target_transition_area : String = "LevelTransition"

@export_category("Collision Area Settings")

@export_range(1, 12, 1, "or_greater") var size : int = 2 :
	set ( _value ):
		size = _value
		_update_area()

@export var side: SIDE = SIDE.LEFT :
	set ( _value ):
		side = _value
		_update_area()

@export_tool_button("Snap to the grid!", "Callable") var snap_to_grid_action = _snap_to_grid
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

# func _set(property: StringName, value: Variant) -> bool:
#	if property == "position":
#		_snap_to_grid()
#		print("changed position ",value)
#	return false
	
#func _enter_tree() -> void:
#	set_notify_transform(true)

#func _notification(what: int) -> void:
#	if what == NOTIFICATION_TRANSFORM_CHANGED :
#		print("changed position", position)

func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
		
	monitoring = false # au cas où si le niveau a pas fini de charger
	_place_player()
	
	await LevelManager.level_loaded
	
	monitoring = true
	body_entered.connect(_player_entered)
	
	pass
	
func _player_entered(_p : Node2D) -> void:
	LevelManager.load_new_level(level, target_transition_area, get_offset())
	pass
	
func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
	GlobalPlayerManager.set_player_position(global_position + LevelManager.position_offset)
	
func get_offset() -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos = GlobalPlayerManager.player.global_position
	
	if side == SIDE.LEFT or side == SIDE.RIGHT:
		offset.y = player_pos.y - global_position.y
		offset.x = 16
		if side == SIDE.LEFT:
			offset.x *= -1
	else:
		offset.x = player_pos.x - global_position.x
		offset.y = 23
		if side == SIDE.TOP:
			offset.y *= -1
	
	return offset
	
func _update_area() -> void:
	var new_rect: Vector2 = Vector2(32,32)
	var new_position: Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= 16
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += 16
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= 16
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_position.x += 16
		
	if collision_shape == null: # si pas de collision trouvée, relie le noeud "CollisionShape2D" pour éviter les erreurs
		collision_shape = get_node("CollisionShape2D")
		
	collision_shape.shape.size = new_rect
	collision_shape.position = new_position
	
	pass
	
func _snap_to_grid() -> void:
	position.x = round(position.x / 16)*16
	position.y = round(position.y / 16)*16
pass
