
//
if (keyboard_check_pressed(ord("2"))) room_goto(roomTestAutotile);

//
draw_set_color(c_red);
draw_rectangle(
	self.tilemap_offx - 2, self.tilemap_offy - 2,
	self.tilemap_offx + tilemap_get_width(self.tilemap) * tilemap_get_tile_width(self.tilemap) + 2,
	self.tilemap_offy + tilemap_get_height(self.tilemap) * tilemap_get_tile_height(self.tilemap) + 2,
	true,
);

//
self.test_cur.test();

//
if (keyboard_check_pressed(ord("Q"))) self.test_set(0);
if (keyboard_check_pressed(ord("E"))) self.test_set(1);
