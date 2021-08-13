
// set
if (mouse_check_button(mb_left)) {
	
	//self.tileCurrentObj.set(self.tileCurrentTile, mouse_x, mouse_y);
	tilemap_set_at_pixel(self.tileCurrentTile, 1, mouse_x, mouse_y);
}

// reset
if (mouse_check_button(mb_right)) {
	
	//self.tileCurrentObj.reset(self.tileCurrentTile, mouse_x, mouse_y);
	tilemap_set_at_pixel(self.tileCurrentTile, 0, mouse_x, mouse_y);
}

// updata
if (keyboard_check_pressed(vk_space)) {
	
	tilemapAuto16_region(self.tileCurrentTile, 
		0, 0,
		tilemap_get_width(self.tileCurrentTile) - 1, tilemap_get_height(self.tileCurrentTile) - 1, 1);
}

// updata
if (keyboard_check_pressed(vk_control)) {
	
	tilemap_clear(self.tileCurrentTile, 0);
}
