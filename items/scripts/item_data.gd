class_name ItemData extends Resource

@export var name : String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D
@export var stack : int = 999

@export_category("Item Use Effects")
@export var effects : Array[ ItemEffect ]

func use() -> bool:
	if effects.size() == 0: # Si aucun effet, retourne "faux" (inutilisable)
		return false
		
	for e in effects: # Si pour chaque effet, l'utilise
		e.use()
	return true
