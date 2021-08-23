

#region for

//				callback = callback(tilemap_element_id, cell_x, cell_y, data)
/// @function	tilemapForRect(tilemap_element_id, cell_x1, cell_y1, cell_x2, cell_y2, callback, [data]);
function tilemapForRect(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, _callback, _data) {
	
	var _cellYY;
	for (; _cellX1 <= _cellX2; ++_cellX1) {
		
		for (_cellYY = _cellY1; _cellYY <= _cellY2; ++_cellYY) {
			
			_callback(_tilemapElementId, _cellX1, _cellYY, _data);
		}
	}
}

#endregion

#region basic

/// @function		tilemapExists(tilemap_element_id);
function tilemapExists(_tilemapElementId) {
	
	try {
			
		var _result = tilemap_get_width(_tilemapElementId);
		return (_result != -1);
	}
	catch (_0) {
			
		return false;
	}
	
	return false;
}

/// @function		tilemapEntry(tilemap_element_id, cell_x, cell_y);
function tilemapEntry(_tilemapElementId, _cellX, _cellY) {
	return (point_in_rectangle(
		_cellX, _cellY, 
		0, 0, 
		tilemap_get_width(_tilemapElementId) - 1, tilemap_get_height(_tilemapElementId) - 1
	) > 0);
}

/// @function		tilemapEntryAtPixel(tilemap_element_id, x, y);
function tilemapEntryAtPixel(_tilemapElementId, _x, _y) {
	return (tilemap_get_cell_x_at_pixel(_tilemapElementId, _x, _y) != -1);
}

//					handler = handler(tile_data, value);
/// @function		tilemapModify(tilemap_element_id, cell_x, cell_y, handler);
function tilemapModify(_tilemapElementId, _cellX, _cellY, _value, _handler) {
	
	_value = _handler(tilemap_get(_tilemapElementId, _cellX, _cellY), _value);
	if (_value == undefined) return false;
	
	tilemap_set(_tilemapElementId, _value, _cellX, _cellY);
	return true;
}

#endregion


#region debug

//					draw_cell = draw_cell(tile_data, x1, y1, x2, y2);
/// @function		tilemapDebugDraw(tilemap_element_id, offset_x, offset_y, draw_cell);
function tilemapDebugDraw(_tilemapElementId, _offsetX, _offsetY, _drawCell) {
	
	var _tilew = tilemap_get_tile_width(_tilemapElementId);
	var _tileh = tilemap_get_tile_height(_tilemapElementId);
	var _w = tilemap_get_width(_tilemapElementId);
	var _h = tilemap_get_height(_tilemapElementId);
	var _xx, _yy;
	for (var _i = 0, _j; _i < _w; ++_i) {
		for (_j = 0;     _j < _h; ++_j) {
			_xx = _offsetX + _i * _tilew;
			_yy = _offsetY + _j * _tileh;
			
			_drawCell(
				tilemap_get(_tilemapElementId, _i, _j),
				_xx, _yy, _xx + _tilew - 1, _yy + _tileh - 1,
			);
		}
	}
}

#endregion

