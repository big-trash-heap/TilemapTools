


#region region

function tilemapAuto16_region(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, _offsetTile) {
	__tilemapAuto16_region(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, _offsetTile, __tilemapAuto16_region_is);
}

function tilemapAuto16_region_cp(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, _offsetTile) {
	__tilemapAuto16_region(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, _offsetTile, __tilemapAuto16_region_is_cp);
}

#endregion


#region __region

function __tilemapAuto16_region(_tilemapElementId, _cellX1, _cellY1, _cellX2=_cellX1, _cellY2=_cellY1, _offsetTile=1, _regionIs) {
	
	var _bitsGrow_W;
	var _bitsGrow_H;
	var _xx, _yy;
	var _cell_t, _cell_l;
	var _cell_b, _cell_r;
	
	#region math first
	
	if (_regionIs(_tilemapElementId, _cellX1, _cellY1, _offsetTile)) {
		
		_bitsGrow_W = 0;
		
		_cell_t = _regionIs(_tilemapElementId, _cellX1, _cellY1 - 1, _offsetTile);
		_cell_b = _regionIs(_tilemapElementId, _cellX1, _cellY1 + 1, _offsetTile);
		_cell_l = _regionIs(_tilemapElementId, _cellX1 - 1, _cellY1, _offsetTile);
		_cell_r = _regionIs(_tilemapElementId, _cellX1 + 1, _cellY1, _offsetTile);
		
		if !(_cell_t and _cell_r and
			_regionIs(_tilemapElementId, _cellX1 + 1, _cellY1 - 1, _offsetTile))
			_bitsGrow_W += 2;
		
		if !(_cell_b and _cell_r and
			_regionIs(_tilemapElementId, _cellX1 + 1, _cellY1 + 1, _offsetTile))
			_bitsGrow_W += 8;
		
		if !(_cell_t and _cell_l and
			_regionIs(_tilemapElementId, _cellX1 - 1, _cellY1 - 1, _offsetTile))
			_bitsGrow_W += 1;
		
		if !(_cell_b and _cell_l and
			_regionIs(_tilemapElementId, _cellX1 - 1, _cellY1 + 1, _offsetTile))
			_bitsGrow_W += 4;
		
		tilemap_set(_tilemapElementId, _bitsGrow_W + _offsetTile, _cellX1, _cellY1);
		_bitsGrow_H = (_bitsGrow_W & 12) >> 2;
		_bitsGrow_W = (_bitsGrow_W & 10) >> 1;
	}
	else {
		_bitsGrow_W = 5;
		_bitsGrow_H = 3;
		tilemap_set(_tilemapElementId, 15 + _offsetTile, _cellX1, _cellY1);
	}
	
	for (_xx = _cellX1 + 1; _xx <= _cellX2; ++_xx) {
		
		if (_regionIs(_tilemapElementId, _xx, _cellY1, _offsetTile)) {
			
			_cell_t = _regionIs(_tilemapElementId, _xx, _cellY1 - 1, _offsetTile);
			_cell_b = _regionIs(_tilemapElementId, _xx, _cellY1 + 1, _offsetTile);
			_cell_r = _regionIs(_tilemapElementId, _xx + 1, _cellY1, _offsetTile);
			
			if !(_cell_t and _cell_r and
				_regionIs(_tilemapElementId, _xx + 1, _cellY1 - 1, _offsetTile))
				_bitsGrow_W += 2;
			
			if !(_cell_b and _cell_r and
				_regionIs(_tilemapElementId, _xx + 1, _cellY1 + 1, _offsetTile))
				_bitsGrow_W += 8;
			
			tilemap_set(_tilemapElementId, _bitsGrow_W + _offsetTile, _xx, _cellY1);
			_bitsGrow_W = (_bitsGrow_W & 10) >> 1;
		}
		else {
			_bitsGrow_W = 5;
			tilemap_set(_tilemapElementId, 15 + _offsetTile, _xx, _cellY1);
		}
	}
	
	#endregion
	
	#region math second
	
	for (_yy = _cellY1 + 1; _yy <= _cellY2; ++_yy) {
		
		if (_regionIs(_tilemapElementId, _cellX1, _yy, _offsetTile)) {
			
			_cell_b = _regionIs(_tilemapElementId, _cellX1, _yy + 1, _offsetTile);
			_cell_r = _regionIs(_tilemapElementId, _cellX1 + 1, _yy, _offsetTile);
			_cell_l = _regionIs(_tilemapElementId, _cellX1 - 1, _yy, _offsetTile);
			
			if !(_cell_b and _cell_l and
				_regionIs(_tilemapElementId, _cellX1 - 1, _yy + 1, _offsetTile))
				_bitsGrow_H += 4;
			
			if !(_cell_b and _cell_r and
				_regionIs(_tilemapElementId, _cellX1 + 1, _yy + 1, _offsetTile))
				_bitsGrow_H += 8;
			
			tilemap_set(_tilemapElementId, _bitsGrow_H + _offsetTile, _cellX1, _yy);
			_bitsGrow_W = (_bitsGrow_H & 10) >> 1;
			_bitsGrow_H = (_bitsGrow_H & 12) >> 2;
		}
		else {
			_bitsGrow_W = 5;
			_bitsGrow_H = 3;
			tilemap_set(_tilemapElementId, 15 + _offsetTile, _cellX1, _yy);
		}
		
		for (_xx = _cellX1 + 1; _xx <= _cellX2; ++_xx) {
			
			if (_regionIs(_tilemapElementId, _xx, _yy, _offsetTile)) {
			
				_cell_t = _regionIs(_tilemapElementId, _xx, _yy - 1, _offsetTile);
				if (_cell_t)
					_bitsGrow_W += ((_cell_t - _offsetTile & 8) != 0) * 2;
				
				_cell_b = _regionIs(_tilemapElementId, _xx, _yy + 1, _offsetTile);
				_cell_r = _regionIs(_tilemapElementId, _xx + 1, _yy, _offsetTile);
			
				if !(_cell_b and _cell_r and
					_regionIs(_tilemapElementId, _xx + 1, _yy + 1, _offsetTile))
					_bitsGrow_W += 8;
			
				tilemap_set(_tilemapElementId, _bitsGrow_W + _offsetTile, _xx, _yy);
				_bitsGrow_W = (_bitsGrow_W & 10) >> 1;
			}
			else {
				_bitsGrow_W = 5;
				tilemap_set(_tilemapElementId, 15 + _offsetTile, _xx, _yy);
			}
		}
	}
	
	#endregion
}

#endregion

#region __updata16

function __tilemapAuto16_region_is(_tilemapElementId, _cellX, _cellY) {
	return tilemap_get(_tilemapElementId, _cellX, _cellY);
}

function __tilemapAuto16_region_is_cp(_tilemapElementId, _cellX, _cellY, _offsetTile) {
	_cellX = tilemap_get(_tilemapElementId, _cellX, _cellY);
	if (_cellX == -1) return (15 + _offsetTile);
	return _cellX;
}

#endregion

