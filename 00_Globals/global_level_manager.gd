extends Node
	
var current_tilemaps_bounds : Array[Vector2]
signal tilemap_bounds_changed(bounds: Array[Vector2])

func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	current_tilemaps_bounds = bounds
	tilemap_bounds_changed.emit(bounds)
