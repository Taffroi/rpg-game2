class_name InventoryData extends Resource

@export var slots : Array[ SlotData ]

func _init() -> void:
	connect_slots()
	pass

func add_item(item : ItemData, quantity : int = 1) -> bool: # bool pour dire si l'inventaire est plein = false, ajoute pas l'item
	for s in slots:
		if s: # si le slot n'est pas vide
			if s.item_data == item: # si l'item existe déjà dans le slot
				if s.quantity + quantity <= s.item_data.stack :
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
	
	## Transformer l'inventaire en array
func get_save_data() -> Array:
	var item_save : Array = []
	for i in slots.size():
		item_save.append(item_to_save( slots[ i ] )) # Rajoute la valeur dans item_save
	return item_save

## Convertit chaque item de l'inventaire en dictionnaire
func item_to_save( slot : SlotData ) -> Dictionary:
	var result = { item = "", quantity = 0 }
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path # Récupère le chemin du fichier resource, pour qu'il recharge l'item une fois la save chargée
	return result
	
func parse_save_data( save_data : Array) -> void:
	var array_size = slots.size() # Garde le nombre de slots de l'inventaire
	slots.clear()
	slots.resize( array_size ) # Remet à 10
	for i in save_data.size():
		slots[ i ] = item_from_save( save_data[ i ] )
	connect_slots()
	
func item_from_save( save_object : Dictionary ) -> SlotData:
	if save_object.item == "":
		return null
	var new_slot : SlotData = SlotData.new() # Crée un nouveau SlotData en variable
	new_slot.item_data = load( save_object.item )
	new_slot.quantity = int ( save_object.quantity )
	return new_slot
	
