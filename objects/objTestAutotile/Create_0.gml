
/*
	Управление
	Общее:
	Q/E - переключение между 16 и 47
	S - сменить режим
	D - отлючить рисование
	C - отчистить тайл
	
	Только для 47:
	F - установить не пустую ячейку
	G - удалить ячейку
	Space - обновить тайлмап
*/

#region tile list

self.tileList = [
	"Tile16", "Tile47"
];

self.tileListObject = [];

self.tileCurrentIndex = 0;
self.tileCurrentTile  = undefined;
self.tileCurrentObj   = undefined;

self.__tileSize = array_length(self.tileList);
self.tileScroll = function(_step) {

	layer_set_visible(self.tileList[self.tileCurrentIndex], false);
	
	self.tileCurrentIndex = 
		(((self.tileCurrentIndex + _step) mod self.__tileSize) + self.__tileSize) mod self.__tileSize;
	
	var _layer = self.tileList[self.tileCurrentIndex];
	
	layer_set_visible(_layer, true);
	self.tileCurrentTile = layer_tilemap_get_id(_layer);
	self.tileCurrentObj  = self.tileListObject[self.tileCurrentIndex];
}

array_resize(self.tileListObject, self.__tileSize);
for (var _i = 0, _t; _i < self.__tileSize; ++_i) {
	
	layer_set_visible(self.tileList[_i], false);
	self.tileListObject[_i] = {};
	
	_t = layer_tilemap_get_id(self.tileList[_i]);
	tilemap_set_width(_t, room_width div tilemap_get_tile_width(_t));
	tilemap_set_height(_t, room_height div tilemap_get_tile_height(_t));
}

self.tileScroll(0);

#endregion

var _obj, _ind = 0;

#region Tile16

_obj = self.tileListObject[_ind++];
_obj.set = [tilemapAuto16APix_set, tilemapAuto16APix_set_cd];
_obj.reset = tilemapAuto16APix_reset;
_obj.draw = function(_value, _x1, _y1, _x2, _y2) {
	// table bits:
	// ###########
	// ## 0 # 1 ##
	// ## 2 # 3 ##
	// ###########
	_value -= 1;
	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_line(_x1, _y1, _x2, _y1);
	draw_line(_x1, _y1, _x1, _y2);
	draw_set_color(c_blue);
	draw_line(_x1, _y2, _x2, _y2);
	draw_line(_x2, _y1, _x2, _y2);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(_x1, _y1, bool(_value & 1));
	draw_set_valign(fa_bottom);
	draw_text(_x1, _y2, bool(_value & 4));
	draw_set_halign(fa_right);
	draw_text(_x2, _y2, bool(_value & 8));
	draw_set_valign(fa_top);
	draw_text(_x2, _y1, bool(_value & 2));
}
_obj.mode = 0;
_obj.addcall = undefined;

#endregion

#region Tile47

_obj = self.tileListObject[_ind++];
_obj.set = [tilemapAuto47APix_set, tilemapAuto47APix_set_cd];
_obj.reset = tilemapAuto47APix_reset;
_obj.draw = function(_value, _x1, _y1, _x2, _y2) {
	// table bits:
	// ###############
	// ## 0 # 1 # 2 ##
	// ## 3 # 8 # 4 ##
	// ## 5 # 6 # 7 ##
	// ###############
	if (_value > 0)
		_value = global.__tilemapAuto47_table[? _value - 1];
	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_line(_x1, _y1, _x2, _y1);
	draw_line(_x1, _y1, _x1, _y2);
	draw_set_color(c_blue);
	draw_line(_x1, _y2, _x2, _y2);
	draw_line(_x2, _y1, _x2, _y2);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(_x1, _y1, bool(_value & 1)); // bit 0
	draw_set_halign(fa_middle);
	draw_text((_x1 + _x2) / 2, _y1, bool(_value & 2)); // bit 1
	draw_set_halign(fa_right);
	draw_text(_x2, _y1, bool(_value & 4)); // bit 2
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(_x1, (_y1 + _y2) / 2, bool(_value & 8)); // bit 3
	draw_set_halign(fa_middle);
	draw_set_color(c_red);
	draw_text((_x1 + _x2) / 2, (_y1 + _y2) / 2, bool(_value & 256)); // bit 8
	draw_set_color(c_black);
	draw_set_halign(fa_right);
	draw_text(_x2, (_y1 + _y2) / 2, bool(_value & 16)); // bit 4
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_text(_x1, _y2, bool(_value & 32)); // bit 5
	draw_set_halign(fa_middle);
	draw_text((_x1 + _x2) / 2, _y2, bool(_value & 64)); // bit 6
	draw_set_halign(fa_right);
	draw_text(_x2, _y2, bool(_value & 128)); // bit 7
}
_obj.mode = 0;
_obj.addcall = function() {
	
	// set
	if (keyboard_check(ord("F"))) {
		
		tilemap_set_at_pixel(self.tileCurrentTile, 1, mouse_x, mouse_y);
	}
	
	// reset
	if (keyboard_check(ord("G"))) {
		
		tilemap_set_at_pixel(self.tileCurrentTile, 0, mouse_x, mouse_y);
	}
	
	// updata
	if (keyboard_check_pressed(vk_space)) {
	
		( self.tileCurrentObj.mode
		? tilemapAuto47_region_cd
		: tilemapAuto47_region)(self.tileCurrentTile,
			0, 0,
			tilemap_get_width(self.tileCurrentTile) - 1,
			tilemap_get_height(self.tileCurrentTile) - 1
		);
	}
}

#endregion

#region setting

self.tileModeCall = function(_tile, _x, _y) {
	var _f = self.tileCurrentObj.set[self.tileCurrentObj.mode];
	_f(_tile, _x, _y);
}

self.tileDebugDraw = true;

#endregion

//
self.depth = -500;

//
//show_debug_overlay(true);
