extends NavigationRegion2D

@onready var tilemap := $TileMapLayer

func _ready():
	filter_navigation_tiles("Sidewalk01")

func filter_navigation_tiles(target_name: String):
	var used_cells = tilemap.get_used_cells()

	for cell in used_cells:
		var tile_data = tilemap.get_cell_tile_data(cell)
		if tile_data:
			var custom_name = tile_data.get_custom_data("Name")
			if custom_name != target_name:
				# Remove the tile completely
				tilemap.erase_cell(cell)
