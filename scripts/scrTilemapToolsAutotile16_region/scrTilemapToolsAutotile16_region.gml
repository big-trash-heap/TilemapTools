


#region region

function tilemapAuto16_region(_tilemapElementId, _cellX1, _cellY1, _cellX2=_cellX1, _cellY2=_cellY1, _offsetTile=1) {
	
	var _bitsGrow_W;
	var _bitsGrow_H;
	var _bitsNext_W;
	var _bitsNext_H;
	var _xx, _yy, _bits;
	
	#region math first
	
	_bitsGrow_W =
		__tilemapAuto16_region_angle(_tilemapElementId, _cellX1, _cellY1,  1, -1, 2) +
		__tilemapAuto16_region_angle(_tilemapElementId, _cellX1, _cellY1,  1,  1, 8);
	
	_bits =
		__tilemapAuto16_region_angle(_tilemapElementId, _cellX1, _cellY1, -1, -1, 1) +
		__tilemapAuto16_region_angle(_tilemapElementId, _cellX1, _cellY1, -1,  1, 4) + _bitsGrow_W;
	
	_bitsGrow_W = _bitsGrow_W  >> 1;
	_bitsGrow_H = (_bits & 12) >> 2;
	tilemap_set(_tilemapElementId, _bits + _offsetTile, _cellX1, _cellY1);
	
	for (_xx = _cellX1 + 1; _xx <= _cellX2; ++_xx) {
		
		_bitsNext_W = 
			__tilemapAuto16_region_angle(_tilemapElementId, _xx, _cellY1,  1, -1, 2) +
			__tilemapAuto16_region_angle(_tilemapElementId, _xx, _cellY1,  1,  1, 8);
		
		tilemap_set(_tilemapElementId, _bitsGrow_W + _bitsNext_W + _offsetTile, _xx, _cellY1);
		_bitsGrow_W = _bitsNext_W >> 1;
	}
	
	#endregion
	
	#region math second
	
	for (_yy = _cellY1 + 1; _yy <= _cellY2; ++_yy) {
		
		_bitsNext_H =
			__tilemapAuto16_region_angle(_tilemapElementId, _cellX1, _yy, -1, 1, 4) +
			__tilemapAuto16_region_angle(_tilemapElementId, _cellX1, _yy,  1, 1, 8);
		
		_bits = _bitsGrow_H + _bitsNext_H;
		_bitsGrow_W = (_bits & 10) >> 1;
		_bitsGrow_H = _bitsNext_H  >> 2;
		
		tilemap_set(_tilemapElementId, _bits + _offsetTile, _cellX1, _yy);
		for (_xx = _cellX1 + 1; _xx <= _cellX2; ++_xx) {
			
			_bitsNext_W = 
				((tilemap_get(_tilemapElementId, _xx, _yy - 1) - _offsetTile & 8) > 0) * 2 +
				__tilemapAuto16_region_angle(_tilemapElementId, _xx, _yy,  1,  1, 8);
			
			tilemap_set(_tilemapElementId, _bitsGrow_W + _bitsNext_W + _offsetTile, _xx, _yy);
			_bitsGrow_W = _bitsNext_W >> 1;
		}
	}
	
	#endregion
}

#endregion


#region __updata16

function __tilemapAuto16_region_angle(_tilemapElementId, _cellX, _cellY, _cellOffsetX, _cellOffsetY, _result) {
	return (
		(  tilemap_get(_tilemapElementId, _cellX, _cellY)
		&& tilemap_get(_tilemapElementId, _cellX + _cellOffsetX, _cellY + _cellOffsetY)
		&& tilemap_get(_tilemapElementId, _cellX + _cellOffsetX, _cellY)
		&& tilemap_get(_tilemapElementId, _cellX, _cellY + _cellOffsetY)
	) * _result);
}

#endregion

