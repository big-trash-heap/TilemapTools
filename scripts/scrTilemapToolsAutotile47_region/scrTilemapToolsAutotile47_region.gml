
// аналогичный инструмент на 16 мне показался, крайне бесполезный

#region auto-default

/*
	В качестве окружения использует тайлмап
	
	Вы устанавливаете на тайлмапе 0 и 1 (как состояния есть и нету), после чего обновляете
	необходимую область и вуаля.
	(для проверки используется обычный оператор if())
	
	Свойства кроме индекса игнорируются (tile_get_mirror, tile_get_rotate, ...)
*/

/// @function		tilemapAuto47_region(tilemap_element_id, cell_x1, cell_y1, cell_x2, cell_y2);
function tilemapAuto47_region(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2) {
	tilemapAuto47_region_custom(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, __tilemapAuto47_region_is);
}

/// @function		tilemapAuto47_region_cd(tilemap_element_id, cell_x1, cell_y1, cell_x2, cell_y2);
function tilemapAuto47_region_cd(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2) {
	tilemapAuto47_region_custom(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, __tilemapAuto47_region_is_cd);
}

#endregion

#region auto-custom

/*
	Для каждой ячейки мы анализируем её окружение, и вычисляем нужный индекс
	(конкретные биты тут не играют роли)
	
	Мы так же можем передать предикат и данные для него, что даёт возможность читать
	окружение из вне. (Например из буфера, или из ds_grid)
	Это делает эту функцию очень гибкой
	
	Логика вычисления не много более сложная, мы вычисляем только то, что нужно,
	остальное известно из предыдущих шагов вычисления
	
	От предиката ожидается либо true, либо false
	
	Свойства кроме индекса игнорируются (tile_get_mirror, tile_get_rotate, ...)
*/

