class_name InventoryGrid extends Control

const INVENTORY_SLOT = preload("res://scenes/gui/inventory/inventory_slot.tscn")

@export var data : InventoryData

func _ready() -> void:
	InventoryMenu.inventory_gui_shown.connect( update_inventory )
	InventoryMenu.inventory_gui_hidden.connect( clear_inventory )
	clear_inventory()
	pass
	
func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()
		
func update_inventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate() # Variable de la scène du slots d'inventaire
		add_child(new_slot) # Ajoute X slots
		new_slot.slot_data = s # Met à jour les slots en reprenant leur slot_data & call "set_slot_data" pcq : set
		
	get_child(0).grab_focus() # Met le focus sur le 1er slot
