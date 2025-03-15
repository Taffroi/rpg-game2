extends CanvasLayer

var hearts : Array[ HeartGUI ] = []

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children(): #pour les noeuds enfants de HFlowContainer
		if child is HeartGUI:
			hearts.append(child) # ajoute l'enfant à la liste Array "hearts"
			child.visible = false # rend chaque enfant invisible
	pass
	
func update_hp(_hp : int, _max_hp: int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp: # en comptant de 0 à _max_hp (i = integer)
		update_heart(i,_hp) # update le coeur au numéro de l'enfant, et donne la valeur totale de hp
		pass
	pass

func update_heart(_index : int, _hp : int) -> void:
	var _value : int = clampi( _hp - (_index * 2) ,0 ,2 ) # calcule la valeur : puisque un coeur a 2 hp, hp total - (numéro coeur * 2) = value paire ou impaire, puis le remet entre 0 et 2 
	hearts[_index].value = _value # update la valeur du coeur
	pass
	
func update_max_hp(_max_hp: int) -> void:
	var _heart_count : int = roundi( _max_hp * 0.5 ) # divise le total de HP par 2 pour avoir le nombre de coeur
	for i in hearts.size(): # pour chaque élément jusqu'au dernier élément de la liste "hearts"
		if i < _heart_count: # si le numéro du coeur est en dessous du nombre de coeurs
			hearts[i].visible = true # le rendre visible
		else:
			hearts[i].visible = false # le rendre visible
	pass
