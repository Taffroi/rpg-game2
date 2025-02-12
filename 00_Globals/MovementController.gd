extends Node

@export var player : GlobalPlayerManager
@export var move_input_deadzone : float = 0.2

@export var walk_speed : float = 300.0
@export var move_min_threshold : float = 0.05
@export var move_max_threshold : float = 0.95
var move_input = Vector2.ZERO
var move_dir = Vector2.ZERO
var move_input_pressure : float = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_input = Input.get_vector("left","right","up","down",move_input_deadzone)
	
	move_input_pressure = clamp(sqrt((move_dir.x**2)+(move_dir.y**2)),0,1)
	
	if Vector2.ZERO.distance_to(move_input) > move_input_deadzone*sqrt(2.0):
	
		move_dir = Vector2(snapped(move_input.x,0.01),snapped(move_input.y,0.01))
		
		# FIX pour régler problème clavier qui est pas exactement à 1
		if abs(snapped(move_input.x,0.01)) >= move_max_threshold or abs(snapped(move_input.x,0.01)) <= move_min_threshold:
			move_dir.x = round(move_input.x)
		if abs(snapped(move_input.y,0.01)) >= move_max_threshold or abs(snapped(move_input.y,0.01)) <= move_min_threshold:
			move_dir.y = round(move_input.y)
			
	else:
		move_dir = Vector2.ZERO
	pass
	
#caca
