class_name HeartGUI extends Control

@onready var sprite = $Sprite2D

var value : int = 2 :
	set(_value): # comme une fonction, s'update à chaque changement de valeur
		value = _value
		update_sprite() # hp du coeur

func _ready() -> void:
	pass
	
func update_sprite() -> void:
	sprite.frame = value
