
//
if (keyboard_check_pressed(ord("1"))) room_goto(roomTestCollision);

// set
if (mouse_check_button(mb_left)) {
	
	self.tileModeCall(self.tileCurrentTile, mouse_x, mouse_y);
}

// reset
if (mouse_check_button(mb_right)) {
	
	self.tileCurrentObj.reset(self.tileCurrentTile, mouse_x, mouse_y);
}

// kind
if (keyboard_check_pressed(ord("Q")))
	self.tileScroll(1);
if (keyboard_check_pressed(ord("E")))
	self.tileScroll(-1);

// mode
if (keyboard_check_pressed(ord("S"))) {
	self.tileCurrentObj.mode = (self.tileCurrentObj.mode + 1) mod 2;
	if (!keyboard_check(vk_alt))
		tilemap_clear(self.tileCurrentTile, 0);
}

// clear
if (keyboard_check_pressed(ord("C"))) {
	
	tilemap_clear(self.tileCurrentTile, 0);
}

// draw
if (keyboard_check_pressed(ord("D"))) {
	self.tileDebugDraw = !self.tileDebugDraw;
}

// addcall
if (is_method(self.tileCurrentObj.addcall)) {
	
	self.tileCurrentObj.addcall();
}
