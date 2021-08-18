
function tilemapAuto47_region(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2) {
	
	var _bitsGrow_W;
	var _bitsGrow_H;
	var _xx, _yy;
	var _ang_tl, _ang_tr;
	var _ang_bl, _ang_br;
	
	#region math first
	
	if (tilemap_get(_tilemapElementId, _cellX1, _cellY1)) {
		
		_bitsGrow_W = 0;
		
		_ang_tl = 1;
		_ang_tr = 1;
		_ang_bl = 1;
		_ang_br = 1;
		
		// top
		if (tilemap_get(_tilemapElementId, _cellX1, _cellY1 - 1)) {
			_ang_tl      = _ang_tl << 1;
			_ang_tr      = _ang_tr << 1;
			_bitsGrow_W |= 2;
		}
		
		// left
		if (tilemap_get(_tilemapElementId, _cellX1 - 1, _cellY1)) {
			_ang_tl      = _ang_tl << 1;
			_ang_bl      = _ang_bl << 1;
			_bitsGrow_W |= 8;
		}
		
		// right
		if (tilemap_get(_tilemapElementId, _cellX1 + 1, _cellY1)) {
			_ang_tr      = _ang_tr << 1;
			_ang_br      = _ang_br << 1;
			_bitsGrow_W |= 16;
		}
		
		// bottom
		if (tilemap_get(_tilemapElementId, _cellX1, _cellY1 + 1)) {
			_ang_bl      = _ang_bl << 1;
			_ang_br      = _ang_br << 1;
			_bitsGrow_W |= 64;
		}
		
		// top-left
		if (_ang_tl == 4 and tilemap_get(_tilemapElementId, _cellX1 - 1, _cellY1 - 1))
			_bitsGrow_W |= 1;
		
		// top-right
		if (_ang_tr == 4 and tilemap_get(_tilemapElementId, _cellX1 + 1, _cellY1 - 1))
			_bitsGrow_W |= 4;
		
		// bottom-left
		if (_ang_bl == 4 and tilemap_get(_tilemapElementId, _cellX1 - 1, _cellY1 + 1))
			_bitsGrow_W |= 32;
		
		// bottom-right
		if (_ang_br == 4 and tilemap_get(_tilemapElementId, _cellX1 + 1, _cellY1 + 1))
			_bitsGrow_W |= 128;
		
		tilemap_set(
			_tilemapElementId, 
			global.__tilemapAuto47_table[? ~_bitsGrow_W & 511 | 256] + 1,
			_cellX1, _cellY1
		);
		
		_bitsGrow_H = (_bitsGrow_W & 224)  >> 5;
		_bitsGrow_W = ((_bitsGrow_W & 132) >> 2 | (_bitsGrow_W & 16) >> 1);
	}
	else {
		_bitsGrow_W = 0;
		_bitsGrow_H = 0;
	}
	
	for (_xx = _cellX1 + 1; _xx <= _cellX2; ++_xx) {
		
		if (tilemap_get(_tilemapElementId, _xx, _cellY1)) {
			
			_ang_tr = 1;
			_ang_br = 1;
			
			// top
			if (tilemap_get(_tilemapElementId, _xx, _cellY1 - 1)) {
				_ang_tr      = _ang_tr << 1;
				_bitsGrow_W |= 2;
			}
			
			// right
			if (tilemap_get(_tilemapElementId, _xx + 1, _cellY1)) {
				_ang_tr      = _ang_tr << 1;
				_ang_br      = _ang_br << 1;
				_bitsGrow_W |= 16;
			}
			
			// bottom
			if (tilemap_get(_tilemapElementId, _xx, _cellY1 + 1)) {
				_ang_br      = _ang_br << 1;
				_bitsGrow_W |= 64;
			}
			
			// top-right
			if (_ang_tr == 4 and tilemap_get(_tilemapElementId, _xx + 1, _cellY1 - 1))
				_bitsGrow_W |= 4;
			
			// bottom-right
			if (_ang_br == 4 and tilemap_get(_tilemapElementId, _xx + 1, _cellY1 + 1))
				_bitsGrow_W |= 128;
			
			tilemap_set(
				_tilemapElementId, 
				global.__tilemapAuto47_table[? ~_bitsGrow_W & 511 | 256] + 1,
				_xx, _cellY1
			);
			
			_bitsGrow_W = ((_bitsGrow_W & 132) >> 2 | (_bitsGrow_W & 16) >> 1);
		}
		else {
			_bitsGrow_W = 0;
		}
	}
	
	#endregion
	
	#region second
	
	#endregion
	
}

function tilemapAuto47_region_cp(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2) {
	//__tilemapAuto47_region(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, __tilemapAuto47_region_is_cp);
}

