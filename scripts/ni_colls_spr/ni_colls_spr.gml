/*
function spriteGetMask(_sprite, _xscale=1, _yscale=1, _xoffset=sprite_get_xoffset()) {
	
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
