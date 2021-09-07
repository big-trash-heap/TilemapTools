

#region rectangle

/*
	Для конкректной ситуации, куда лучше написать свой алгоритм проверки столкновения
	Данный же алгоритм является общим, и не претендует на оптимальность
	
	Это не значит, что этот функционал написан только для прототипирования, он вполне оптимален
	Его можно переписать под конкректную задачу, тогда он будет максимально эффективным
	
	В качестве offset_x и offset_y ожидается, что будет переданны актуальные координаты тайлмапа
	(так как я не могу знать, слой на котором лежит тайлмап, я не могу знать, точных координат)
	(tilemap_get_x + layer_get_x ...)
*/

//					callback_check = callback_check(tile_data, data, x1, y1, x2, y2)

/// @function		tilemapCollsRect(tilemap_element_id, x1, y1, x2, y2, [callback_check=FunctorId], [callback_data], [offset_x=tilemap_get_x], [offset_y=tilemap_get_y]);
function tilemapCollsRect(
	_tilemapElementId, _x1, _y1, _x2, _y2, 
	_callbackCheck=apiFunctorId, _callbackData, 
	_offsetX=tilemap_get_x(_tilemapElementId), _offsetY=tilemap_get_y(_tilemapElementId)) {
	
	//
	var _tilew = tilemap_get_tile_width(_tilemapElementId);
	var _tileh = tilemap_get_tile_height(_tilemapElementId);
	
	_x1 = (floor(_x1) - _offsetX);
	_x1 = (sign(_x1) == -1 ? _x1 div _tilew - 1 : _x1 div _tilew);
	
	_y1 = (floor(_y1) - _offsetY);
	_y1 = (sign(_y1) == -1 ? _y1 div _tileh - 1 : _y1 div _tileh);
	
	_x2 = (floor(_x2) - _offsetX) div _tilew;
	_y2 = (floor(_y2) - _offsetY) div _tileh;
	
	//
	var _callx, _cally;
	var _yy;
	for (; _x1 <= _x2; ++_x1) {
		
		for (_yy = _y1; _yy <= _y2; ++_yy) {
			
			_callx = _offsetX + _x1 * _tilew;
			_cally = _offsetY + _yy * _tileh;
			if (_callbackCheck(tilemap_get(_tilemapElementId, _x1, _yy), _callbackData,
				_callx, _cally, _callx + _tilew - 1, _cally + _tileh - 1)) return true;
		}
	}
	return false;
}

/// @function		tilemapCollsRectList(tilemap_element_id, x1, y1, x2, y2, list, [callback_check=FunctorId], [callback_data], [offset_x=tilemap_get_x], [offset_y=tilemap_get_y]);
function tilemapCollsRectList(
	_tilemapElementId, _x1, _y1, _x2, _y2, _list,
	_callbackCheck=apiFunctorId, _callbackData,
	_offsetX=tilemap_get_x(_tilemapElementId), _offsetY=tilemap_get_y(_tilemapElementId)) {
	
	//
	var _tilew = tilemap_get_tile_width(_tilemapElementId);
	var _tileh = tilemap_get_tile_height(_tilemapElementId);
	
	_x1 = (floor(_x1) - _offsetX);
	_x1 = (sign(_x1) == -1 ? _x1 div _tilew - 1 : _x1 div _tilew);
	
	_y1 = (floor(_y1) - _offsetY);
	_y1 = (sign(_y1) == -1 ? _y1 div _tileh - 1 : _y1 div _tileh);
	
	_x2 = (floor(_x2) - _offsetX) div _tilew;
	_y2 = (floor(_y2) - _offsetY) div _tileh;
	
	//
	var _size = 0;
	var _callx1, _cally1, _callx2, _cally2, _tile;
	var _yy;
	for (; _x1 <= _x2; ++_x1) {
		
		for (_yy = _y1; _yy <= _y2; ++_yy) {
			
			_callx1 = _offsetX + _x1 * _tilew;
			_cally1 = _offsetY + _yy * _tileh;
			_callx2 = _callx1 + _tilew - 1;
			_cally2 = _cally1 + _tileh - 1;
			_tile   = tilemap_get(_tilemapElementId, _x1, _yy);
			
			if (_callbackCheck(_tile, _callbackData, _callx1, _cally1, _callx2, _cally2)) {
				
				++_size;
				ds_list_add(_list, {
					tile: _tile,
					x1: _callx1,
					y1: _cally1,
					x2: _callx2,
					y2: _cally2,
				});
			}
		}
	}
	return _size;
}

/// @function		tilemapCollsRectInst(tilemap_element_id, inst, [inst_x=inst.x], [inst_y=inst.y], [callback_check=FunctorId], [callback_data], [offset_x=0], [offset_y=0]);
function tilemapCollsRectInst(
	_tilemapElementId, _instance, _instX=_instance.x, _instY=_instance.y, 
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

#endregion

