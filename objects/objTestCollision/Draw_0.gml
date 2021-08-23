
var _x1 = mouse_x;
var _y1 = mouse_y;
var _x2 = _x1 + 48;
var _y2 = _y1 + 60;

draw_set_color(c_red);
draw_rectangle(
	self.tilemap_offx - 2, self.tilemap_offy - 2,
	self.tilemap_offx + tilemap_get_width(self.tilemap) * tilemap_get_tile_width(self.tilemap) + 2,
	self.tilemap_offy + tilemap_get_height(self.tilemap) * tilemap_get_tile_height(self.tilemap) + 2,
	true
)

var _colls = tilemapCollsRect(self.tilemap, _x1, _y1, _x2, _y2, 
	function(_tile) {
		return (_tile != 0);
	}, undefined, self.tilemap_offx, self.tilemap_offy);

if (_colls)
	draw_set_color(c_red);
else
	draw_set_color(c_blue);

draw_rectangle(_x1, _y1, _x2, _y2, false);
