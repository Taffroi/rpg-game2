class_name SlotData extends Resource

@export var item_data : ItemData
@export var quantity : int = 1 : set = set_quantity

func set_quantity(value : int) -> void:
	quantity = clampi(value,0,item_data.stack)
	if quantity < 1:
		emit_changed() # Fais en sorte que GODOT ne gère plus automatiquement la quantité
		print("slot_data emit")
