class_name InventorySlotGUI extends Button

var slot_data : SlotData : set = set_slot_data

@onready var item_texture: TextureRect = $ItemTexture
@onready var quantity_label: Label = $Quantity

func _ready() -> void:
	item_texture.texture = null
	quantity_label.text = ""
	focus_entered.connect( item_focused )
	focus_exited.connect( item_unfocused )
	pressed.connect(item_pressed)
	
func set_slot_data(value : SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	item_texture.texture = slot_data.item_data.texture
	quantity_label.text = str(slot_data.quantity)
	
func item_focused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			InventoryMenu.update_item_description(slot_data.item_data.description)
	pass
	
func item_unfocused() -> void: # Mieux si on va sur d'autres types de bouton, retire la description
	InventoryMenu.update_item_description("")
	pass
	
func item_pressed() -> void:
	if slot_data:
		if slot_data.item_data:
			var was_used = slot_data.item_data.use()
			if was_used == false:
				return
			slot_data.quantity -= 1
			quantity_label.text = str(slot_data.quantity)
			print(slot_data.quantity)
