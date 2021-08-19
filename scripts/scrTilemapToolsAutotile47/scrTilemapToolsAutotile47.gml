
/*
	Смотри noteTilemapToolsAutotile
	Предварительно смотрите scrTilemapToolsAutotile16

	Аналогично scrTilemapToolsAutotile16
	Мы ставим в каждый не пустой тайл на 8 бит 1
	Установка ставит 1, а удаление 0
	
	###############
	## 0 # 1 # 2 ##
	## 3 # 8 # 4 ##
	## 5 # 6 # 7 ##
	###############
*/

#region auto

/*
	Ограничение и возможности данной реализации
	1. Расположение тайлов нельзя изменить
	2. На тайлмапе должны находится, только тайлы участвующие в автотайлинге
	(иные тайлы не обрабатываются и это может привести к рантайм багам)
	3. Смешивание режимов не гарантируется!
	(смешивание режимов приведёт к рантайм багам)
	4. Предварительные элементы на тайлмапе должны соблюдать логику автотайлинга и выбранного режима
	(иначе это приведёт к рантайм багам)
	
	В отличие от тайлинга на 16, режим cd для автотайлинга 47, вводит дополнительную логику, 
	которую нужно обязательно соблюдать (иначе это рантайм ошибки)
	Я не могу описать эту логику, так как я жёстко её запрограммировал tilemapAuto47_set_cd
	
	Здесь так же создаётся таблица для перевода из битов в индексы, и наоборот
*/

/// @function		tilemapAuto47_set(tilemap_element_id, cell_x, cell_y);
function tilemapAuto47_set(_tilemapElementId, _cellX, _cellY) {
	
	//
	if (tilemap_get(_tilemapElementId, _cellX, _cellY) > 0) exit;
	
	//
	var _mathBits;
	var _centerBits = 0;
	
	var _state_l = tilemap_get(_tilemapElementId, _cellX - 1, _cellY) > 1;
	if (_state_l) {
		
		var _leftBits = 16;
		_centerBits |= 8;
	}
	
	var _state_r = tilemap_get(_tilemapElementId, _cellX + 1, _cellY) > 1;
	if (_state_r) {
		
		var _rightBits = 8;
		_centerBits |= 16;
	}
	
	if (tilemap_get(_tilemapElementId, _cellX, _cellY - 1) > 1) {
		
		_centerBits |= 2;
		_mathBits = 64;
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY - 1) > 1) {
			
			_centerBits |= 1;
			_leftBits   |= 4;
			_mathBits   |= 32;
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 303, __tilemapAuto47_reset); // left-top
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY - 1) > 1) {
			
			_centerBits |= 4;
			_rightBits  |= 1;
			_mathBits   |= 128;
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 407, __tilemapAuto47_reset); // right-top
		}
		
		tilemapModify(_tilemapElementId, _cellX, _cellY - 1, _mathBits, __tilemapAuto47_reset_inv); // top
	}
	
	if (tilemap_get(_tilemapElementId, _cellX, _cellY + 1) > 1) {
		
		_centerBits |= 64;
		_mathBits = 2;
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY + 1) > 1) {
			
			_centerBits |= 32;
			_leftBits   |= 128;
			_mathBits   |= 1;
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 489, __tilemapAuto47_reset); // left-down
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY + 1) > 1) {
			
			_centerBits |= 128;
			_rightBits  |= 32;
			_mathBits   |= 4;
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 500, __tilemapAuto47_reset); // right-down
		}
		
		tilemapModify(_tilemapElementId, _cellX, _cellY + 1, _mathBits, __tilemapAuto47_reset_inv); // bottom
	}
	
	if (_state_l) {
		
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY, _leftBits, __tilemapAuto47_reset_inv); // left
	}
	
	if (_state_r) {
		
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY, _rightBits, __tilemapAuto47_reset_inv); // right
	}
	
	tilemapModify(_tilemapElementId, _cellX, _cellY, ~_centerBits & 511 | 256, __tilemapAuto47_set); // center
}

