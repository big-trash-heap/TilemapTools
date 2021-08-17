

#region rectangle

function tilemapCollsRect(_tilemapElementId, _x1, _y1, _x2, _y2, _callbackCheck=bool, _offsetX=0, _offsetY=0) {
	
	//
	_offsetX += tilemap_get_x(_tilemapElementId);
	_offsetY += tilemap_get_y(_tilemapElementId);
	
	//
	var _tile_w = tilemap_get_tile_width(_tilemapElementId);
	var _tile_h = tilemap_get_tile_height(_tilemapElementId);
	
	_x1 = max(0, 
		(mathRounding(_x1, floor) - _offsetX) div _tile_w);
	_y1 = max(0, 
		(mathRounding(_y1, floor) - _offsetY) div _tile_h);
	_x2 = min(tilemap_get_width(_tilemapElementId) - 1, 
		(mathRounding(_x2, ceil)  - _offsetX) div _tile_w);
	_y2 = min(tilemap_get_height(_tilemapElementId) - 1,
		(mathRounding(_y2, ceil)  - _offsetY) div _tile_h);
	
	//
	var _yy;
	for (; _x1 <= _x2; ++_x1) {
		
		for (_yy = _y1; _yy <= _y2; ++_yy) {
			
			if (_callbackCheck(tilemap_get(_tilemapElementId, _x1, _yy))) return true;
		}
	}
	return false;
}

function tilemapCollsRectObj(_tilemapElementId, _object, _objX=_object.x, _objY=_object.y, _callbackCheck, _offsetX, _offsetY) {
	_objX -= _object.x;
	_objY -= _object.y;
	return tilemapCollsRect(
		_tilemapElementId,
		_object.bbox_left   - _objX,
		_object.bbox_top    - _objY,
		_object.bbox_right  - _objX,
		_object.bbox_bottom - _objY,
		_callbackCheck, _offsetX, _offsetY
	);
}

function tilemapCollsRectSpr(_tilemapElementId, _sprite, _sprX, _sprY, _callbackCheck, _offsetX, _offsetY) {
	_sprX -= sprite_get_xoffset(_sprite);
	_sprY -= sprite_get_yoffset(_sprite);
	return tilemapCollsRect(
		_tilemapElementId,
		sprite_get_bbox_left(_sprite)   + _sprX,
		sprite_get_bbox_top(_sprite)    + _sprY,
		sprite_get_bbox_right(_sprite)  + _sprX,
		sprite_get_bbox_bottom(_sprite) + _sprY,
		_callbackCheck, _offsetX, _offsetY
	);
}

#endregion

