
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
for (var _i = 0; _i < self.__tileSize; ++_i) {
	
	layer_set_visible(self.tileList[_i], false);
	self.tileListObject[_i] = {};
}

self.tileScroll(1);

#endregion

var _obj, _ind = 0;

#region Tile16

_obj = self.tileListObject[_ind++];
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
_obj.set = tilemapAuto16APix_set;
_obj.reset = tilemapAuto16APix_reset;

#endregion

#region

_obj = self.tileListObject[_ind++];
_obj.set = tilemapAuto47APix_set;

#endregion

//
self.depth = -500;