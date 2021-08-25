
/*
	Смотри noteTilemapToolsAutotile
	
	Идея заключается в том, что мы модифицируем конкректные биты окружающих нас тайлов,
	устанавливая либо 0 при установки, либо 1 при удалении
	При этом центральную ячейку мы полностью заливаем нужными битами
	
	###########
	## 0 # 1 ##
	## 2 # 3 ##
	###########
*/

#region auto

// set    - установка
// reset  - удаление
// set_cd - режим закрытых краёв

/*
	Ограничение и возможности данной реализации
	1. Расположение тайлов нельзя изменить
	2. На тайлмапе должны находится, только тайлы участвующие в автотайлинге
	(иные тайлы не обрабатываются и это может привести к визуальным/рантайм багам)
	3. Смешивание режимов гарантируется
	4. Вы должны предварительно закрасить тайл индексом 1, или 16
	(в противном случаи, возможны визуальные/рантайм баги)
	5. Предварительные элементы на тайлмапе должны соблюдать логику автотайлинга
	(в противном случаи, возможны визуальные/рантайм баги)
	6. Свойства кроме индекса игнорируются
	(tile_get_mirror, tile_get_rotate, ...)
*/

/// @function		tilemapAuto16_set(tilemap_element_id, cell_x, cell_y);
function tilemapAuto16_set(_tilemapElementId, _cellX, _cellY) {
	
	// center
	tilemap_set(_tilemapElementId, 1, _cellX, _cellY);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, __tilemapAuto16_set, 3)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, __tilemapAuto16_set, 7);  // left-top
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, __tilemapAuto16_set, 11); // right-top
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, __tilemapAuto16_set, 12)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, __tilemapAuto16_set, 13); // left-down
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, __tilemapAuto16_set, 14); // right-down
	}
	
	//
	tilemapModify(_tilemapElementId, _cellX - 1, _cellY, __tilemapAuto16_set, 5);  // left
	tilemapModify(_tilemapElementId, _cellX + 1, _cellY, __tilemapAuto16_set, 10); // right
}

/// @function		tilemapAuto16_set_cd(tilemap_element_id, cell_x, cell_y);
function tilemapAuto16_set_cd(_tilemapElementId, _cellX, _cellY) {
	
	/*
		Режим закрытых краёв, тут просто больше if-ов
	*/
	
	// center
	tilemap_set(_tilemapElementId, 1, _cellX, _cellY);
	
	//
	var _mask_10_l = (tilemapEntry(_tilemapElementId, _cellX - 2, _cellY) ? 5  : 0);
	var _mask_05_r = (tilemapEntry(_tilemapElementId, _cellX + 2, _cellY) ? 10 : 0);
	var _mask_12_t = (tilemapEntry(_tilemapElementId, _cellX, _cellY - 2) ? 3  : 0);
	var _mask_03_d = (tilemapEntry(_tilemapElementId, _cellX, _cellY + 2) ? 12 : 0);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, __tilemapAuto16_set, _mask_12_t)) {
		
		//
		if (_mask_12_t == 0) {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, __tilemapAuto16_set, _mask_10_l); // left-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, __tilemapAuto16_set, _mask_05_r); // right-top
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, __tilemapAuto16_set, 7);  // left-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, __tilemapAuto16_set, 11); // right-top
		}
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, __tilemapAuto16_set, _mask_03_d)) {
		
		//
		if (_mask_03_d == 0) {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, __tilemapAuto16_set, _mask_10_l); // left-down
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, __tilemapAuto16_set, _mask_05_r); // right-down
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, __tilemapAuto16_set, 13); // left-down
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, __tilemapAuto16_set, 14); // right-down
		}
	}
			
	// left
	if (tilemapModify(_tilemapElementId, _cellX - 1, _cellY, __tilemapAuto16_set, _mask_10_l)) {
		
		//
		if (_mask_10_l == 0) {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, __tilemapAuto16_set, _mask_12_t); // left-top
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, __tilemapAuto16_set, _mask_03_d); // left-down
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, __tilemapAuto16_set, 7); // left-top
			tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, __tilemapAuto16_set, 13); // left-down
		}
	}
			
	// right
	if (tilemapModify(_tilemapElementId, _cellX + 1, _cellY, __tilemapAuto16_set, _mask_05_r)) {
		
		//
		if (_mask_05_r == 0) {
			
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, __tilemapAuto16_set, _mask_12_t); // right-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, __tilemapAuto16_set, _mask_03_d); // right-down
		}
		else {
			
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, __tilemapAuto16_set, 11); // right-top
			tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, __tilemapAuto16_set, 14); // right-down
		}
	}
}

/// @function		tilemapAuto16_reset(tilemap_element_id, cell_x, cell_y);
function tilemapAuto16_reset(_tilemapElementId, _cellX, _cellY) {
	
	/*
		Да это копия tilemapAuto16_set
		Да это можно выразить общей функцией для tilemapAuto16_set и tilemapAuto16_reset
		
		Я разделил это по функциям для наглядности
	*/
	
	// center
	tilemap_set(_tilemapElementId, 16, _cellX, _cellY);
	
	// top
	if (tilemapModify(_tilemapElementId, _cellX, _cellY - 1, __tilemapAuto16_reset, 12)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY - 1, __tilemapAuto16_reset, 8); // left-top
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY - 1, __tilemapAuto16_reset, 4); // right-top
	}
	
	// down
	if (tilemapModify(_tilemapElementId, _cellX, _cellY + 1, __tilemapAuto16_reset, 3)) {
		
		//
		tilemapModify(_tilemapElementId, _cellX - 1, _cellY + 1, __tilemapAuto16_reset, 2); // left-down
		tilemapModify(_tilemapElementId, _cellX + 1, _cellY + 1, __tilemapAuto16_reset, 1); // right-down
	}
	
	//
	tilemapModify(_tilemapElementId, _cellX - 1, _cellY, __tilemapAuto16_reset, 10); // left
	tilemapModify(_tilemapElementId, _cellX + 1, _cellY, __tilemapAuto16_reset, 5);  // right
}

/// @function		tilemapAuto16APix_set(tilemap_element_id, x, y);
function tilemapAuto16APix_set(_tilemapElementId, _x, _y) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, tilemapAuto16_set);
}

/// @function		tilemapAuto16APix_set_cd(tilemap_element_id, x, y);
function tilemapAuto16APix_set_cd(_tilemapElementId, _x, _y) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, tilemapAuto16_set_cd);
}

/// @function		tilemapAuto16APix_reset(tilemap_element_id, x, y);
function tilemapAuto16APix_reset(_tilemapElementId, _x, _y) {
	__tilemapCallAPix(_tilemapElementId, _x, _y, tilemapAuto16_reset);
}

#endregion


#region __handler16

function __tilemapAuto16_set(_tile, _value) {
	
	if (_tile > -1) {
		if (_tile == 0) return (_value + 1);
		return ((_value & _tile - 1) + 1);
	}
}

function __tilemapAuto16_reset(_tile, _value) {
	
	if (_tile > -1) {
		
		if (_tile == 0) return (_value + 1);
		//return ((~_value & 15 | _tile - 1) + 1);
		return ((_value | _tile - 1) + 1);
	}
}

#endregion

