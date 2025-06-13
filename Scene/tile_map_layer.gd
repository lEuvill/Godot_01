extends TileMapLayer

@export var nav_custom_name := "Sidewalk01"

func _ready() -> void:
	# Trigger filtering before the navigation mesh is generated
	notify_runtime_tile_data_update()
	update_internals()

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	return get_cell_tile_data(coords) != null

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	var name = tile_data.get_custom_data("Name")
	if name != nav_custom_name:
		# Disable navigation only (leave visuals and other data)
		tile_data.set_navigation_polygon(0, null)
