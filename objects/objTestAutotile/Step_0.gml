
// set
if (mouse_check_button(mb_left)) {
	
	self.tileCurrentObj.set(self.tileCurrentTile, mouse_x, mouse_y);
}

// reset
if (mouse_check_button(mb_right)) {
	
	self.tileCurrentObj.reset(self.tileCurrentTile, mouse_x, mouse_y);
}

