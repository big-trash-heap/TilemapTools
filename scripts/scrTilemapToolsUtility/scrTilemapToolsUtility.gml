
#region for

/// @function tilemapForRect(tilemap_element_id, cell_x1, cell_y1, cell_x2, cell_y2);
function tilemapForRect(_tilemapElementId,
	_cellX1, _cellY1, _cellX2, _cellY2, _callback) {
	
	var _cellYY;
	for (; _cellX1 <= _cellX2; ++_cellX1) {
		
		for (_cellYY = _cellY1; _cellYY <= _cellY2; ++_cellYY) {
			
			_callback(_tilemapElementId, _cellX1, _cellYY);
		}
	}
}

#endregion

#region basic

//
function tilemapExists(_tilemap) {
	
	try {
			
		var _result = tilemap_get_width(_tilemap);
		return (_result != -1);
	}
	catch (_0) {
			
		return false;
	}
	
	return false;
}

//
function tilemapEntry(_tilemapElementId, _cellX, _cellY) {
	return point_in_rectangle(
		_cellX, _cellY, 
		0, 0, 
		tilemap_get_width(_tilemapElementId) - 1, tilemap_get_height(_tilemapElementId) - 1
	);
}

//
function tilemapEntryAtPixel(_tilemapElementId, _x, _y) {
	return (tilemap_get_cell_x_at_pixel(_tilemapElementId, _x, _y) != -1);
}

//
function tilemapModify(_tilemapElementId, _cellX, _cellY, _value, _handler) {
	
	_value = _handler(tilemap_get(_tilemapElementId, _cellX, _cellY), _value);
	if (_value == undefined) return false;
	
	tilemap_set(_tilemapElementId, _value, _cellX, _cellY);
	return true;
}

#endregion