/// @function		tilemapAuto47_set_cd(tilemap_element_id, cell_x, cell_y);
function tilemapAuto47_set_cd(_tilemapElementId, _cellX, _cellY) {
	
	/*
		Да этот код получился довольно страшным
		Это не планируется редактировать никогда!
		
		Я действительно не могу объяснить, что тут происходит
	*/
	
	//
	if (tilemap_get(_tilemapElementId, _cellX, _cellY) > 0) exit;
	
	//
	var _mathBits;
	var _centerBits = 0;
	var _state_l, _state_r, _state_t, _state_d;
	
	#region left
	
	_state_l = tilemap_get(_tilemapElementId, _cellX - 1, _cellY);
	if (_state_l > 1) {
		
		var _leftBits = 16;
		_centerBits |= 8;
	}
	else
	if (_state_l == -1) {
		
		_centerBits |= 8;
	}
	
	#endregion
	
	#region right
	
	_state_r = tilemap_get(_tilemapElementId, _cellX + 1, _cellY);
	if (_state_r > 1) {
		
		var _rightBits = 8;
		_centerBits |= 16;
	}
	else
	if (_state_r == -1) {
		
		_centerBits |= 16;
	}
	
	#endregion
	
	#region top
	
	_state_t = tilemap_get(_tilemapElementId, _cellX, _cellY - 1);
	if (_state_t > 1) {
		
		_centerBits |= 2;
		_mathBits = 64;
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY - 1) > 1) {
			
			_centerBits |= 1;
			_leftBits   |= 4;
			_mathBits   |= 32;
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, 303, __tilemapAuto47_reset); // left-top
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY - 1) > 1) {
			
			_centerBits |= 4;
			_rightBits  |= 1;
			_mathBits   |= 128;
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, 407, __tilemapAuto47_reset); // right-top
		}
		
		tilemapModify(_tilemapElementId, _cellX, _cellY - 1, _mathBits, __tilemapAuto47_reset_inv); // top
	}
	else
	if (_state_t == -1) {
		
		_centerBits |= 2;
		
		if (_state_l != 0) {
			
			_centerBits |= 9;
			if (_state_l) _leftBits |= 4;
		}
		
		if (_state_r != 0) {
			
			_centerBits |= 20;
			if (_state_r) _rightBits |= 1;
		}
	}
	
	#endregion
	
	#region down
	
	_state_d = tilemap_get(_tilemapElementId, _cellX, _cellY + 1);
	if (_state_d > 1) {
		
		_centerBits |= 64;
		_mathBits = 2;
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY + 1) > 1) {
		
			_centerBits |= 32;
			_leftBits   |= 128;
			_mathBits   |= 1;
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, 489, __tilemapAuto47_reset); // left-down
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY + 1) > 1) {
			
			_centerBits |= 128;
			_rightBits  |= 32;
			_mathBits   |= 4;
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, 500, __tilemapAuto47_reset); // right-down
		}
		
		tilemapModify(_tilemapElementId, _cellX, _cellY + 1, _mathBits, __tilemapAuto47_reset_inv); // bottom
	}
	else
	if (_state_d == -1) {
		
		_centerBits |= 64;
		
		if (_state_l != 0) {
			
			_centerBits |= 40;
			if (_state_l) _leftBits |= 128;
		}
		
		if (_state_r != 0) {
			
			_centerBits |= 144;
			if (_state_r) _rightBits |= 32;
		}
	}
	
	#endregion
	
	#region again left
	
	if (_state_l != 0) {
		
		if (_state_l) {
		
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY, _leftBits, __tilemapAuto47_reset_inv);
		}
		else {
			
			if (_state_t > 1) {
				
				_centerBits |= 1;
				tilemapModify(_tilemapElementId, _cellX, _cellY - 1, 479, __tilemapAuto47_reset);
			}
			
			if (_state_d > 1) {
				
				_centerBits |= 32;
				tilemapModify(_tilemapElementId, _cellX, _cellY + 1, 510, __tilemapAuto47_reset);
			}
		}
	}
	
	#endregion
	
	#region again right
	
	if (_state_r != 0) {
		
		if (_state_r) {
			
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY, _rightBits, __tilemapAuto47_reset_inv);
		}
		else {
			
			if (_state_t > 1) {
				
				_centerBits |= 4;
				tilemapModify(_tilemapElementId, _cellX, _cellY - 1, 383, __tilemapAuto47_reset);
			}
			
			if (_state_d > 1) {
				
				_centerBits |= 128;
				tilemapModify(_tilemapElementId, _cellX, _cellY + 1, 507, __tilemapAuto47_reset);
			}
		}
	}
	
	#endregion
	
	tilemapModify(_tilemapElementId, _cellX, _cellY, ~_centerBits & 511 | 256, __tilemapAuto47_set); // center
}

