

function __tilemapCallAPix(_tilemapElementId, _x, _y, _call) {
	
	var _cellX = tilemap_get_cell_x_at_pixel(_tilemapElementId, _x, _y);
	if (_cellX != -1) {
		
		_y = tilemap_get_cell_y_at_pixel(_tilemapElementId, _x, _y);
		_call(_tilemapElementId, _cellX, _y);
	}
}

