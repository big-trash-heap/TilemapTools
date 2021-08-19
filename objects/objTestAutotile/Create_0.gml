
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

#endregion

#region Tile47

_obj = self.tileListObject[_ind++];
_obj.set = [tilemapAuto47APix_set, tilemapAuto47APix_set_cd];
_obj.reset = tilemapAuto47APix_reset;
_obj.draw = function(_value, _x1, _y1, _x2, _y2) {
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

#endregion

#region setting

self.tileModeCd = 0;
self.tileModeCall = function(_tile, _x, _y) {
	var _f = self.tileCurrentObj.set[self.tileModeCd];
	_f(_tile, _x, _y);
}
self.tileModeSwitch = function() {
	if (keyboard_check_pressed(ord("1"))) {
		self.tileModeCd = (self.tileModeCd + 1) mod 2;
		tilemap_clear(self.tileCurrentTile, 0);
	}
}

self.tileKindSwitch = function() {
	if (keyboard_check_pressed(ord("Q")))
		self.tileScroll(1);
	if (keyboard_check_pressed(ord("E")))
		self.tileScroll(-1);
}

#endregion

//
self.depth = -500;