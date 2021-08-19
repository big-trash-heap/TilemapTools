
// set
if (mouse_check_button(mb_left)) {
	
	self.tileModeCall(self.tileCurrentTile, mouse_x, mouse_y);
	//tilemap_set_at_pixel(self.tileCurrentTile, 1, mouse_x, mouse_y);
}

// reset
if (mouse_check_button(mb_right)) {
	
	self.tileCurrentObj.reset(self.tileCurrentTile, mouse_x, mouse_y);
	//tilemap_set_at_pixel(self.tileCurrentTile, 0, mouse_x, mouse_y);
}

// switch
self.tileModeSwitch();
self.tileKindSwitch();

// updata
if (keyboard_check_pressed(vk_control)) {
	
	tilemap_clear(self.tileCurrentTile, 0);
}
