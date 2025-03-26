class_name InventorySlotGUI extends Button

var slot_data : SlotData : set = set_slot_data

@onready var item_texture: TextureRect = $ItemTexture
@onready var quantity_text: Label = $Quantity

func _ready() -> void:
	item_texture.texture = null
	quantity_text.text = ""
	focus_entered.connect( item_focused )
	focus_exited.connect( item_unfocused )
	
func set_slot_data(value : SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	item_texture.texture = slot_data.item_data.texture
	quantity_text.text = str(slot_data.quantity)
	
func item_focused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			InventoryMenu.update_item_description(slot_data.item_data.description)
	pass
	
func item_unfocused() -> void: # Mieux si on va sur d'autres types de bouton, retire la description
	InventoryMenu.update_item_description("")
	pass
