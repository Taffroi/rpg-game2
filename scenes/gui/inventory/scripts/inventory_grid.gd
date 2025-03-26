class_name InventoryGrid extends Control

const INVENTORY_SLOT = preload("res://scenes/gui/inventory/inventory_slot.tscn")
var focus_index : int = 0

@export var inventory_data : InventoryData

func _ready() -> void:
	InventoryMenu.inventory_gui_shown.connect( update_inventory )
	InventoryMenu.inventory_gui_hidden.connect( clear_inventory )
	clear_inventory()
	if inventory_data == null:
		inventory_data = InventoryData.new()
	inventory_data.changed.connect( on_inventory_changed ) # Dès que inventory_data émet "changed", on_inventory_changed
	pass
	
func clear_inventory() -> void: # Vide une grille
	for c in get_children():
		c.queue_free()
		
func update_inventory(i : int = 0) -> void: # Update tout l'inventaire
	for s in inventory_data.slots:
		var new_slot = INVENTORY_SLOT.instantiate() # Crée une variable de la scène de slot d'inventaire
		add_child( new_slot ) # Rajoute chaque slot d'inventaire existant à la grille
		new_slot.slot_data = s # Met à jour les slots en reprenant leur slot_data & call "set_slot_data" pcq : set
		# new_slot.focus_entered.connect( item_focused )
		
	# await get_tree().process_frame
	get_child( 0 ).grab_focus()
	
func item_focused() -> void:
	for i in get_child_count():
		if get_child( i ).has_focus():
			focus_index = i
			return
	pass

func on_inventory_changed() -> void: # Supprime le contenu d'une grille, et update
	var i = focus_index
	clear_inventory()
	update_inventory()
	print("inventory_grid supprime grille")
	
