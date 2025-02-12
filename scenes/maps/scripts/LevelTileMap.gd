class_name LevelTileMap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_tilemap_bounds() -> Array[Vector2]:
	var rect = get_used_rect()  # Get the tilemap rect
	var bounds : Array[Vector2] = []

	# Convert tile coordinates to world coordinates using `to_global()`

	bounds.append(to_global(rect.position * tile_set.tile_size))
	bounds.append(to_global(rect.end * tile_set.tile_size))

	return bounds
