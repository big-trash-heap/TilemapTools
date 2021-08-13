

#region Auto

function tilemapAuto16def_set(_tilemapElementId, _cellX, _cellY, _offsetTile=1) {
	
	// center
	tilemapModify(_tilemapElementId, _cellX, _cellY, 0, __tilemapAuto16def_set, _offsetTile);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, 3, __tilemapAuto16def_set, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 7,  __tilemapAuto16def_set, _offsetTile); // left-top
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 11, __tilemapAuto16def_set, _offsetTile); // right-top
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, 12, __tilemapAuto16def_set, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 13, __tilemapAuto16def_set, _offsetTile); // left-down
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 14, __tilemapAuto16def_set, _offsetTile); // right-down
	}
	
	//
	tilemapModify(_tilemapElementId, _cellX - 1, _cellY, 5,  __tilemapAuto16def_set, _offsetTile); // left
	tilemapModify(_tilemapElementId, _cellX + 1, _cellY, 10, __tilemapAuto16def_set, _offsetTile); // right
}

function tilemapAuto16def_reset(_tilemapElementId, _cellX, _cellY, _offsetTile=1) {
	
	// center
	tilemapModify(_tilemapElementId, _cellX, _cellY, 15, __tilemapAuto16def_reset, _offsetTile);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, 12, __tilemapAuto16def_reset, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 8, __tilemapAuto16def_reset, _offsetTile); // left-top
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 4, __tilemapAuto16def_reset, _offsetTile); // right-top
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, 3, __tilemapAuto16def_reset, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 2, __tilemapAuto16def_reset, _offsetTile); // left-down
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 1, __tilemapAuto16def_reset, _offsetTile); // right-down
	}
	
	//
	tilemapModify(_tilemapElementId, _cellX - 1, _cellY, 10, __tilemapAuto16def_reset, _offsetTile); // left
	tilemapModify(_tilemapElementId, _cellX + 1, _cellY, 5,  __tilemapAuto16def_reset, _offsetTile); // right
}

function tilemapAuto16defAPix_set(_tilemapElementId, _x, _y, _offsetTile) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, _offsetTile, tilemapAuto16def_set);
}

function tilemapAuto16defAPix_reset(_tilemapElementId, _x, _y, _offsetTile) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, _offsetTile, tilemapAuto16def_reset);
}

#endregion


#region __handler16

function __tilemapAuto16def_set(_tile, _value, _offset) {
	
	if (_tile > -1) {
		
		return (((_tile - _offset) & _value) + _offset);
	}
}

function __tilemapAuto16def_reset(_tile, _value, _offset) {
	
	if (_tile > -1) {
		
		return (((_tile - _offset) | _value) + _offset);
	}
}

#endregion

#region __atPixel

function __tilemapCallAPix(_tilemapElementId, _x, _y, _offsetTile, _call) {
	
	var _cellX = tilemap_get_cell_x_at_pixel(_tilemapElementId, _x, _y);
	if (_cellX != -1) {
		
		_y = tilemap_get_cell_y_at_pixel(_tilemapElementId, _x, _y);
		_call(_tilemapElementId, _cellX, _y, _offsetTile);
	}
}

#endregion

