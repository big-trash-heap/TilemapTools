

#region Auto

function tilemapAuto16_set(_tilemapElementId, _cellX, _cellY, _offsetTile=1) {
	
	// center
	tilemapModify(_tilemapElementId, _cellX, _cellY, 0, __tilemapAuto16_set, _offsetTile);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, 3, __tilemapAuto16_set, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 7,  __tilemapAuto16_set, _offsetTile); // left-top
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 11, __tilemapAuto16_set, _offsetTile); // right-top
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, 12, __tilemapAuto16_set, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 13, __tilemapAuto16_set, _offsetTile); // left-down
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 14, __tilemapAuto16_set, _offsetTile); // right-down
	}
	
	//
	tilemapModify(_tilemapElementId, _cellX - 1, _cellY, 5,  __tilemapAuto16_set, _offsetTile); // left
	tilemapModify(_tilemapElementId, _cellX + 1, _cellY, 10, __tilemapAuto16_set, _offsetTile); // right
}

function tilemapAuto16_set_cd(_tilemapElementId, _cellX, _cellY, _offsetTile=1) {
	
	tilemapModify(_tilemapElementId, _cellX, _cellY, 0, __tilemapAuto16_set, _offsetTile);
	
	//
	var _mask_10_l = (tilemapEntry(_tilemapElementId, _cellX - 2, _cellY) ? 5  : 0);
	var _mask_05_r = (tilemapEntry(_tilemapElementId, _cellX + 2, _cellY) ? 10 : 0);
	var _mask_12_t = (tilemapEntry(_tilemapElementId, _cellX, _cellY - 2) ? 3  : 0);
	var _mask_03_d = (tilemapEntry(_tilemapElementId, _cellX, _cellY + 2) ? 12 : 0);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, _mask_12_t, __tilemapAuto16_set, _offsetTile)) {
		
		//
		if (_mask_12_t == 0) {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, _mask_10_l, __tilemapAuto16_set, _offsetTile); // left-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, _mask_05_r, __tilemapAuto16_set, _offsetTile); // right-top
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 7,  __tilemapAuto16_set, _offsetTile); // left-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 11, __tilemapAuto16_set, _offsetTile); // right-top
		}
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, _mask_03_d, __tilemapAuto16_set, _offsetTile)) {
		
		//
		if (_mask_03_d == 0) {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, _mask_10_l, __tilemapAuto16_set, _offsetTile); // left-down
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, _mask_05_r, __tilemapAuto16_set, _offsetTile); // right-down
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 13, __tilemapAuto16_set, _offsetTile); // left-down
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 14, __tilemapAuto16_set, _offsetTile); // right-down
		}
	}
			
	// left
	if (tilemapModify(_tilemapElementId, _cellX - 1, _cellY, _mask_10_l, __tilemapAuto16_set, _offsetTile)) {
		
		//
		if (_mask_10_l == 0) {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, _mask_12_t, __tilemapAuto16_set, _offsetTile); // left-top
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, _mask_03_d, __tilemapAuto16_set, _offsetTile); // left-down
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 7,  __tilemapAuto16_set, _offsetTile); // left-top
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 13, __tilemapAuto16_set, _offsetTile); // left-down
		}
	}
			
	// right
	if (tilemapModify(_tilemapElementId, _cellX + 1, _cellY, _mask_05_r, __tilemapAuto16_set, _offsetTile)) {
		
		//
		if (_mask_05_r == 0) {
			
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, _mask_12_t, __tilemapAuto16_set, _offsetTile); // right-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, _mask_03_d, __tilemapAuto16_set, _offsetTile); // right-down
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 11, __tilemapAuto16_set, _offsetTile); // right-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 14, __tilemapAuto16_set, _offsetTile); // right-down
		}
	}
}

function tilemapAuto16_reset(_tilemapElementId, _cellX, _cellY, _offsetTile=1) {
	
	// center
	tilemapModify(_tilemapElementId, _cellX, _cellY, 15, __tilemapAuto16_reset, _offsetTile);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, 12, __tilemapAuto16_reset, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 8, __tilemapAuto16_reset, _offsetTile); // left-top
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 4, __tilemapAuto16_reset, _offsetTile); // right-top
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, 3, __tilemapAuto16_reset, _offsetTile)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 2, __tilemapAuto16_reset, _offsetTile); // left-down
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 1, __tilemapAuto16_reset, _offsetTile); // right-down
	}
	
	//
	tilemapModify(_tilemapElementId, _cellX - 1, _cellY, 10, __tilemapAuto16_reset, _offsetTile); // left
	tilemapModify(_tilemapElementId, _cellX + 1, _cellY, 5,  __tilemapAuto16_reset, _offsetTile); // right
}

function tilemapAuto16APix_set(_tilemapElementId, _x, _y, _offsetTile) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, _offsetTile, tilemapAuto16_set);
}

function tilemapAuto16APix_set_cd(_tilemapElementId, _x, _y, _offsetTile) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, _offsetTile, tilemapAuto16_set_cd);
}

function tilemapAuto16APix_reset(_tilemapElementId, _x, _y, _offsetTile) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, _offsetTile, tilemapAuto16_reset);
}

#endregion


#region __handler16

function __tilemapAuto16_set(_tile, _value, _offset) {
	
	if (_tile > -1) {
		
		return ((_value & _tile - _offset) + _offset);
	}
}

function __tilemapAuto16_reset(_tile, _value, _offset) {
	
	if (_tile > -1) {
		
		//return ((~_value & 15 | _tile - _offset) + _offset);
		return ((_value | _tile - _offset) + _offset);
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

