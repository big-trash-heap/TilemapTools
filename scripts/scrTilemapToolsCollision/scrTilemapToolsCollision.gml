

#region rectangle

/// @function		tilemapCollsRect(tilemap_element_id, x1, y1, x2, y2, [callback_check=FunctorId], [callback_data], [offset_x=0], [offset_y=0]);
function tilemapCollsRect(_tilemapElementId, _x1, _y1, _x2, _y2, 
	_callbackCheck=apiFunctorId, _callbackData, _offsetX=0, _offsetY=0) {
	
	//
	_offsetX += tilemap_get_x(_tilemapElementId);
	_offsetY += tilemap_get_y(_tilemapElementId);
	
	//
	var _tile_w = tilemap_get_tile_width(_tilemapElementId);
	var _tile_h = tilemap_get_tile_height(_tilemapElementId);
	
	_x1 = (floor(_x1) - _offsetX);
	_x1 = (sign(_x1) == -1 ? _x1 div _tile_w - 1 : _x1 div _tile_w);
	
	_y1 = (floor(_y1) - _offsetY);
	_y1 = (sign(_y1) == -1 ? _y1 div _tile_h - 1 : _y1 div _tile_h);
	
	_x2 = (floor(_x2) - _offsetX) div _tile_w;
	_y2 = (floor(_y2) - _offsetY) div _tile_h;
	
	//
	var _callx, _cally;
	var _yy;
	for (; _x1 <= _x2; ++_x1) {
		
		for (_yy = _y1; _yy <= _y2; ++_yy) {
			
			_callx = _offsetX + _x1 * _tile_w;
			_cally = _offsetY + _yy * _tile_h;
			if (_callbackCheck(tilemap_get(_tilemapElementId, _x1, _yy), _callbackData,
				_callx, _cally, _callx + _tile_w - 1, _cally + _tile_h - 1)) return true;
		}
	}
	return false;
}

/// @function		tilemapCollsRectInst(tilemap_element_id, inst, [inst_x=inst.x], [inst_y=inst.y], [callback_check=FunctorId], [callback_data], [offset_x=0], [offset_y=0]);
function tilemapCollsRectInst(_tilemapElementId, _instance, _instX=_instance.x, _instY=_instance.y, 
	_callbackCheck, _callbackData=_instance, _offsetX, _offsetY) {
	_instX -= _instance.x;
	_instY -= _instance.y;
	return tilemapCollsRect(
		_tilemapElementId,
		_instance.bbox_left   + _instX,
		_instance.bbox_top    + _instY,
		_instance.bbox_right  + _instX,
		_instance.bbox_bottom + _instY,
		_callbackCheck, _callbackData, 
		_offsetX, _offsetY
	);
}

/// @function		tilemapCollsRectSpr(tilemap_element_id, sprite, spr_x, spr_y, [callback_check=FunctorId], [callback_data], [offset_x=0], [offset_y=0]);
function tilemapCollsRectSpr(_tilemapElementId, _sprite, _sprX, _sprY, 
	_callbackCheck, _callbackData=_sprite, _offsetX, _offsetY) {
	_sprX -= sprite_get_xoffset(_sprite);
	_sprY -= sprite_get_yoffset(_sprite);
	return tilemapCollsRect(
		_tilemapElementId,
		sprite_get_bbox_left(_sprite)   + _sprX,
		sprite_get_bbox_top(_sprite)    + _sprY,
		sprite_get_bbox_right(_sprite)  + _sprX,
		sprite_get_bbox_bottom(_sprite) + _sprY,
		_callbackCheck, _callbackData, 
		_offsetX, _offsetY
	);
}

#endregion