/// @function		tilemapAuto47_reset(tilemap_element_id, cell_x, cell_y);
function tilemapAuto47_reset(tilemapElementId, _cellX, _cellY) {
	
	if (tilemap_get(tilemapElementId, _cellX, _cellY) <= 0) exit;
	tilemap_set(tilemapElementId, 0, _cellX, _cellY);
	
	var _state_l = tilemap_get(tilemapElementId, _cellX - 1, _cellY);
	var _state_r = tilemap_get(tilemapElementId, _cellX + 1, _cellY);
	
	if (_state_l) {
		
		tilemapModify(tilemapElementId, _cellX - 1, _cellY, 148, __tilemapAuto47_set); // left
	}
	
	if (_state_r) {
		
		tilemapModify(tilemapElementId, _cellX + 1, _cellY, 41, __tilemapAuto47_set); // right
	}
	
	if (tilemap_get(tilemapElementId, _cellX, _cellY - 1)) {
		
		tilemapModify(tilemapElementId, _cellX, _cellY - 1, 224, __tilemapAuto47_set); // top
		
		if (_state_l and tilemap_get(tilemapElementId, _cellX - 1, _cellY - 1)) {
			
			tilemapModify(tilemapElementId, _cellX - 1, _cellY - 1, 128, __tilemapAuto47_set); // left-top
		}
		
		if (_state_r and tilemap_get(tilemapElementId, _cellX + 1, _cellY - 1)) {
			
			tilemapModify(tilemapElementId, _cellX + 1, _cellY - 1, 32, __tilemapAuto47_set); // right-top
		}
	}
	
	if (tilemap_get(tilemapElementId, _cellX, _cellY + 1)) {
		
		tilemapModify(tilemapElementId, _cellX, _cellY + 1, 7, __tilemapAuto47_set); // down
		
		if (_state_l and tilemap_get(tilemapElementId, _cellX - 1, _cellY + 1)) {
			
			tilemapModify(tilemapElementId, _cellX - 1, _cellY + 1, 4, __tilemapAuto47_set); // left-down
		}
		
		if (_state_r and tilemap_get(tilemapElementId, _cellX + 1, _cellY + 1)) {
			
			tilemapModify(tilemapElementId, _cellX + 1, _cellY + 1, 1, __tilemapAuto47_set); // right-down
		}
	}
}

/// @function		tilemapAuto47APix_set(tilemap_element_id, x, y);
function tilemapAuto47APix_set(_tilemapElementId, _x, _y) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, tilemapAuto47_set);
}

/// @function		tilemapAuto47APix_set_cd(tilemap_element_id, x, y);
function tilemapAuto47APix_set_cd(_tilemapElementId, _x, _y) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, tilemapAuto47_set_cd);
}

/// @function		tilemapAuto47APix_reset(tilemap_element_id, x, y);
function tilemapAuto47APix_reset(_tilemapElementId, _x, _y) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, tilemapAuto47_reset);
}

#endregion


#region __handler47

function __tilemapAuto47_set(_tile, _value) {
	
	if (_tile > -1) {
		
		if (_tile == 0) return (global.__tilemapAuto47_table[? _value] + 1);
		return (global.__tilemapAuto47_table[? _value | global.__tilemapAuto47_table[? _tile - 1]] + 1);
	}
}

function __tilemapAuto47_reset(_tile, _value) {
	
	if (_tile > -1) {
		
		if (_tile == 0) return (global.__tilemapAuto47_table[? _value] + 1);
		return (global.__tilemapAuto47_table[? _value & global.__tilemapAuto47_table[? _tile - 1]] + 1);
	}
}

function __tilemapAuto47_reset_inv(_tile, _value) {
	
	if (_tile > -1) {
		
		//if (_tile == 0) return (global.__tilemapAuto47_table[? ~_value & 511] + 1);
		return (global.__tilemapAuto47_table[? ~_value & 511 & global.__tilemapAuto47_table[? _tile - 1]] + 1);
	}
}

#endregion

#region __tables

var _order_bits47 = [
	     256, 257, 260, 261, 384, 385, 388,
	389, 288, 289, 292, 293, 416, 417, 420,
	421, 297, 301, 425, 429, 263, 391, 295,
	423, 404, 436, 405, 437, 480, 481, 484,
	485, 445, 487, 303, 431, 407, 439, 500,
	501, 489, 493, 447, 495, 509, 503, 511,
]; // возможно это самое нужное, что тут есть)

global.__tilemapAuto47_table = ds_map_create();

var _size = array_length(_order_bits47);
for (var _i = 0, _bit; _i < _size; ++_i) {
	
	_bit = _order_bits47[_i];
	global.__tilemapAuto47_table[? _i]   = _bit;
	global.__tilemapAuto47_table[? _bit] = _i;
}

#endregion