///					predicate = predicate(tilemap_element_id, cell_x, cell_y, data)
/// @function		tilemapAuto47_region_custom(tilemap_element_id, cell_x1, cell_y1, cell_x2, cell_y2, predicate, [data]);
function tilemapAuto47_region_custom(_tilemapElementId, _cellX1, _cellY1, _cellX2, _cellY2, _isCheck, _isData) {
	
	var _bitsGrow_W;
	var _bitsGrow_H;
	var _xx, _yy;
	var _ang_tl, _ang_tr;
	var _ang_bl, _ang_br;
	
	#region math first
	
	if (_isCheck(_tilemapElementId, _cellX1, _cellY1, _isData)) {
		
		// вычисляем первую ячейку
		
		_bitsGrow_W = 0;
		
		_ang_tl = -1;
		_ang_tr = -1;
		_ang_bl = -1;
		_ang_br = -1;
		
		// top
		if (_isCheck(_tilemapElementId, _cellX1, _cellY1 - 1, _isData)) {
			++_ang_tl;
			++_ang_tr;
			_bitsGrow_W |= 2;
		}
		
		// left
		if (_isCheck(_tilemapElementId, _cellX1 - 1, _cellY1, _isData)) {
			++_ang_tl;
			++_ang_bl;
			_bitsGrow_W |= 8;
		}
		
		// right
		if (_isCheck(_tilemapElementId, _cellX1 + 1, _cellY1, _isData)) {
			++_ang_tr;
			++_ang_br;
			_bitsGrow_W |= 16;
		}
		
		// bottom
		if (_isCheck(_tilemapElementId, _cellX1, _cellY1 + 1, _isData)) {
			++_ang_bl;
			++_ang_br;
			_bitsGrow_W |= 64;
		}
		
		// top-left
		if (_ang_tl and _isCheck(_tilemapElementId, _cellX1 - 1, _cellY1 - 1, _isData))
			_bitsGrow_W |= 1;
		
		// top-right
		if (_ang_tr and _isCheck(_tilemapElementId, _cellX1 + 1, _cellY1 - 1, _isData))
			_bitsGrow_W |= 4;
		
		// bottom-left
		if (_ang_bl and _isCheck(_tilemapElementId, _cellX1 - 1, _cellY1 + 1, _isData))
			_bitsGrow_W |= 32;
		
		// bottom-right
		if (_ang_br and _isCheck(_tilemapElementId, _cellX1 + 1, _cellY1 + 1, _isData))
			_bitsGrow_W |= 128;
		
		tilemap_set(
			_tilemapElementId, 
			global.__tilemapAuto47_table[? ~_bitsGrow_W & 511 | 256] + 1,
			_cellX1, _cellY1
		);
		
		_bitsGrow_H = (_bitsGrow_W & 224) >> 5;
		_bitsGrow_W = ((_bitsGrow_W & 132) >> 2 | (_bitsGrow_W & 16) >> 1);
	}
	else {
		_bitsGrow_W = 0;
		_bitsGrow_H = 0;
	}
	
	// вычисляем первый ряд
	for (_xx = _cellX1 + 1; _xx <= _cellX2; ++_xx) {
		
		if (_isCheck(_tilemapElementId, _xx, _cellY1, _isData)) {
			
			_ang_tr = -1;
			_ang_br = -1;
			
			// top
			if (_isCheck(_tilemapElementId, _xx, _cellY1 - 1, _isData)) {
				++_ang_tr;
				_bitsGrow_W |= 2;
			}
			
			// right
			if (_isCheck(_tilemapElementId, _xx + 1, _cellY1, _isData)) {
				++_ang_tr;
				++_ang_br;
				_bitsGrow_W |= 16;
			}
			
			// bottom
			if (_isCheck(_tilemapElementId, _xx, _cellY1 + 1, _isData)) {
				++_ang_br;
				_bitsGrow_W |= 64;
			}
			
			// top-right
			if (_ang_tr and _isCheck(_tilemapElementId, _xx + 1, _cellY1 - 1, _isData))
				_bitsGrow_W |= 4;
			
			// bottom-right
			if (_ang_br and _isCheck(_tilemapElementId, _xx + 1, _cellY1 + 1, _isData))
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
	
	#region math second
	
	for (_yy = _cellY1 + 1; _yy <= _cellY2; ++_yy) {
		
		if (_isCheck(_tilemapElementId, _cellX1, _yy, _isData)) {
			
			// вычисляем первый столбец
			
			_ang_bl = -1;
			_ang_br = -1;
			
			// left
			if (_isCheck(_tilemapElementId, _cellX1 - 1, _yy, _isData)) {
				++_ang_bl;
				_bitsGrow_H |= 8;
			}
			
			// right
			if (_isCheck(_tilemapElementId, _cellX1 + 1, _yy, _isData)) {
				++_ang_br;
				_bitsGrow_H |= 16;
			}
			
			// bottom
			if (_isCheck(_tilemapElementId, _cellX1, _yy + 1, _isData)) {
				++_ang_bl;
				++_ang_br;
				_bitsGrow_H |= 64;
			}
			
			// bottom-left
			if (_ang_bl and _isCheck(_tilemapElementId, _cellX1 - 1, _yy + 1, _isData))
				_bitsGrow_H |= 32;
			
			// bottom-right
			if (_ang_br and _isCheck(_tilemapElementId, _cellX1 + 1, _yy + 1, _isData))
				_bitsGrow_H |= 128;
			
			tilemap_set(
				_tilemapElementId, 
				global.__tilemapAuto47_table[? ~_bitsGrow_H & 511 | 256] + 1,
				_cellX1, _yy
			);
			
			_bitsGrow_W = ((_bitsGrow_H & 132) >> 2 | (_bitsGrow_H & 16) >> 1);
			_bitsGrow_H = (_bitsGrow_H & 224) >> 5;
		}
		else {	
			_bitsGrow_W = 0;
			_bitsGrow_H = 0;
		}
		
		// вычисляем каждый следующий ряд
		for (_xx = _cellX1 + 1; _xx <= _cellX2; ++_xx) {
			
			if (_isCheck(_tilemapElementId, _xx, _yy, _isData)) {
				
				_ang_tr = tilemap_get(_tilemapElementId, _xx, _yy - 1) - 1;
				if (_ang_tr)
					_bitsGrow_W |= ~(global.__tilemapAuto47_table[? _ang_tr] >> 5) & 7;
				else
				if (_ang_tr == 0)
					_bitsGrow_W |= 7;
					
				_ang_br = -1;
				
				// right
				if (_isCheck(_tilemapElementId, _xx + 1, _yy, _isData)) {
					++_ang_br;
					_bitsGrow_W |= 16;
				}
				
				// bottom
				if (_isCheck(_tilemapElementId, _xx, _yy + 1, _isData)) {
					++_ang_br;
					_bitsGrow_W |= 64;
				}
				
				// bottom-right
				if (_ang_br and _isCheck(_tilemapElementId, _xx + 1, _yy + 1, _isData))
					_bitsGrow_W |= 128;
				
				tilemap_set(
					_tilemapElementId, 
					global.__tilemapAuto47_table[? ~_bitsGrow_W & 511 | 256] + 1,
					_xx, _yy
				);
				
				_bitsGrow_W = ((_bitsGrow_W & 132) >> 2 | (_bitsGrow_W & 16) >> 1);
			}
			else {
				_bitsGrow_W = 0;
			}
		}
	}
	
	#endregion
	
}

#endregion


#region __is

function __tilemapAuto47_region_is(_tilemapElementId, _cellX, _cellY) {
	return tilemap_get(_tilemapElementId, _cellX, _cellY);
}

function __tilemapAuto47_region_is_cd(_tilemapElementId, _cellX, _cellY) {
	_tilemapElementId = tilemap_get(_tilemapElementId, _cellX, _cellY);
	if (_tilemapElementId == -1) return 1;
	return _tilemapElementId;
}

#endregion

