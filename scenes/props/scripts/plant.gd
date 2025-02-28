class_name Plant extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hitbox.damaged.connect(take_damage)
	pass # Replace with function body.
	
func take_damage(hurtbox : Hurtbox) -> void:
	queue_free()
	pass
