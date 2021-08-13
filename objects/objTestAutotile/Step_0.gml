
// set
if (mouse_check_button(mb_left)) {
	
	tilemapAuto16defAPix_set(self.tileCurrentTile, mouse_x, mouse_y);
}

// reset
if (mouse_check_button(mb_right)) {
	
	tilemapAuto16defAPix_reset(self.tileCurrentTile, mouse_x, mouse_y);
}

