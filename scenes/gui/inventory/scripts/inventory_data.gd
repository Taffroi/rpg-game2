class_name InventoryData extends Resource

@export var slots : Array[ SlotData ]

func _init() -> void:
	connect_slots()
	pass

func add_item(item : ItemData, quantity : int = 1) -> bool: # bool pour dire si l'inventaire est plein = false, ajoute pas l'item
	for s in slots:
		if s: # si le slot n'est pas vide
			if s.item_data == item: # si l'item existe déjà dans le slot
				s.quantity += quantity
				return true
				
	for i in slots.size(): # pour le nombre de slots
		if slots[i] == null: # si il tombe sur le 1er slot qui est vide
			var new = SlotData.new() # crée des données dans le slot
			new.item_data = item
			new.quantity = quantity
			slots[ i ] = new
			new.changed.connect( slot_changed )
			return true
			
	print("inventory full")
	return false
	
func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect( slot_changed ) # Permet de détecter quand un signal "changed" (du slot_data) est émis (et donc fait slot_changed quand ça passe à < 1)
			
func slot_changed() -> void:
	print("inventory_data -> slot_changed")
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect( slot_changed ) # Désactive le signal changed (qui sert pour < 1)
				var index = slots.find( s ) # Trouve le numéro du S avec quantity < 1
				slots[ index ] = null # Supprime la data du slot
				emit_changed()
				print("inventory_data")
	pass
